echo off
rem echo on
echo cls
echo nastaven  k˘dov  str nka
chcp
echo zapˇn m źeçtinu (pro jistotu)
chcp 852
echo ¬eçtina je zde: Řçźý§ě ˇ‚Ł…·ć¬ü¦íµÖéŢ
echo Slovençtina je zde: – Ô ś • Ň › „ Ž ” ™  š
echo *** 
echo *** JIMovo UNI z loha z lohy Łźetnictvˇ ***
echo zrcadlˇm z lohu Money S3 mezi origin lnˇm adres ýem,
echo a z lohou na Google Disku.
echo *** 
echo Zrcadlˇm MS3 z lohu
echo ***

rem napln promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set kdoJsem=PEM
if %USERNAME%==JIM set kdoJsem=JIM

rem nastavenˇ zdrojov‚ho adres ýe - m me stejně
set primarniZdroj="C:\Users\Public\Documents\Solitea\Money S3\Data\Zalohy"

rem diky zjiçtŘnˇ kdo jsem nastavˇm i cˇlově adres ý m…j nebo jejˇ
rem zmŘna 24.6.2022, kdy si google usmyslel vyźlenit si vlastnˇ diskov‚ pˇsmeno pro sdˇlen‚ disky :-/ kret‚ni.. tak§e ka§dě to m me jinde...
rem set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem zmŘna 22.3.2025,nynˇ je to statick‚, JIM je JIM a PEM je PEM, nepou§ˇvej zbyteźnŘ věpoźet, viz věçe
set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-PEM"
set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-JIM"

rem napln pracovnˇ promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set primarniCil=%primarniCilPEM%
if %USERNAME%==JIM set primarniCil=%primarniCilJIM%

rem otoźˇm zdroj a cˇl pro obnovu stavu pýedchozˇho - po reinstalacˇch
set protismernyZdroj=%primarniCil%
set protismernyCil=%primarniZdroj%

rem ignorovan‚ files pro z lohy a obnovy
set ignorujFiles=desktop.ini

rem věkonn  ź st kopˇrov nˇ sem  a tam
echo =========================================================
echo =========================================================
echo =========================================================
echo PRACUJI v kontextu %kdoJsem%
echo
echo Jsme u z lohy nověch a novŘjçˇch polo§ek do Google disk:
echo
echo    1. ź st z MS3 do cloudu
echo       a) kopˇruju z %primarniZdroj%
echo       b) kopˇruju do %primarniCil%
echo       c) vçe mimo %ignorujFiles%

PAUSE
echo
echo po klinutˇ se spustˇ nahr nˇ nověch a novŘjçˇch polo§ek do Google disku
echo
ROBOCOPY %primarniZdroj% %primarniCil% /E /XO /XF %ignorujFiles%
echo
echo
echo 1. ź st je dokonźena
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
echo Jsme u obnovy nověch a novŘjçˇch polo§ek na Google disku ke mŘ
echo
echo    2. ź st z cloudu do MS3
echo       a) kopˇruju z %protismernyZdroj%
echo       b) kopˇruju do %protismernyCil%
echo       c) vçe mimo %ignorujFiles%
echo
echo po klinutˇ se spustˇ obnova nověch a novŘjçˇch polo§ek z Google disku
echo
PAUSE
ROBOCOPY %protismernyZdroj% %protismernyCil% /E /XO /XF %ignorujFiles%
echo
echo 2. ź st je dokonźena, MS3 oçetýeno
echo        PEM konźˇ
echo        JIM pokraźuje ;o)
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
rem pokud nejsem JIM, pak sk źu na konec
if %kdoJsem%==PEM GOTO konecProNonJIMa

rem jinak je jasně, §e jsem JIM, tak§e si jednou mŘsˇźnŘ odz lohuju PSTźka
echo jen kdy§ jsem JIM a jen 1x v mŘsˇci provedu:
echo zrcadlenˇ e-mailu - *.pst 1 x mŘsˇźnŘ (na zaź tku!!!)
echo a odz lohovˇ adres ýa DATA na Fku
rem echo on
echo Sestavenˇ kontrolnˇho souboru
PAUSE
rem - nefunguje mi pou§itˇ t‚to promŘnn‚ d le :-/ set JIM_file = %date:~6,4%-%date:~3,2%.log
CD /D "D:\DATA\OneDrive\_Zalohy\emaily"
IF EXIST %date:~6,4%-%date:~3,2%.log (
	echo tento mŘsˇc ji§ bylo z lohov no - nez lohuju e-poźtu ni Fko
	) else (
	type NUL > %date:~6,4%-%date:~3,2%.log
	echo VYPNI si OUTLOOK !!!!, pak pokraźuj
	PAUSE
	ROBOCOPY "F:\DATA\email" "D:\DATA\OneDrive\_Zalohy\emaily" /Z /J
	echo z loha *.pst dokonźena
	rem doplnŘno 30.1.2024 pro z lohu VPC-źek
	rem Łprava 23.3.2025 - po zmŘnŘ rozdŘlenˇ obsahu adres ýe "DATA" a reinstalaci JIMSNTB4 2024/2025 ruçˇm full F:\DATA\ z lohy, mimo e-mail…, viz věçe
	rem echo JIMs z loha F:\DATA\ do PEMs OneDrive - D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all
	rem ROBOCOPY "F:\DATA\VPC" "D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all" /S /Z /J  /XD "F:\DATA\noCloud"
	rem echo JIMs z loha F:\DATA dokoźena	
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
echo ============== PO KLIKNUTÖ SE OKNO UZAVüE ===============
echo =========================================================
PAUSE
