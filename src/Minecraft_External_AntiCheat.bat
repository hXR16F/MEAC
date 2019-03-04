:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off
setlocal EnableDelayedExpansion
mode 80,25
(
	set "version=7.0 Stable"
	set "title_spaced=Minecraft External AntiCheat"
	set "title=Minecraft_External_AntiCheat"
)
rem set "full_title=%title_spaced% - %version%"
set "full_title=MEAC"
title !full_title!
color 0F

set "missing=0"
for %%n in (
	"EXT"	"EXT/BrowsingHistoryView.cfg"	"EXT/BrowsingHistoryView.exe"	"EXT/LastActivityView.cfg"	"EXT/LastActivityView.exe"	"EXT/7z.exe"	"EXT/7z.dll"	"EXT/GUIPropView.exe"	"EXT/GUIPropView.cfg"	"_download.dll"	"_inputbox.dll"	"_md5.dll"	"_output.exe" "_rc4.dll"	"_wbusy.dll"	"db_01.rc4"	"db_02.rc4"	"db_03.rc4"	"db_04.rc4" "db_05.rc4"
) do (
	if not exist "%%n" (
		echo Missing : %%n
		set "missing=1"
	)
)
if "%missing%" EQU "1" (
	for /L %%n in (0,0,1) do pause > nul
)
if exist "OUTPUT" rd /S /Q "OUTPUT" > nul

rem _bg.dll font 5 & _bg.dll cursor 0
rem _cmdwiz.dll setwindowtransparency 100 & _cmdwiz.dll getdisplaydim h
if "%ERRORLEVEL%" LEQ "900" (
	rem mode 61,55
) else (
	rem mode 61,70
)
rem _cmdwiz.dll setbuffersize 61 190
rem _cmdfocus.dll /center

if exist "Minecraft_External_AntiCheat.ini" (
	set "tempvar=1"
	for /F "tokens=1,2* delims=	//" %%i in (Minecraft_External_AntiCheat.ini) do (
		(
			if "!tempvar!" EQU "1" set "exeBuild=%%i"
			if "!tempvar!" EQU "2" set "updateChecker=%%i"
			if "!tempvar!" EQU "3" set "enableLogDetails=%%i"
			if "!tempvar!" EQU "4" set "enableLastActivityView=%%i"
			if "!tempvar!" EQU "5" set "enableBrowsingHistoryView=%%i"
			if "!tempvar!" EQU "6" set "enableBlazingPackFinder=%%i"
			set /A tempvar+=1
		)
	)
) else (
	(
		set "exeBuild=0"
		set "updateChecker=1"
		set "enableLogDetails=1"
		set "enableLastActivityView=0"
		set "enableBrowsingHistoryView=1"
		set "enableBlazingPackFinder=1"
	)
)
if not exist "OUTPUT" md OUTPUT

for %%n in (
	"a_0=hXR"	"a_1=16F"	"f=F"	"j=K"	"o=0"	"c=R"	"y=o"	"k=Y"	"g=t"	"d=1"	"a=h"	"m=V"	"z=U"	"u=p"	"n=8"	"h=H"	"l=m"	"e=6"	"t=Z"	"b=X"	"i=w"
) do set %%~n
set "pwd=%a%%b%%c%%d%%e%%f%_%o%%o%0"

set "curr_dir=%cd%"
set "rand00=%random%%random%"
call :deleteTempFiles & call :deleteTempFile EXT/LAV/temp_13 & call :deleteTempFile EXT/BHV/temp_14

:: Main
cls
set "mcdir=%appdata%\.minecraft"
_inputbox.dll "%title_spaced%" "Paste Minecraft directory here (or leave blank for default)." "" > temp_09
for /F "tokens=1,2* delims= " %%i in (temp_09) do (
	if not "%%i%%j%%k" EQU "" (
		set "mcdir=%%i%%j%%k"
	) else (
		set "mcdir=%appdata%\.minecraft"
	)
)
call :deleteTempFile temp_09

:: Utilities that requires admin privileges. It must be before progress bar.
if "%enableLastActivityView%" EQU "1" (
	cd EXT & LastActivityView.exe /stab temp_13 & cd "%curr_dir%"
) else (
	echo Nothing here... >> "OUTPUT/autoClickers_Macros.txt"
)

:: Progress bar
(
	if exist "%temp%\_wbusy.dll" del /F /Q "%temp%\_wbusy.dll"
	if exist "%temp%\_wbusy.exe" del /F /Q "%temp%\_wbusy.exe"
)
copy "_wbusy.dll" "%temp%" > nul
cd %temp%
ren "_wbusy.dll" "_wbusy.exe"
start _wbusy "Minecraft External AntiCheat" "Scanning..." /marquee
cd %curr_dir%

:: Update checker
if "%updateChecker%" EQU "1" (
	if !updateChecker! EQU 1 (
		_download.dll http://minecraft-external-anticheat.5v.pl/files/version.txt temp_11 > nul && (
			set /P latest_version=<temp_11
			if "!latest_version!" EQU "!version!" (
				echo Version '!version!' is latest. >> "OUTPUT/update.txt"
			) else (
				if defined version (
					(
						echo Version '!version!' is outdated. >> "OUTPUT/update.txt"
						echo Latest version is '!latest_version!'. >> "OUTPUT/update.txt"
					)
				) else (
					echo Error: Version is not defined. >> "OUTPUT/update.txt"
				)
			)
		) || (
			ping www.google.com -n 1 > nul && (
				echo Error: 404 >> "OUTPUT/update.txt"
			) || (
				ping www.minecraft-external-anticheat.5v.pl -n 1 > nul && (
					echo Error: Cannot download file. >> "OUTPUT/update.txt"
				) || (
					echo Error: No Internet connection. >> "OUTPUT/update.txt"
				)
			)
		)
	)
	call :deleteTempFile temp_11
)

:: Minecraft folders [APPDATA]
_rc4.dll %pwd% db_03.rc4 temp_08
cd %mcdir% & cd..
dir /B /A:D > temp_07
move "temp_07" "%curr_dir%" > nul
cd %curr_dir%

set "tempvar=0"
for /F "tokens=1,2* delims= " %%i in (temp_08) do (
	find /I "%%i%%j%%k" temp_07 > nul && (
		echo %%i%%j%%k >> "OUTPUT/minecraftFolders.txt"
		set "tempvar=1"
	)
)
if "%tempvar%" EQU "0" (
	echo No Minecraft folders detected. >> "OUTPUT/minecraftFolders.txt"
)
call :deleteTempFile temp_07 & call :deleteTempFile temp_08

:: Installed hacked clients [NAME]
_rc4.dll %pwd% db_01.rc4 temp_03
cd %mcdir%\versions >nul 2>&1
dir /B /A:D > temp_00
move "temp_00" "%curr_dir%" > nul
cd %curr_dir%

set "tempvar=0"
for /F "tokens=1,2* delims= " %%i in (temp_03) do (
	find /I "%%i%%j%%k" temp_00 > nul && (
		echo %%i%%j%%k >> "OUTPUT/installedHackedClients_NAME.txt"
		set "tempvar=1"
	)
)
if "%tempvar%" EQU "0" (
	echo No hacked clients installed. >> "OUTPUT/installedHackedClients_NAME.txt"
)
call :deleteTempFile temp_03

:: Installed hacked clients [HASH] 1.7 -> 1.8
_rc4.dll %pwd% db_02.rc4 temp_04
set "tempvar=0"
for /F "tokens=1,2* delims= " %%i in (temp_00) do (
	set "aa=%%i%%j%%k"
	if exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" (
		rd "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" >nul 2>&1
	)
	if exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" (
		_md5.dll "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" > temp_01
		for /F "tokens=1,2* delims= " %%i in (temp_01) do (
			set "temp_sum=%%i%%j%%k"
		)
		find /I "!temp_sum!" temp_04 > nul && (
			set "tempvar=1"
			echo !aa! >> "OUTPUT/installedHackedClients_HASH.txt"
		)
	)
)
if "%tempvar%" EQU "0" (
	echo No hacked clients installed. >> "OUTPUT/installedHackedClients_HASH.txt"
)
call :deleteTempFile temp_01 & call :deleteTempFile temp_04

:: Newest versions of Minecraft can be detected as cheats.
:: Installed hacked clients [SIZE] >10 MB
set "tempvar=0"
for /F "tokens=1,2* delims= " %%i in (temp_00) do (
	set "aa=%%i%%j%%k"
	if exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" (
		rd "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" >nul 2>&1
	)
	if exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" (
		for %%? in (!mcdir!\versions\!aa!\!aa!.jar) do (
			set /A "ab=%%~z?/1024/1024"
			if /I !ab! GEQ 10 (
				set "tempvar=1"
				echo !aa! >> "OUTPUT/installedHackedClients_SIZE.txt"
			)
		)
	)
)
if "%tempvar%" EQU "0" (
	echoNo hacked clients installed. >> "OUTPUT/installedHackedClients_SIZE.txt"
)

:: Bypasses client-side version spoofer and protected files!
:: Running versions
for /F "tokens=1,2* delims=" %%i in (temp_00) do (
	if exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" (
		if "%enableBlazingPackFinder%" EQU "1" (
			if exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%kAPP.jar" (
				set "tempvar=0" & set "tempvar2=0" & set "tempvar3=0" & set "tempvar4=0"
				cd EXT
				7z.exe l "!mcdir!\versions\%%i%%j%%k\%%i%%j%%kAPP.jar" >> tempvar.txt
				GUIPropView.exe /stab tempvar4.txt
				(
					find /N "blazingpack" tempvar.txt >> tempvar2.txt
					find /N "blazingpack" "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.json" >> tempvar3.txt
				)
				for /F "tokens=1,2* delims=" %%i in (tempvar2.txt) do (
					set /A tempvar2+=1
				)
				for /F "tokens=1,2* delims=" %%i in (tempvar3.txt) do (
					set /A tempvar3+=1
				)
				cd..
			)
		)
		ren "!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar" "_%%i%%j%%k_!rand00!.jar" >nul 2>&1 && (
			echo %%i%%j%%k > nul
		) || (
			for %%? in (!mcdir!\versions\%%i%%j%%k\%%i%%j%%k.jar) do (
				set /A "ab=%%~z?/1024/1024"
				set "tempvar_%%i%%j%%k=!ab!"
			)
			set "running=1"
			if "%enableBlazingPackFinder%" EQU "1" (
				if !tempvar2! GEQ 10 (
					if !tempvar3! GEQ 2 (
						if not exist "!mcdir!\versions\%%i%%j%%k\%%i%%j%%kApp.jar.tmp" (
							find /I "BlazingPack.pl" "EXT\tempvar4.txt" >nul && (
								echo %%i%%j%%k^(BlazingPack^) >> "OUTPUT/runningVersions.txt"
								for /L %%n in (2,1,3) do (
									set "tempvar%%n=0"
								)
								for %%n in (
									"tempvar.txt"	"tempvar2.txt"	"tempvar3.txt"	"tempvar4.txt"
								) do (
									if exist %%n del /F /Q %%n >nul 2>&1
								)
							) || (
								echo %%i%%j%%k^(!tempvar_%%i%%j%%k! MB^) >> "OUTPUT/runningVersions.txt"
							)
						) else (
							echo %%i%%j%%k^(!tempvar_%%i%%j%%k! MB^) >> "OUTPUT/runningVersions.txt"
						)
					) else (
						echo %%i%%j%%k^(!tempvar_%%i%%j%%k! MB^) >> "OUTPUT/runningVersions.txt"
					)
				) else (
					echo %%i%%j%%k^(!tempvar_%%i%%j%%k! MB^) >> "OUTPUT/runningVersions.txt"
				)
			) else (
				echo %%i%%j%%k^(!tempvar_%%i%%j%%k! MB^) >> "OUTPUT/runningVersions.txt"
			)
		)
	)
	if exist "!mcdir!\versions\%%i%%j%%k\_%%i%%j%%k_!rand00!.jar" (
		ren "!mcdir!\versions\%%i%%j%%k\_%%i%%j%%k_!rand00!.jar" "%%i%%j%%k.jar" >nul 2>&1
	)
)
if not "%running%" EQU "1" (
	echo No versions running. >> "OUTPUT/runningVersions.txt"
)
call :deleteTempFile temp_00

:: Also shows hidden folders!
:: Cheat folders
_rc4.dll %pwd% db_01.rc4 temp_03

cd %mcdir%
dir /B /A:D > temp_05
move "temp_05" "%curr_dir%" > nul
cd %curr_dir%
set "tempvar=0"

for /F "tokens=1,2* delims= " %%i in (temp_03) do (
	attrib -H "%%i%%j%%k" > nul
	find /I "%%i%%j%%k" temp_05 > nul && (
		echo %%i%%j%%k >> "OUTPUT/cheatFolders.txt"
		set "tempvar=1"
	)
)
if "%tempvar%" EQU "0" (
	echo No cheats folders installed. >> "OUTPUT/cheatFolders.txt"
)
call :deleteTempFile temp_03 & call :deleteTempFile temp_05

:: Installed mods
if exist "%mcdir%\mods" (
	if exist "temp_06" (
		del /F /Q "temp_06" >nul 2>&1
	)
	cd %mcdir%\mods >nul 2>&1
	echo. > %rand00%.jar & echo. > %rand00%.litemod
	dir /B *.jar *.litemod > temp_06
	move "temp_06" "%curr_dir%" > nul
	cd %curr_dir%
)

set "tempvar=0"
if exist "temp_06" (
	for /F "tokens=1,2* delims= " %%i in (temp_06) do (
		if not "%%i%%j%%k" EQU "%rand00%.jar" (
			if not "%%i%%j%%k" EQU "%rand00%.litemod" (
				echo %%i%%j%%k >> "OUTPUT/installedMods.txt"
				set "tempvar=1"
			)
		)
	)
)
(
	if exist "%mcdir%\mods\%rand00%.jar" del /F /Q "%mcdir%\mods\%rand00%.jar"
	if exist "%mcdir%\mods\%rand00%.litemod" del /F /Q "%mcdir%\mods\%rand00%.litemod"
)
if "%tempvar%" EQU "0" (
	echo No mods installed. >> "OUTPUT/installedMods.txt"
)
call :deleteTempFile temp_06

:: Bypasses "Ghost/Undetectable" AutoClicker/Macros.
:: Running AutoClickers/Macros [LAV] >4 Hours
if "%enableLastActivityView%" EQU "1" (
	_rc4.dll %pwd% db_04.rc4 temp_12
	cd EXT
	if exist "temp_13" (
		move "temp_13" "%curr_dir%" > nul
	) else (
		cd "%curr_dir%" & echo Error: File doesn't exist. >> "OUTPUT/autoClickers_Macros.txt"
		call :deleteTempFile temp_14 & call :deleteTempFile temp_03
		goto next_01
	)
	cd "%curr_dir%"
	
	set "tempvar=0"
	for /F "tokens=1,2* delims=" %%i in (temp_12) do (
		find /I "%%i%%j%%k" temp_13 > nul && (
			set /A "tempvar+=1"
		)
	)
	if "!tempvar!" EQU "0" (
		echo No AutoClickers/Macros running. >> "OUTPUT/autoClickers_Macros.txt"
	) else (
		if "!tempvar!" GTR "1" (
			echo AutoClicker/Macro detected : !tempvar! entries. >> "OUTPUT/autoClickers_Macros.txt"
		) else (
			echo AutoClicker/Macro detected : !tempvar! entry. >> "OUTPUT/autoClickers_Macros.txt"
		)
	)
	call :deleteTempFile temp_13 & call :deleteTempFile temp_12
)

:next_01
:: Browsing History [BHV] >6 Hours
if "%enableBrowsingHistoryView%" EQU "1" (
	_rc4.dll %pwd% db_01.rc4 temp_03 & _rc4.dll %pwd% db_05.rc4 temp_15
	cd EXT
	BrowsingHistoryView.exe /stab temp_14
	if exist "temp_14" (
		move "temp_14" "%curr_dir%" > nul
	) else (
		cd "%curr_dir%" & echo Error: File doesn't exist. >> "OUTPUT/browsingHistory.txt"
		call :deleteTempFile temp_14 & call :deleteTempFile temp_03
		goto next_00
	)
	cd "%curr_dir%"
	
	set "tempvar=0"
	for /F "tokens=1,2* delims=" %%i in (temp_03) do (
		find /I "%%i%%j%%k" temp_14 > nul && (
			find /I "%%i%%j%%k" temp_15 > nul && (
				:: Do nothing
				echo. > nul
			) || (
				set /A "tempvar+=1"
				echo %%i%%j%%k >> "OUTPUT/browsingHistory.txt"
			)
		)
	)
	if "!tempvar!" EQU "0" (
		echo Browsing history is clean. >> "OUTPUT/browsingHistory.txt"
	)
	call :deleteTempFile temp_14 & call :deleteTempFile temp_03 & call :deleteTempFile temp_15
)

:next_00
:: Log details
if "%enableLogDetails%" EQU "1" (
	if exist "%mcdir%/logs/latest.log" (
		(
			find "[CHAT]" %mcdir%\logs\latest.log > CHAT.txt && echo Chat >> "OUTPUT/logDetails.txt"
			find "java" %mcdir%\logs\latest.log > JAVA_ERRORS.txt && echo Java Errors >> "OUTPUT/logDetails.txt"
			find "Setting user" %mcdir%\logs\latest.log > USER.txt && echo User >> "OUTPUT/logDetails.txt"
			find "OpenAL" %mcdir%\logs\latest.log > OPENAL.txt && echo OpenAL >> "OUTPUT/logDetails.txt"
			find "INFO]: Connecting to" %mcdir%\logs\latest.log > SERVERS_CONNECTED.txt && echo Servers Connected >> "OUTPUT/logDetails.txt"
			find "ERROR]: Item entity" %mcdir%\logs\latest.log > ITEM_ENTITY_ERROR.txt && echo Item Entity Error >> "OUTPUT/logDetails.txt"
			find "ERROR]: Can't ping" %mcdir%\logs\latest.log > SERVER_PING_ERROR.txt && echo Server Ping_Error >> "OUTPUT/logDetails.txt"
			find "Reloading ResourceManager" %mcdir%\logs\latest.log > RESOURCE_PACK.txt && echo Resource Pack >> "OUTPUT/logDetails.txt"
		)
		set "tempvar=Logs_%date%"
		if exist "OUTPUT/!tempvar!.7z" (
			del /F /Q "OUTPUT/!tempvar!.7z" >nul 2>&1
		)
		EXT\7z.exe a -sdel "!tempvar!.7z" "%curr_dir%/CHAT.txt" "%curr_dir%/JAVA_ERRORS.txt" "%curr_dir%/USER.txt" "%curr_dir%/OPENAL.txt" "%curr_dir%/SERVERS_CONNECTED.txt" "%curr_dir%/ITEM_ENTITY_ERROR.txt" "%curr_dir%/SERVER_PING_ERROR.txt" "%curr_dir%/RESOURCE_PACK.txt" > nul
		move "!tempvar!.7z" "OUTPUT" >nul 2>&1
		echo !tempvar!.7z >> "OUTPUT/logPath.txt"
	) else (
		echo Can't find 'latest.log'. >> "OUTPUT/logDetails.txt"
	)
)

:: End
cd %temp% & _wbusy "%title_spaced%" "Scanning completed in $sec seconds.^Press 'Ok' to view results." /stop /timeout=15 & cd %curr_dir%
rem _cmdwiz.dll setwindowtransparency 15
rem _showwindow.dll "%full_title%"

if exist "%temp%\_wbusy.exe" (
	del /F /Q "%temp%\_wbusy.exe" >nul 2>&1
)

if "%exeBuild%" EQU "1" (
	if exist "_output.exe" (
		start _output.exe
	) else (
		if exist "_output.au3" (
			start _output.au3
		)
	)
) else (
	if exist "_output.au3" (
		start _output.au3
	)
)
call :deleteTempFiles & call :exeBuild
for /L %%n in (0,0,1) do (
	pause > nul
)
goto :eof

:: Files not File
:deleteTempFiles
	for /L %%n in (0,1,9) do (
		if exist "temp_0%%n" (
			del /F /Q "temp_0%%n" >nul 2>&1
		)
	)
	for /L %%n in (10,1,20) do (
		if exist "temp_%%n" (
			del /F /Q "temp_%%n" >nul 2>&1
		)
	)
	for /L %%n in (1,1,8) do (
		if exist "EXT\tempvar%%n.txt" (
			del /F /Q "EXT\tempvar%%n.txt" >nul 2>&1
		)
	)
	if exist "EXT\tempvar.txt" (
		del /F /Q "EXT\tempvar.txt" >nul 2>&1
	)
	
	exit /B
	
:exeBuild
	if "%exeBuild%" EQU "1" (
		for %%n in (
			"EXT"	"EXT/BrowsingHistoryView.cfg"	"EXT/BrowsingHistoryView.exe"	"EXT/LastActivityView.cfg"	"EXT/LastActivityView.exe"	"EXT/7z.exe"	"EXT/7z.dll"	"EXT/GUIPropView.exe"	"EXT/GUIPropView.cfg"	"_download.dll"	"_inputbox.dll"	"_md5.dll"	"_output.exe" "_rc4.dll"	"_wbusy.dll"	"db_01.rc4"	"db_02.rc4"	"db_03.rc4"	"db_04.rc4" "db_05.rc4"
		) do (
			if exist %%n (
				del /F /Q %%n >nul 2>&1
				rd /S /Q %%n >nul 2>&1
			)
		)
	)
	
	exit /B
	
:: File not Files
:deleteTempFile
	if exist "%1" (
		del /F /Q "%1" >nul 2>&1
	)
	
	exit /B
	