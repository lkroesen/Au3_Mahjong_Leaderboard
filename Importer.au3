; User
Global $iPlayerName
Global $iDate
; Tile
Global $iTile[18]
; Hand
Global $iType
Global $iHandName
Global $iValues
Global $iTotalValues
Global $iHan
Global $iFu
Global $iRiichi
Global $iRonWin
Global $iWait
; Table
Global $iRoundWind
Global $iSeatWind
Global $iDealer
Global $iOpen[4]
; Dora
Global $iDoraNum
Global $iDora[13]

Global $file

Func ImportFromDB($DBFILE)
   Settings()

   If $DBFILE == "" Then
	  return
   EndIf

   ; User Data
   $iPlayerName = IniRead ( $DBFILE, "User", "Name", "Anonymous" )
   $iDate = IniRead ( $DBFILE, "User", "Name", "--/--/--- --:--:--" )

   ; Tile Data
   for $i = 0 to 17 step 1
	  $iTile[$i] = IniRead ( $DBFILE, "Tile Data", "Tile " & $i+1, "Error" )
   Next

   ; Hand Data
   $iType = IniRead ( $DBFILE, "Hand Data", "Type", "Error" )
   $iHandName = IniRead ( $DBFILE, "Hand Data", "Hand Name", "Error")
   $iValues = IniRead ( $DBFILE, "Hand Data", "Values", "Error")
   $iTotalValues = IniRead ( $DBFILE, "Hand Data", "Total Value", "Error")
   $iHan = IniRead ( $DBFILE, "Hand Data", "Han", -1)
   $iFu = IniRead ( $DBFILE, "Hand Data", "Fu", -1)
   $iRiichi = IniRead ( $DBFILE, "Hand Data", "Riichi", "Error")

   if $iRiichi == "YES" Then
	  $iRiichi = True
   Else
	  $iRiichi = False
   EndIf

   $iRonWin = IniRead ( $DBFILE, "Hand Data", "Ron Win", "Error")
   $iWait = IniRead ( $DBFILE, "Hand Data", "Wait", "Error")

   ; Table Data
   $iRoundWind = IniRead ( $DBFILE, "Table Data", "Round Wind", -1)
   $iSeatWind = IniRead ( $DBFILE, "Table Data", "Seat Wind", -1)
   $iDealer = IniRead ( $DBFILE, "Table Data", "Dealer", -1)
   for $i = 0 to 3 step 1
	  $iOpen[$i] =	IniRead ( $DBFILE, "Table Data", "Open" & $i, -1)
	  if $iOpen[$i] == 0 Then
		 $iOpen[$i] = False
	  Else
		 $iOpen[$i] = True
	  EndIf
   Next

   ; Dora Data
   $iDoraNum = IniRead ( $DBFILE, "Dora Data", "nDora", -1)
   for $i = 0 to 12 step 1
	  $iDora[$i] = IniRead ( $DBFILE, "Dora Data", "Dora " & $i+1, -1)
   Next
EndFunc

Func Import()
   Settings()
   $file = FileOpenDialog("Import a Hand", @ScriptDir, "Hand Export File (*.mhj)", 0, "Hand.mhj")
   If $file == "" Then
	  return
   EndIf
   ; User Data
   $iPlayerName = IniRead ( $file, "User", "Name", "Anonymous" )
   $iDate = IniRead ( $file, "User", "Name", "--/--/--- --:--:--" )

   ; Tile Data
   for $i = 0 to 17 step 1
	  $iTile[$i] = IniRead ( $file, "Tile Data", "Tile " & $i+1, "Error" )
   Next

   ; Hand Data
   $iType = IniRead ( $file, "Hand Data", "Type", "Error" )
   $iHandName = IniRead ( $file, "Hand Data", "Hand Name", "Error")
   $iValues = IniRead ( $file, "Hand Data", "Values", "Error")
   $iTotalValues = IniRead ( $file, "Hand Data", "Total Value", "Error")
   $iHan = IniRead ( $file, "Hand Data", "Han", -1)
   $iFu = IniRead ( $file, "Hand Data", "Fu", -1)
   $iRiichi = IniRead ( $file, "Hand Data", "Riichi", "Error")

   if $iRiichi == "YES" Then
	  $iRiichi = True
   Else
	  $iRiichi = False
   EndIf

   $iRonWin = IniRead ( $file, "Hand Data", "Ron Win", "Error")
   $iWait = IniRead ( $file, "Hand Data", "Wait", "Error")

   ; Table Data
   $iRoundWind = IniRead ( $file, "Table Data", "Round Wind", -1)
   $iSeatWind = IniRead ( $file, "Table Data", "Seat Wind", -1)
   $iDealer = IniRead ( $file, "Table Data", "Dealer", -1)
   for $i = 0 to 3 step 1
	  $iOpen[$i] =	IniRead ( $file, "Table Data", "Open" & $i, -1)
	  if $iOpen[$i] == 0 Then
		 $iOpen[$i] = False
	  Else
		 $iOpen[$i] = True
	  EndIf
   Next

   ; Dora Data
   $iDoraNum = IniRead ( $file, "Dora Data", "nDora", -1)
   for $i = 0 to 12 step 1
	  $iDora[$i] = IniRead ( $file, "Dora Data", "Dora " & $i+1, -1)
   Next
EndFunc