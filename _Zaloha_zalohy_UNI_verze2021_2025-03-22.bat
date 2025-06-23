echo off
rem echo on
echo cls
echo nastaven� k�dov� str�nka
chcp
echo zap�n�m �e�tinu (pro jistotu)
chcp 852
echo �e�tina je zde: ����젡��������֐��
echo Sloven�tina je zde: � � � � � � � � � � � �
echo *** 
echo *** JIMovo UNI z�loha z�lohy ��etnictv� ***
echo zrcadl�m z�lohu Money S3 mezi origin�ln�m adres��em,
echo a z�lohou na Google Disku.
echo *** 
echo Zrcadl�m MS3 z�lohu
echo ***

rem napln promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set kdoJsem=PEM
if %USERNAME%==JIM set kdoJsem=JIM

rem nastaven� zdrojov�ho adres��e - m�me stejn�
set primarniZdroj="C:\Users\Public\Documents\Solitea\Money S3\Data\Zalohy"

rem diky zji�t�n� kdo jsem nastav�m i c�lov� adres�� m�j nebo jej�
rem zm�na 24.6.2022, kdy si google usmyslel vy�lenit si vlastn� diskov� p�smeno pro sd�len� disky :-/ kret�ni.. tak�e ka�d� to m�me jinde...
rem set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-%kdoJsem%"
rem zm�na 22.3.2025,nyn� je to statick�, JIM je JIM a PEM je PEM, nepou��vej zbyte�n� v�po�et, viz v��e
set primarniCilPEM="D:\DATA\GoogleDisk\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-PEM"
set primarniCilJIM="G:\.shortcut-targets-by-id\0B_CWm7QThRhveURlcUZmNm05M28\_JIMsBusinessPEM\05_provoz\02022605\eDOK\zalohy\MS3-JIM"

rem napln pracovn� promennou mnou nebo Petulkou, pocita ze to je Peta - default, prepis na me pokud jsem to ja.
set primarniCil=%primarniCilPEM%
if %USERNAME%==JIM set primarniCil=%primarniCilJIM%

rem oto��m zdroj a c�l pro obnovu stavu p�edchoz�ho - po reinstalac�ch
set protismernyZdroj=%primarniCil%
set protismernyCil=%primarniZdroj%

rem ignorovan� files pro z�lohy a obnovy
set ignorujFiles=desktop.ini

rem v�konn� ��st kop�rov�n� sem  a tam
echo =========================================================
echo =========================================================
echo =========================================================
echo PRACUJI v kontextu %kdoJsem%
echo
echo Jsme u z�lohy nov�ch a nov�j�ch polo�ek do Google disk:
echo
echo    1. ��st z MS3 do cloudu
echo       a) kop�ruju z %primarniZdroj%
echo       b) kop�ruju do %primarniCil%
echo       c) v�e mimo %ignorujFiles%

PAUSE
echo
echo po klinut� se spust� nahr�n� nov�ch a nov�j�ch polo�ek do Google disku
echo
ROBOCOPY %primarniZdroj% %primarniCil% /E /XO /XF %ignorujFiles%
echo
echo
echo 1. ��st je dokon�ena
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
echo Jsme u obnovy nov�ch a nov�j�ch polo�ek na Google disku ke m�
echo
echo    2. ��st z cloudu do MS3
echo       a) kop�ruju z %protismernyZdroj%
echo       b) kop�ruju do %protismernyCil%
echo       c) v�e mimo %ignorujFiles%
echo
echo po klinut� se spust� obnova nov�ch a nov�j�ch polo�ek z Google disku
echo
PAUSE
ROBOCOPY %protismernyZdroj% %protismernyCil% /E /XO /XF %ignorujFiles%
echo
echo 2. ��st je dokon�ena, MS3 o�et�eno
echo        PEM kon��
echo        JIM pokra�uje ;o)
echo
echo =========================================================
echo =========================================================
echo =========================================================
echo
rem pokud nejsem JIM, pak sk��u na konec
if %kdoJsem%==PEM GOTO konecProNonJIMa

rem jinak je jasn�, �e jsem JIM, tak�e si jednou m�s��n� odz�lohuju PST�ka
echo jen kdy� jsem JIM a jen 1x v m�s�ci provedu:
echo zrcadlen� e-mailu - *.pst 1 x m�s��n� (na za��tku!!!)
echo a odz�lohov� adres��a DATA na Fku
rem echo on
echo Sestaven� kontroln�ho souboru
PAUSE
rem - nefunguje mi pou�it� t�to prom�nn� d�le :-/ set JIM_file = %date:~6,4%-%date:~3,2%.log
CD /D "D:\DATA\OneDrive\_Zalohy\emaily"
IF EXIST %date:~6,4%-%date:~3,2%.log (
	echo tento m�s�c ji� bylo z�lohov�no - nez�lohuju e-po�tu ni Fko
	) else (
	type NUL > %date:~6,4%-%date:~3,2%.log
	echo VYPNI si OUTLOOK !!!!, pak pokra�uj
	PAUSE
	ROBOCOPY "F:\DATA\email" "D:\DATA\OneDrive\_Zalohy\emaily" /Z /J
	echo z�loha *.pst dokon�ena
	rem dopln�no 30.1.2024 pro z�lohu VPC-�ek
	rem �prava 23.3.2025 - po zm�n� rozd�len� obsahu adres��e "DATA" a reinstalaci JIMSNTB4 2024/2025 ru�m full F:\DATA\ z�lohy, mimo e-mail�, viz v��e
	rem echo JIMs z�loha F:\DATA\ do PEMs OneDrive - D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all
	rem ROBOCOPY "F:\DATA\VPC" "D:\DATA\OneDrive\Data_Business_PEM\zalohy\zalohy_JIMs\ICT-F-DATA_all" /S /Z /J  /XD "F:\DATA\noCloud"
	rem echo JIMs z�loha F:\DATA doko�ena	
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
echo ============== PO KLIKNUT� SE OKNO UZAV�E ===============
echo =========================================================
PAUSE