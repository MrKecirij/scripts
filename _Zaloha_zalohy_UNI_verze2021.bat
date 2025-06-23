echo off
rem echo on
echo cls
echo nastavená kódová stránka
chcp
echo zapínám češtinu (pro jistotu)
chcp 852
echo Čeština je zde: ěščřžýáíéúůĚŠČŘŽÝÁÍÉÚŮ
echo Slovenština je zde: ľ ď ť Ľ Ď Ť ä Ä ö Ö ü Ü
echo *** 
echo *** JIMovo UNI záloha zálohy účetnictví ***
echo zrcadlím zálohu Money S3 mezi originálním adresářem,
echo a zálohou na Google Disku.
echo *** 
echo Zrcadlím MS3 zálohu
echo ***

rem napln promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set kdoJsem=PEM
if %USERNAME%==JIM set kdoJsem=JIM

rem nastavení zdrojového adresáře - máme stejný
set primarniZdroj="C:\Users\Public\Documents\Solitea\Money S3\Data\Zalohy"

rem diky zjištění kdo jsem nastavím i cílový adresář můj nebo její
rem změna 24.6.2022, kdy si google usmyslel vyčlenit si vlastní diskové písmeno pro sdílené disky :-/ kreténi.. takže každý to máme jinde...
rem set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem změna 22.3.2025,nyní je to statické, JIM je JIM a PEM je PEM, nepoužívej zbytečně výpočet, viz výše
set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-PEM"
set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-JIM"
rem 2025-05-24 - doplnění synchro obsahu o miláčkův obsah - vše starší u mě mi dorovná
set milackuvZdrojProPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-JIM"
set milackuvZdrojProJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-PEM"

rem napln pracovní promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set primarniCil=%primarniCilPEM%
if %USERNAME%==JIM set primarniCil=%primarniCilJIM%
rem 2025-05-24 - doplnění synchro obsahu o miláčkův obsahu
rem napln pracovní promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set milackuvZdroj=%milackuvZdrojProPEM%
if %USERNAME%==JIM set milackuvZdroj=%milackuvZdrojProJIM%

rem otočím zdroj a cíl pro obnovu stavu předchozího - po reinstalacích
set protismernyZdroj=%primarniCil%
set protismernyCil=%primarniZdroj%

rem ignorované files pro zálohy a obnovy
set ignorujFiles=desktop.ini

rem výkonná část kopírování sem  a tam
echo =========================================================
echo =========================================================
echo =========================================================
echo PRACUJI v kontextu %kdoJsem%
echo
echo Jsme u zálohy nových a novějších položek na Google disk:
echo
echo    1. část z MS3 do cloudu
echo       a) kopíruju z %primarniZdroj%
echo       b) kopíruju do %primarniCil%
echo       c) vše mimo %ignorujFiles%
PAUSE
echo
echo po klinutí se spustí nahrání nových a novějších položek do Google disku
echo
ROBOCOPY %primarniZdroj% %primarniCil% /E /XO /XF %ignorujFiles%
echo
echo
echo 1. část je dokončena
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
echo Jsme u obnovy nových a novějších položek z Google disku ke mě
echo
echo    2.a. část z cloudu do MS3 (moje vlastní)
echo       a) kopíruju z %protismernyZdroj%
echo       b) kopíruju do %protismernyCil%
echo       c) vše mimo %ignorujFiles%
echo
echo po klinutí se spustí obnova nových a novějších položek z Google disku (moje vlastní)
echo
PAUSE
ROBOCOPY %protismernyZdroj% %protismernyCil% /E /XO /XF %ignorujFiles%
echo
PAUSE
echo    2.b. část z cloudu do MS3 (mojeho miláčka)
echo       a) kopíruju z %milackuvZdroj%
echo       b) kopíruju do %protismernyCil%
echo       c) vše mimo %ignorujFiles%
echo
echo po klinutí se spustí obnova nových a novějších položek z Google disku (mojeho miláčka)
echo
PAUSE
rem echo /E :: copy subdirectories, including Empty ones.
rem echo /XO :: eXclude Older files.
rem echo /XF file [file]... :: eXclude Files matching given names/paths/wildcards.
ROBOCOPY %milackuvZdroj% %protismernyCil% /E /XO /XF %ignorujFiles%
echo
PAUSE
echo 2. část, a. i b., je dokončena, MS3 ošetřeno ;o)
echo        PEM končí
echo        JIM pokračuje ;o)
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
rem pokud nejsem JIM, pak skáču na konec
if %kdoJsem%==PEM GOTO konecProNonJIMa

rem jinak je jasný, že jsem JIM, takže si jednou měsíčně odzálohuju PSTčka
echo jen když jsem JIM a jen 1x v měsíci provedu:
echo zrcadlení e-mailu - *.pst 1 x měsíčně (na začátku!!!)
echo a odzálohování adresáře DATA na Fku
rem echo on
echo Sestavení kontrolního souboru
PAUSE
rem - nefunguje mi použití této proměnné dále :-/ set JIM_file = %date:~6,4%-%date:~3,2%.log
CD /D "D:\DATA\OneDrive\_Zalohy\emaily"
IF EXIST %date:~6,4%-%date:~3,2%.log (
	echo tento měsíc již bylo zálohováno - nezálohuju e-počtu ni Fko
	) else (
	type NUL > %date:~6,4%-%date:~3,2%.log
	echo VYPNI si OUTLOOK !!!!, pak pokračuj
	PAUSE
	ROBOCOPY "F:\DATA\email" "D:\DATA\OneDrive\_Zalohy\emaily" /Z /J
	echo záloha *.pst dokončena
	rem doplněno 30.1.2024 pro zálohu VPC-ček
	rem úprava 23.3.2025 - po změně rozdělení obsahu adresáře "DATA" a reinstalaci JIMSNTB4 2024/2025 ruším full F:\DATA\ zálohy, mimo e-mailů, viz výše
	rem echo JIMs záloha F:\DATA\ do PEMs OneDrive - D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all
	rem ROBOCOPY "F:\DATA\VPC" "D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all" /S /Z /J  /XD "F:\DATA\noCloud"
	rem echo JIMs záloha F:\DATA dokočena	
	)
echo ***
:konecProNonJIMa
PAUSE
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo ========================= KONEC =========================
echo =========================================================
echo =========================================================
echo =========================================================
echo ============== PO KLIKNUTÍ SE OKNO UZAVŘE ===============
echo =========================================================
PAUSE
