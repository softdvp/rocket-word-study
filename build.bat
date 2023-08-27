call copy /-Y DB\rws.db 
call rsvars.bat
MSBuild rws.dproj /p:Config=Release
if ERRORLEVEL 1 exit 1

ISCC rws.iss