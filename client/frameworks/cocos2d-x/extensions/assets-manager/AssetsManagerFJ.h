#ifndef __AssetsManager_FJ_INCLUDED__
#define __AssetsManager_FJ_INCLUDED__

#include <string>

#include <mutex>

#include "2d/CCNode.h"
#include "extensions/ExtensionMacros.h"
#include "extensions/ExtensionExport.h"


namespace cocos2d { namespace network {
    class Downloader;
}}

NS_CC_EXT_BEGIN

class AssetsManagerFJDelegateProtocol;

/*
 *  This class is used to auto update resources, such as pictures or scripts.
 *  The updated package should be a zip file. And there should be a file named
 *  version in the server, which contains version code.
 */
class CC_EX_DLL AssetsManagerFJ : public Node
{
public:
    enum class ErrorCode
    {
        // Error caused by creating a file to store downloaded data
        CREATE_FILE,
        /** Error caused by network
         -- network unavailable
         -- timeout
         -- ...
         */
        NETWORK,
        /** There is not a new version
         */
        NO_NEW_VERSION,
        /** Error caused in uncompressing stage
         -- can not open zip file
         -- can not read file global information
         -- can not read file information
         -- can not create a directory
         -- ...
         */
        UNCOMPRESS,
    };
    
    /* @brief Creates a AssetsManagerFJ with new package url, version code url and storage path.
     *
     * @param packageUrl URL of new package, the package should be a zip file.
     * @param versionFileUrl URL of version file. It should contain version code of new package.
     * @param storagePath The path to store downloaded resources.
     * @js NA
     * @lua new
     */
	AssetsManagerFJ(const char* packageUrl = NULL, const char* storagePath = NULL);
    /**
     * @js NA
     * @lua NA
     */
    virtual ~AssetsManagerFJ();
    
    typedef std::function<void(int)> ErrorCallback;
    typedef std::function<void(int)> ProgressCallback;
    typedef std::function<void(void)> SuccessCallback;

    /* @brief To access within scripting environment
     */
    static AssetsManagerFJ* create(const char* packageUrl, const char* storagePath, ErrorCallback errorCallback, ProgressCallback progressCallback, SuccessCallback successCallback );

    /* @brief Check out if there is a new version resource.
     *        You may use this method before updating, then let user determine whether
     *        he wants to update resources.
     */
    bool doUpdate();
    
    using Node::update;
    /* @brief Download new package if there is a new version, and uncompress downloaded zip file.
     *        Ofcourse it will set search path that stores downloaded files.
     */
    void update();
    
    /* @brief Gets url of package.
     */
    const char* getPackageUrl() const;
    
    /* @brief Sets package url.
     */
    void setPackageUrl(const char* packageUrl);
   
    /* @brief Gets storage path.
     */
    const char* getStoragePath() const;
    
    /* @brief Sets storage path.
     *
     * @param storagePath The path to store downloaded resources.
     * @warm The path should be a valid path.
     */
    void setStoragePath(const char* storagePath);
    
    /** @brief Sets delegate, the delegate will receive messages
     * @js NA
     * @lua NA
     */
    void setDelegate(AssetsManagerFJDelegateProtocol *delegate);
    
    /**
     * @js NA
     * @lua NA
     */
	AssetsManagerFJDelegateProtocol* getDelegate() const { return _delegate ;}
    
    /** @brief Sets connection time out in seconds
     */
    void setConnectionTimeout(unsigned int timeout);
    
    /** @brief Gets connection time out in secondes
     */
    unsigned int getConnectionTimeout();

protected:
    void checkStoragePath();
    bool uncompress();
    void setSearchPath();
    void downloadAndUncompress();

private:
    //! The path to store downloaded resources.
    std::string _storagePath;
    
    std::string _packageUrl;
      
    cocos2d::network::Downloader* _downloader;

    unsigned int _connectionTimeout;
    
	AssetsManagerFJDelegateProtocol *_delegate;
    
    bool _isDownloading;
    bool _shouldDeleteDelegateWhenExit;

};

class AssetsManagerFJDelegateProtocol
{
public:
    virtual ~AssetsManagerFJDelegateProtocol(){};
public:
    /* @brief Call back function for error
       @param errorCode Type of error
     * @js NA
     * @lua NA
     */
    virtual void onError(AssetsManagerFJ::ErrorCode errorCode) {};
    /** @brief Call back function for recording downloading percent
        @param percent How much percent downloaded
        @warning    This call back function just for recording downloading percent.
              AssetsManagerFJ will do some other thing after downloading, you should
              write code in onSuccess() after downloading. 
     * @js NA
     * @lua NA
     */
    virtual void onProgress(int percent) {};
    /** @brief Call back function for success
     * @js NA
     * @lua NA
     */
    virtual void onSuccess() {};
};

// Deprecated declaration
CC_DEPRECATED_ATTRIBUTE typedef AssetsManagerFJ CCAssetsManagerFJ;
CC_DEPRECATED_ATTRIBUTE typedef AssetsManagerFJDelegateProtocol CCAssetsManagerFJDelegateProtocol;

NS_CC_EXT_END;

#endif /* defined(__AssetsManager_FJ_INCLUDED__) */
