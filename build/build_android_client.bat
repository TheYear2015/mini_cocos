rem flyandroid.bat所在目录
set codedir=%~dp0\..\client

rem 调用boot
CALL %~dp0\boot.bat
set cocosBin=%~dp0\..\client\cocos2d-console\bin\cocos.bat
set PATH=%~dp0\..\client\cocos2d-console\bin;%PATH%

rem 混淆脚本生成apk
%cocosBin% compile -s %codedir% -p android -m release --lua-encrypt --lua-encrypt-key (dsf)98$#mBYU331KJuf --lua-encrypt-sign sign-fengwei --compile-script 0

rem 不混淆脚本生成apk
rem %cocosBin% compile -s %codedir% -p android -m release --lua-encrypt-key 6b7647fd2d9519f4f53beef4bf54c2e862a47ae2 --lua-encrypt-sign sign-399-09-01-2102-fengwei

rem 只混淆脚本
rem %cocosBin% luacompile -s %codedir%\src\hall\ -d  %codedir%\publish\hall\ -e -key 6b7647fd2d9519f4f53beef4bf54c2e862a47ae2 -b sign-fengwei --disable-compile

pause