@echo off

rem  #######################    脚本说明     #######################################################
rem  该脚本顺利执行完毕后，调用者将获得的环境变量如下:
rem  JAVA_HOME 				java需要的环境变量
rem  python27_home:         python27所在的目录
rem  svn_bin_dir:           svn.exe所在目录
rem  ANT_HOME:              ant所在的目录
rem  ANDROID_HOME:          android sdk所在目录
rem  NDK_ROOT:              ndk所在目录
rem #######################   脚本说明完  ###########################################################


rem ############################   配置序需要的环境   ####################################
rem java需要的环境变量
set JAVA_HOME=I:\Java\jdk1.8.0_60
set PATH=%JAVA_HOME%\bin;%PATH%
set CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar

rem python需要的环境
set python27_home=I:\Python27
set PATH=%python27_home%;%PATH%

rem svn需要的环境
set svn_bin_dir="D:\Program Files\TortoiseSVN\bin"
set PATH=%svn_bin_dir%;%PATH%

rem ant需要的的环境变量
set ANT_HOME=I:\androiddev\apache-ant-1.9.4
set ANT_ROOT=I:\androiddev\apache-ant-1.9.4\bin
set PATH=%ANT_ROOT%;%PATH%

rem android sdk所在的环境
set ANDROID_SDK_ROOT=I:\androiddev\adt-bundle-windows\sdk
set PATH=%ANDROID_SDK_ROOT%;%PATH%
set PATH=%ANDROID_SDK_ROOT%\tools;%PATH%
set PATH=%ANDROID_SDK_ROOT%\platform-tools;%PATH%

@echo %ANDROID_HOME%
@echo %ANDROID_SDK_ROOT%

rem android ndk所在环境
set NDK_ROOT=I:\androiddev\android-ndk-r10c
set PATH=%NDK_ROOT%;%PATH%
rem ################################# 配置序需要的环境完 ##################################