HotKeySet("{F1}", "Import")
HotKeySet("{F2}", "Show_Import")
HotKeySet("{F3}", "ClearHand")
HotKeySet("{F4}", "Database")
HotKeySet("{F6}", "MoveToDB")


Global $LastTileUsedTop = 0
Global $LastTileUsedMid = 0
Global $LastTileUsedBot = 0

Func RollDieTable()
   local $die[2]
   $die[0] = random(1,6,1)
   $die[1] = random(1,6,1)

   for $i = 0 to 1 Step 1
	  GUICtrlSetImage($DieFace[$i], "Img\etc\Default\d" & $die[$i] & ".bmp")
   Next
EndFunc

Func ClearHand()
   for $i = 0 to 16 Step 1
	  GUICtrlSetImage($TileMidRow[$i], $SkinFolder & "null.bmp")
	  GUICtrlSetImage($TileBotRow[$i], $SkinFolder & "null.bmp")
	  if $i <= 12 Then
		 GUICtrlSetImage($TileTopRow[$i], $SkinFolder90 & "null.bmp")
	  EndIf
   Next

   ; Clear Input Texts
   GUICtrlSetData($inputHan, "Han / Type")
   GUICtrlSetData($inputFu,"Fu / (N/A)")
   GUICtrlSetData($inputPlayerName, "Player Name")
   GUICtrlSetData($inputDNoneDealer, "Non Dealer / Dealer")
   GUICtrlSetData($inputTotalValue, "Total Value")
   GUICtrlSetData($inputHandName, "Hand Name")

EndFunc

; While called show import it'll work for any hand, just treat it as an import I guess \0/
Func Show_Import()
   $nOpen = 0
   $nOpenHad = 0
   $LastTileUsedMid = 0

   for $f = 0 to 3 Step 1
	  if $iOpen[$f] == True Then
		 $nOpen += 1
	  EndIf
   Next

   $nClosed = 5-$nOpen
   $nClosedHad = 0

   ;winning tile for now is always the pair
   $nRandomClose = 1 ;Random(1,$nOpen,1)

   ; TODO proper winning tile detector
   #Region All Related To Hand
   ; Add pair to hand
   if $nRandomClose == 1 Then
	  GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[16]) & ".bmp")
	  $LastTileUsedMid += 1
	  GUICtrlSetImage($TileTopRow[0], $SkinFolder90 & TileNumToFileName($iTile[17]) & ".bmp")
   Else
	  GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[16]) & ".bmp")
	  $LastTileUsedMid += 1
	  GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[17]) & ".bmp")
	  $LastTileUsedMid += 1
   EndIf


   $nTile = 0
   for $f = 0 to 3 Step 1
	  if $iOpen[$f] == True Then
		 if $nOpenHad == 0 Then
			$nOpenHad = 1
			GUICtrlSetImage($TileBotRow[13], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileBotRow[14], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileBotRow[15], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			if $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			; Do Nothing
			Else
			GUICtrlSetImage($TileBotRow[16], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
		 EndIf
	  elseif $nOpenHad == 1 Then
			$nOpenHad = 2
			GUICtrlSetImage($TileMidRow[13], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileMidRow[14], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileMidRow[15], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			if $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			; Do Nothing
			Else
			GUICtrlSetImage($TileMidRow[16], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			EndIf
		 elseif $nOpenHad == 2 Then
			$nOpenHad = 3
			GUICtrlSetImage($TileBotRow[8], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileBotRow[9], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileBotRow[10], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			if $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			; Do Nothing
			Else
			GUICtrlSetImage($TileBotRow[11], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			EndIf
		 Else
			$nOpenHad = 4
			GUICtrlSetImage($TileMidRow[8], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileMidRow[9], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			GUICtrlSetImage($TileMidRow[10], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			if $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			; Do Nothing
			Else
			GUICtrlSetImage($TileMidRow[11], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			EndIf
		 EndIf
	  Else
		 if $nRandomClose == 1 Then
			; If open = false, fill up the upper tiles
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			If $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			   ; Do Nothing
			Else
			   GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			   $LastTileUsedMid += 1
			EndIf
		 elseif $nRandomClose == 2 Then
			; If open = false, fill up the upper tiles
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			If $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			   ; Do Nothing
			Else
			   GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			   $LastTileUsedMid += 1
			EndIf
		 elseif $nRandomClose == 3 Then
			; If open = false, fill up the upper tiles
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			If $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			   ; Do Nothing
			Else
			   GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			   $LastTileUsedMid += 1
			EndIf
		 elseif $nRandomClose == 4 Then
			; If open = false, fill up the upper tiles
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			If $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			   ; Do Nothing
			Else
			   GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			   $LastTileUsedMid += 1
			EndIf
		 elseif $nRandomClose == 5 Then
			; If open = false, fill up the upper tiles
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 0 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 1 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 2 + (4*$f) ]) & ".bmp")
			$LastTileUsedMid += 1
			If $iTile[$nTile+ 3 + (4*$f) ] == "empty" Then
			   ; Do Nothing
			Else
			   GUICtrlSetImage($TileMidRow[$LastTileUsedMid], $SkinFolder & TileNumToFileName($iTile[$nTile+ 3 + (4*$f) ]) & ".bmp")
			   $LastTileUsedMid += 1
			EndIf
		 EndIf
	  EndIf
   Next
   #EndRegion

   #Region Input Boxes
	  GUICtrlSetData($inputHan, $iHan & " Han")
	  GUICtrlSetData($inputFu, $iFu & " Fu")
	  GUICtrlSetData($inputPlayerName, $iPlayerName)
	  GUICtrlSetData($inputDNoneDealer, $iValues)
	  GUICtrlSetData($inputTotalValue, $iTotalValues)
	  GUICtrlSetData($inputHandName, $iHandName)
	#EndRegion
EndFunc

Func TileNumToFileName($cT)
   if $cT == "empty" Then
	  return "empty"
   elseif $cT == $cMAN1 Then
	  return "Man1"
   elseif $cT ==  $cMAN2 Then
	  return "Man2"
   elseif $cT ==  $cMAN3 Then
	  return "Man3"
   elseif $cT ==  $cMAN4 Then
	  return "Man4"
   elseif $cT ==  $cMAN5 Then
	  return "Man5"
   elseif $cT ==  $cMAN5r Then
	  return "Man5r"
   elseif $cT ==  $cMAN6 Then
	  return "Man6"
   elseif $cT ==  $cMAN7 Then
	  return "Man7"
   elseif $cT ==  $cMAN8 Then
	  return "Man8"
   elseif $cT ==  $cMAN9 Then
	  return "Man9"
   elseif $cT ==  $cSOU1 Then
	  return "Sou1"
   elseif $cT ==  $cSOU2 Then
	  return "Sou2"
   elseif $cT ==  $cSOU3 Then
	  return "Sou3"
   elseif $cT ==  $cSOU4 Then
	  return "Sou4"
   elseif $cT ==  $cSOU5 Then
	  return "Sou5"
   elseif $cT ==  $cSOU5r Then
	  return "Sou5r"
   elseif $cT ==  $cSOU6 Then
	  return "Sou6"
   elseif $cT ==  $cSOU7 Then
	  return "Sou7"
   elseif $cT ==  $cSOU8 Then
	  return "Sou8"
   elseif $cT ==  $cSOU9 Then
	  return "Sou9"
   elseif $cT ==  $cPIN1 Then
	  return "Pin1"
   elseif $cT ==  $cPIN2 Then
	  return "Pin2"
   elseif $cT ==  $cPIN3 Then
	  return "Pin3"
   elseif $cT ==  $cPIN4 Then
	  return "Pin4"
   elseif $cT ==  $cPIN5 Then
	  return "Pin5"
   elseif $cT ==  $cPIN5r Then
	  return "Pin5r"
   elseif $cT ==  $cPIN6 Then
	  return "Pin6"
   elseif $cT ==  $cPIN7 Then
	  return "Pin7"
   elseif $cT ==  $cPIN8 Then
	  return "Pin8"
   elseif $cT ==  $cPIN9 Then
	  return "Pin9"
   elseif $cT ==  $cTON Then
	  return "Ton"
   elseif $cT ==  $cNAN Then
	  return "Nan"
   elseif $cT ==  $cSHAA Then
	  return "Shaa"
   elseif $cT ==  $cPEI Then
	  return "Pei"
   elseif $cT ==  $cCHUN Then
	  return "Chun"
   elseif $cT ==  $cHAKU Then
	  return "Haku"
   elseif $cT ==  $cHATSU Then
	  return "Hatsu"

   EndIF
EndFunc