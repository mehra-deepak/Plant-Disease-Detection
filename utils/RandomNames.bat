@ECHO OFF
ECHO Random Names
ECHO Written By: Jason Faulkner
ECHO HowToGeek.com
ECHO.
ECHO.

REM Randomly renames every file in a directory.

SETLOCAL EnableExtensions EnableDelayedExpansion

REM 0 = Rename the file randomly.
REM 1 = Prepend the existing file name with randomly generated string.
SET PrependOnly=0

REM 1 = Undo changes according to the translation file.
REM This will only work if the file "__Translation.txt" is in the same folder.
REM If you delete the translaction file, you will not be able to undo the changes!
SET Undo=0


REM --------------------------------------------------------------------------
REM Do not modify anything below this line unless you know what you are doing.
REM --------------------------------------------------------------------------

SET TranslationFile=__Translation.txt

IF NOT {%Undo%}=={1} (
	REM Rename files
	ECHO You are about to randomly rename every file in the following folder:
	ECHO %~dp0
	ECHO.
	ECHO A file named %TranslationFile% will be created which allows you to undo this.
	ECHO Warning: If %TranslationFile% is lost/deleted, this action cannot be undone.
	ECHO Type "OK" to continue.
	SET /P Confirm=
	IF /I NOT {!Confirm!}=={OK} (
		ECHO.
		ECHO Aborting.
		GOTO :EOF
	)

	ECHO Original Name/Random Name > %TranslationFile%
	ECHO ------------------------- >> %TranslationFile%

	FOR /F "tokens=*" %%A IN ('DIR /A:-D /B') DO (
		IF NOT %%A==%~nx0 (
			IF NOT %%A==%TranslationFile% (
				SET Use=%%~xA
				IF {%PrependOnly%}=={1} SET Use=_%%A
				
				SET NewName=!RANDOM!-!RANDOM!-!RANDOM!!Use!
				ECHO %%A/!NewName!>> %TranslationFile%
				
				RENAME "%%A" "!NewName!"
			)
		)
	)
) ELSE (
	ECHO Undo mode.
	IF NOT EXIST %TranslationFile% (
		ECHO Missing translation file: %TranslationFile%
		PAUSE
		GOTO :EOF
	)
	FOR /F "skip=2 tokens=1,2 delims=/" %%A IN (%TranslationFile%) DO RENAME "%%B" "%%A"
	DEL /F /Q %TranslationFile%
)