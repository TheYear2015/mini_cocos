rem flyandroid.bat����Ŀ¼
set codedir=%~dp0\..\client

rem ����boot
CALL %~dp0\boot.bat
set cocosBin=%~dp0\..\client\cocos2d-console\bin\cocos.bat
set PATH=%~dp0\..\client\cocos2d-console\bin;%PATH%

rem �����ű�����apk
%cocosBin% compile -s %codedir% -p android -m release --lua-encrypt --lua-encrypt-key (dsf)98$#mBYU331KJuf --lua-encrypt-sign sign-fengwei --compile-script 0

rem �������ű�����apk
rem %cocosBin% compile -s %codedir% -p android -m release --lua-encrypt-key 6b7647fd2d9519f4f53beef4bf54c2e862a47ae2 --lua-encrypt-sign sign-399-09-01-2102-fengwei

rem ֻ�����ű�
rem %cocosBin% luacompile -s %codedir%\src\hall\ -d  %codedir%\publish\hall\ -e -key 6b7647fd2d9519f4f53beef4bf54c2e862a47ae2 -b sign-fengwei --disable-compile

pause