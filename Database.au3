#include <File.au3>
#include <Array.au3>
#include <Crypt.au3>

; c <TileName> <Number>
Global Enum $cMAN1, $cMAN2, $cMAN3, $cMAN4, $cMAN5, $cMAN5r, $cMAN6, $cMAN7, $cMAN8, $cMAN9, $cSOU1, $cSOU2, $cSOU3, $cSOU4, $cSOU5, $cSOU5r, $cSOU6, $cSOU7, $cSOU8, $cSOU9, $cPIN1, $cPIN2, $cPIN3, $cPIN4, $cPIN5, $cPIN5r, $cPIN6, $cPIN7, $cPIN8, $cPIN9, $cTON, $cNAN, $cSHAA, $cPEI, $cCHUN, $cHAKU, $cHATSU

Global $dbFiles

; Database will be a simple folder with all of the hands sorted by hand[NUM].mhj
Func Database()
   if ReadDatabase() == True Then

   for $i = 1 to $dbFiles[0] Step 1
	  GUICtrlSetData( $HandList, _Crypt_HashFile( "db/" & $dbFiles[$i], $CALG_MD5) & ".mhj" )
   Next
   EndIf
EndFunc

Func ReadDatabase()
   if FileExists("db/readme.txt") Then
	  FileDelete("db/readme.txt")
   EndIf

   $dbFiles = _FileListToArray("db/")

   If @error = 4 Then
	  MsgBox(0, "DB Empty", "Empty Database")
	  return false
   EndIf

   _ArrayDisplay($dbFiles, "$dbFiles")
   return true
EndFunc

; Upon import the current hand is added to the database, with the md5 hash as filename.
Func MoveToDB()
   $md5Hash = _Crypt_HashFile( $file, $CALG_MD5)

   if $md5Hash == -1 Then
	  msgbox(0, "Error", "No file imported")
	  return
   EndIf

   if FileExists("db/" & $md5Hash & ".mhj") == 1 Then
	  msgbox(0, "Already in DB", "This file is already in the database as:" & @CRLF & $md5Hash & ".mhj")
	  return
   EndIf

   FileCopy($file, "db/" & $md5Hash & ".mhj")
   GUICtrlSetData($HandList, $md5Hash & ".mhj")
   MsgBox(0, "Imported to Database", "Imported your hand to database as: " & @CRLF & $md5Hash & ".mhj")
EndFunc
