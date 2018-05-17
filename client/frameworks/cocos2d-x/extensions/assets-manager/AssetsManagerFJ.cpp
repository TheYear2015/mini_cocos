#include "AssetsManagerFJ.h"

#include <thread>

#include "base/CCDirector.h"
#include "base/CCScheduler.h"
#include "network/CCDownloader.h"
#include "platform/CCFileUtils.h"

#ifdef MINIZIP_FROM_SYSTEM
#include <minizip/unzip.h>
#else // from our embedded sources
#include "unzip.h"
#endif

NS_CC_EXT_BEGIN;

using namespace std;
using namespace cocos2d;
using namespace cocos2d::network;

#define TEMP_PACKAGE_FILE_NAME          "cocos2dx-update-temp-package.zip"
#define BUFFER_SIZE    8192
#define MAX_FILENAME   512

// Implementation of AssetsManagerFJ

AssetsManagerFJ::AssetsManagerFJ(const char* packageUrl/* =nullptr */, const char* storagePath/* =nullptr */)
:  _storagePath(storagePath ? storagePath : "")
, _packageUrl(packageUrl ? packageUrl : "")
, _downloader(new Downloader())
, _connectionTimeout(0)
, _delegate(nullptr)
, _isDownloading(false)
, _shouldDeleteDelegateWhenExit(false)
{
    // convert downloader error code to AssetsManager::ErrorCode
    _downloader->onTaskError = [this](const DownloadTask& task,
                                      int errorCode,
                                      int errorCodeInternal,
                                      const std::string& errorStr)
    {
        _isDownloading = false;
        
        if (nullptr == _delegate)
        {
            return;
        }
        auto err = (DownloadTask::ERROR_FILE_OP_FAILED == errorCode) ? ErrorCode::CREATE_FILE : ErrorCode::NETWORK;
        _delegate->onError(err);
    };
    
    // progress callback
    _downloader->onTaskProgress = [this](const DownloadTask& task,
                                         int64_t bytesReceived,
                                         int64_t totalBytesReceived,
                                         int64_t totalBytesExpected)
    {
        if(FileUtils::getInstance()->getFileExtension(task.requestURL) != ".zip")
        {
            // get version progress don't report
            return;
        }
        
        if (nullptr == _delegate)
        {
            return;
        }
        
        int percent = totalBytesExpected ? int(totalBytesReceived * 100 / totalBytesExpected) : 0;
        _delegate->onProgress(percent);
        CCLOG("downloading... %d%%", percent);
    };
    
    // after download package, do uncompress operation
    _downloader->onFileTaskSuccess = [this](const DownloadTask& task)
    {
        downloadAndUncompress();
    };
}

AssetsManagerFJ::~AssetsManagerFJ()
{
    if (_shouldDeleteDelegateWhenExit)
    {
        delete _delegate;
    }
    CC_SAFE_DELETE(_downloader);
}

void AssetsManagerFJ::checkStoragePath()
{
    if (_storagePath.size() > 0 && _storagePath[_storagePath.size() - 1] != '/')
    {
        _storagePath.append("/");
    }
}

// Multiple key names
static std::string keyWithHash( const char* prefix, const std::string& url )
{
    char buf[256];
    sprintf(buf,"%s%zd",prefix,std::hash<std::string>()(url));
    return buf;
}

bool AssetsManagerFJ::doUpdate()
{
	if (_isDownloading)
		return false;
	// start download;
	_isDownloading = true;
	const string outFileName = _storagePath + TEMP_PACKAGE_FILE_NAME;
	_downloader->createDownloadFileTask(_packageUrl, outFileName);
    return true;
}

void AssetsManagerFJ::downloadAndUncompress()
{
    std::thread([this]()
    {
        do
        {
            // Uncompress zip file.
            if (! uncompress())
            {
                Director::getInstance()->getScheduler()->performFunctionInCocosThread([&, this]{
                    if (this->_delegate)
                        this->_delegate->onError(ErrorCode::UNCOMPRESS);
                });
                break;
            }
            
            Director::getInstance()->getScheduler()->performFunctionInCocosThread([&, this] {
                // Delete unloaded zip file.
                string zipfileName = this->_storagePath + TEMP_PACKAGE_FILE_NAME;
                if (remove(zipfileName.c_str()) != 0)
                {
                    CCLOG("can not remove downloaded zip file %s", zipfileName.c_str());
                }
                
                if (this->_delegate) this->_delegate->onSuccess();
            });
            
        } while (0);
        
        _isDownloading = false;

    }).detach();
}

void AssetsManagerFJ::update()
{
    // all operation in checkUpdate, nothing need to do
    // keep this function for compatibility
}

bool AssetsManagerFJ::uncompress()
{
    // Open the zip file
    string outFileName = _storagePath + TEMP_PACKAGE_FILE_NAME;
    unzFile zipfile = unzOpen(outFileName.c_str());
    if (! zipfile)
    {
        CCLOG("can not open downloaded zip file %s", outFileName.c_str());
        return false;
    }
    
    // Get info about the zip file
    unz_global_info global_info;
    if (unzGetGlobalInfo(zipfile, &global_info) != UNZ_OK)
    {
        CCLOG("can not read file global info of %s", outFileName.c_str());
        unzClose(zipfile);
        return false;
    }
    
    // Buffer to hold data read from the zip file
    char readBuffer[BUFFER_SIZE];
    
    CCLOG("start uncompressing");
    
    // Loop to extract all files.
    uLong i;
    for (i = 0; i < global_info.number_entry; ++i)
    {
        // Get info about current file.
        unz_file_info fileInfo;
        char fileName[MAX_FILENAME];
        if (unzGetCurrentFileInfo(zipfile,
                                  &fileInfo,
                                  fileName,
                                  MAX_FILENAME,
                                  nullptr,
                                  0,
                                  nullptr,
                                  0) != UNZ_OK)
        {
            CCLOG("can not read file info");
            unzClose(zipfile);
            return false;
        }
        
        const string fullPath = _storagePath + fileName;
        
        // Check if this entry is a directory or a file.
        const size_t filenameLength = strlen(fileName);
        if (fileName[filenameLength-1] == '/')
        {
            // Entry is a directory, so create it.
            // If the directory exists, it will failed silently.
            if (!FileUtils::getInstance()->createDirectory(fullPath))
            {
                CCLOG("can not create directory %s", fullPath.c_str());
                unzClose(zipfile);
                return false;
            }
        }
        else
        {
            //There are not directory entry in some case.
            //So we need to test whether the file directory exists when uncompressing file entry
            //, if does not exist then create directory
            const string fileNameStr(fileName);
            
            size_t startIndex=0;
            
            size_t index=fileNameStr.find("/",startIndex);
            
            while(index != std::string::npos)
            {
                const string dir=_storagePath+fileNameStr.substr(0,index);
                
                FILE *out = fopen(FileUtils::getInstance()->getSuitableFOpen(dir).c_str(), "r");
                
                if(!out)
                {
                    if (!FileUtils::getInstance()->createDirectory(dir))
                    {
                        CCLOG("can not create directory %s", dir.c_str());
                        unzClose(zipfile);
                        return false;
                    }
                    else
                    {
                        CCLOG("create directory %s",dir.c_str());
                    }
                }
                else
                {
                    fclose(out);
                }
                
                startIndex=index+1;
                
                index=fileNameStr.find("/",startIndex);
                
            }

            // Entry is a file, so extract it.
            
            // Open current file.
            if (unzOpenCurrentFile(zipfile) != UNZ_OK)
            {
                CCLOG("can not open file %s", fileName);
                unzClose(zipfile);
                return false;
            }
            
            // Create a file to store current file.
            FILE *out = fopen(FileUtils::getInstance()->getSuitableFOpen(fullPath).c_str(), "wb");
            if (! out)
            {
                CCLOG("can not open destination file %s", fullPath.c_str());
                unzCloseCurrentFile(zipfile);
                unzClose(zipfile);
                return false;
            }
            
            // Write current file content to destinate file.
            int error = UNZ_OK;
            do
            {
                error = unzReadCurrentFile(zipfile, readBuffer, BUFFER_SIZE);
                if (error < 0)
                {
                    CCLOG("can not read zip file %s, error code is %d", fileName, error);
                    unzCloseCurrentFile(zipfile);
                    unzClose(zipfile);
                    return false;
                }
                
                if (error > 0)
                {
                    fwrite(readBuffer, error, 1, out);
                }
            } while(error > 0);
            
            fclose(out);
        }
        
        unzCloseCurrentFile(zipfile);
        
        // Goto next entry listed in the zip file.
        if ((i+1) < global_info.number_entry)
        {
            if (unzGoToNextFile(zipfile) != UNZ_OK)
            {
                CCLOG("can not read next file");
                unzClose(zipfile);
                return false;
            }
        }
    }
    
    CCLOG("end uncompressing");
    unzClose(zipfile);
    
    return true;
}

void AssetsManagerFJ::setSearchPath()
{
    vector<string> searchPaths = FileUtils::getInstance()->getSearchPaths();
    vector<string>::iterator iter = searchPaths.begin();
    searchPaths.insert(iter, _storagePath);
    FileUtils::getInstance()->setSearchPaths(searchPaths);
}

const char* AssetsManagerFJ::getPackageUrl() const
{
    return _packageUrl.c_str();
}

void AssetsManagerFJ::setPackageUrl(const char *packageUrl)
{
    _packageUrl = packageUrl;
}

const char* AssetsManagerFJ::getStoragePath() const
{
    return _storagePath.c_str();
}

void AssetsManagerFJ::setStoragePath(const char *storagePath)
{
    _storagePath = storagePath;
    checkStoragePath();
}

void AssetsManagerFJ::setDelegate(AssetsManagerFJDelegateProtocol *delegate)
{
    _delegate = delegate;
}

void AssetsManagerFJ::setConnectionTimeout(unsigned int timeout)
{
    _connectionTimeout = timeout;
}

unsigned int AssetsManagerFJ::getConnectionTimeout()
{
    return _connectionTimeout;
}

AssetsManagerFJ* AssetsManagerFJ::create(const char* packageUrl, const char* storagePath, ErrorCallback errorCallback, ProgressCallback progressCallback, SuccessCallback successCallback )
{
    class DelegateProtocolImpl : public AssetsManagerFJDelegateProtocol 
    {
    public :
        DelegateProtocolImpl(ErrorCallback aErrorCallback, ProgressCallback aProgressCallback, SuccessCallback aSuccessCallback)
        : errorCallback(aErrorCallback), progressCallback(aProgressCallback), successCallback(aSuccessCallback)
        {}

        virtual void onError(AssetsManagerFJ::ErrorCode errorCode) { errorCallback(int(errorCode)); }
        virtual void onProgress(int percent) { progressCallback(percent); }
        virtual void onSuccess() { successCallback(); }

    private :
        ErrorCallback errorCallback;
        ProgressCallback progressCallback;
        SuccessCallback successCallback;
    };

    auto* manager = new (std::nothrow) AssetsManagerFJ(packageUrl,storagePath);
    auto* delegate = new (std::nothrow) DelegateProtocolImpl(errorCallback,progressCallback,successCallback);
    manager->setDelegate(delegate);
    manager->_shouldDeleteDelegateWhenExit = true;
    manager->autorelease();
    return manager;
}

NS_CC_EXT_END;
