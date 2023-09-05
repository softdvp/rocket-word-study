ECHO OFF
call CLS
call copy rws.db rws.~bd
ECHO *****************************************
ECHO Please save rws.bd file before copying!
ECHO *****************************************

call copy /-Y DB\rws.db 
call rsvars.bat
MSBuild rws.dproj /p:config="Release"
if ERRORLEVEL 1 exit 1
del *.dcu
ISCC rws.iss