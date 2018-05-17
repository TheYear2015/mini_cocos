@echo off

rem  #######################    �ű�˵��     #######################################################
rem  �ýű�˳��ִ����Ϻ󣬵����߽���õĻ�����������:
rem  JAVA_HOME 				java��Ҫ�Ļ�������
rem  python27_home:         python27���ڵ�Ŀ¼
rem  svn_bin_dir:           svn.exe����Ŀ¼
rem  ANT_HOME:              ant���ڵ�Ŀ¼
rem  ANDROID_HOME:          android sdk����Ŀ¼
rem  NDK_ROOT:              ndk����Ŀ¼
rem #######################   �ű�˵����  ###########################################################


rem ############################   ��������Ҫ�Ļ���   ####################################
rem java��Ҫ�Ļ�������
set JAVA_HOME=I:\Java\jdk1.8.0_60
set PATH=%JAVA_HOME%\bin;%PATH%
set CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar

rem python��Ҫ�Ļ���
set python27_home=I:\Python27
set PATH=%python27_home%;%PATH%

rem svn��Ҫ�Ļ���
set svn_bin_dir="D:\Program Files\TortoiseSVN\bin"
set PATH=%svn_bin_dir%;%PATH%

rem ant��Ҫ�ĵĻ�������
set ANT_HOME=I:\androiddev\apache-ant-1.9.4
set ANT_ROOT=I:\androiddev\apache-ant-1.9.4\bin
set PATH=%ANT_ROOT%;%PATH%

rem android sdk���ڵĻ���
set ANDROID_SDK_ROOT=I:\androiddev\adt-bundle-windows\sdk
set PATH=%ANDROID_SDK_ROOT%;%PATH%
set PATH=%ANDROID_SDK_ROOT%\tools;%PATH%
set PATH=%ANDROID_SDK_ROOT%\platform-tools;%PATH%

@echo %ANDROID_HOME%
@echo %ANDROID_SDK_ROOT%

rem android ndk���ڻ���
set NDK_ROOT=I:\androiddev\android-ndk-r10c
set PATH=%NDK_ROOT%;%PATH%
rem ################################# ��������Ҫ�Ļ����� ##################################