echo off
rem echo on
echo cls
echo nastaven  k¢dov  str nka
chcp
echo zap¡n m Ÿeçtinu (pro jistotu)
chcp 852
echo ¬eçtina je zde: ØçŸý§ì ¡‚£…·æ¬ü¦íµÖéÞ
echo Slovençtina je zde: – Ô œ • Ò › „ Ž ” ™  š
echo *** 
echo *** JIMovo UNI z loha z lohy £Ÿetnictv¡ ***
echo zrcadl¡m z lohu Money S3 mezi origin ln¡m adres ýem,
echo a z lohou na Google Disku.
echo *** 
echo Zrcadl¡m MS3 z lohu
echo ***

rem napln promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set kdoJsem=PEM
if %USERNAME%==JIM set kdoJsem=JIM

rem nastaven¡ zdrojov‚ho adres ýe - m me stejnì
set primarniZdroj="C:\Users\Public\Documents\Solitea\Money S3\Data\Zalohy"

rem diky zjiçtØn¡ kdo jsem nastav¡m i c¡lovì adres ý m…j nebo jej¡
rem zmØna 24.6.2022, kdy si google usmyslel vyŸlenit si vlastn¡ diskov‚ p¡smeno pro sd¡len‚ disky :-/ kret‚ni.. tak§e ka§dì to m me jinde...
rem set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem zmØna 22.3.2025,nyn¡ je to statick‚, JIM je JIM a PEM je PEM, nepou§¡vej zbyteŸnØ vìpoŸet, viz vìçe
set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-PEM"
set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-JIM"

rem napln pracovn¡ promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set primarniCil=%primarniCilPEM%
if %USERNAME%==JIM set primarniCil=%primarniCilJIM%

rem otoŸ¡m zdroj a c¡l pro obnovu stavu pýedchoz¡ho - po reinstalac¡ch
set protismernyZdroj=%primarniCil%
set protismernyCil=%primarniZdroj%

rem ignorovan‚ files pro z lohy a obnovy
set ignorujFiles=desktop.ini

rem vìkonn  Ÿ st kop¡rov n¡ sem  a tam
echo =========================================================
echo =========================================================
echo =========================================================
echo PRACUJI v kontextu %kdoJsem%
echo
echo Jsme u z lohy novìch a novØjç¡ch polo§ek do Google disk:
echo
echo    1. Ÿ st z MS3 do cloudu
echo       a) kop¡ruju z %primarniZdroj%
echo       b) kop¡ruju do %primarniCil%
echo       c) vçe mimo %ignorujFiles%

PAUSE
echo
echo po klinut¡ se spust¡ nahr n¡ novìch a novØjç¡ch polo§ek do Google disku
echo
ROBOCOPY %primarniZdroj% %primarniCil% /E /XO /XF %ignorujFiles%
echo
echo
echo 1. Ÿ st je dokonŸena
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
echo Jsme u obnovy novìch a novØjç¡ch polo§ek na Google disku ke mØ
echo
echo    2. Ÿ st z cloudu do MS3
echo       a) kop¡ruju z %protismernyZdroj%
echo       b) kop¡ruju do %protismernyCil%
echo       c) vçe mimo %ignorujFiles%
echo
echo po klinut¡ se spust¡ obnova novìch a novØjç¡ch polo§ek z Google disku
echo
PAUSE
ROBOCOPY %protismernyZdroj% %protismernyCil% /E /XO /XF %ignorujFiles%
echo
echo 2. Ÿ st je dokonŸena, MS3 oçetýeno
echo        PEM konŸ¡
echo        JIM pokraŸuje ;o)
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
rem pokud nejsem JIM, pak sk Ÿu na konec
if %kdoJsem%==PEM GOTO konecProNonJIMa

rem jinak je jasnì, §e jsem JIM, tak§e si jednou mØs¡ŸnØ odz lohuju PSTŸka
echo jen kdy§ jsem JIM a jen 1x v mØs¡ci provedu:
echo zrcadlen¡ e-mailu - *.pst 1 x mØs¡ŸnØ (na zaŸ tku!!!)
echo a odz lohov¡ adres ýa DATA na Fku
rem echo on
echo Sestaven¡ kontroln¡ho souboru
PAUSE
rem - nefunguje mi pou§it¡ t‚to promØnn‚ d le :-/ set JIM_file = %date:~6,4%-%date:~3,2%.log
CD /D "D:\DATA\OneDrive\_Zalohy\emaily"
IF EXIST %date:~6,4%-%date:~3,2%.log (
	echo tento mØs¡c ji§ bylo z lohov no - nez lohuju e-poŸtu ni Fko
	) else (
	type NUL > %date:~6,4%-%date:~3,2%.log
	echo VYPNI si OUTLOOK !!!!, pak pokraŸuj
	PAUSE
	ROBOCOPY "F:\DATA\email" "D:\DATA\OneDrive\_Zalohy\emaily" /Z /J
	echo z loha *.pst dokonŸena
	rem doplnØno 30.1.2024 pro z lohu VPC-Ÿek
	rem £prava 23.3.2025 - po zmØnØ rozdØlen¡ obsahu adres ýe "DATA" a reinstalaci JIMSNTB4 2024/2025 ruç¡m full F:\DATA\ z lohy, mimo e-mail…, viz vìçe
	rem echo JIMs z loha F:\DATA\ do PEMs OneDrive - D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all
	rem ROBOCOPY "F:\DATA\VPC" "D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all" /S /Z /J  /XD "F:\DATA\noCloud"
	rem echo JIMs z loha F:\DATA dokoŸena	
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