Global $tRoundWind = "East"
Global $taSelected[4] = [false,false,false,false]

; In a draw dealer is continued over
; Clicking nexthand without using the "ron" or "tsumo" buttons means a draw
; Renchan: 0
; East : PlayerCurrentlyDealer+1
; if dealer wins they can use renchan to play their dealer again

Func Selector($clickedimage)
   for $i = 0 to 3 Step 1
	  if $clickedImage == $PlayerIcon[$i] Then
		 if $taSelected[$i] == false Then
			$taSelected[$i] = true
			GUICtrlSetImage( $PlayerIcon[$i], PlayerIconFinder($i,true) )
		 Else
			$taSelected[$i] = false
			GUICtrlSetImage( $PlayerIcon[$i], PlayerIconFinder($i,false) )
		 EndIf
		 exitloop
	  EndIf
   Next
EndFunc

Func PlayerIconFinder($n, $selected)
   if $selected == true Then
	  if $n == 0 Then
		 return $etcFolder & "TonS.bmp"
	  elseif $n == 1 Then
		 return $etcFolder & "NanS.bmp"
	  elseif $n == 2 Then
		 return $etcFolder & "ShaaS.bmp"
	  Elseif $n == 3 Then
		 return $etcFolder & "PeiS.bmp"
	  EndIf
   Else
	  if $n == 0 Then
		 return $etcFolder & "TonNS.bmp"
	  elseif $n == 1 Then
		 return $etcFolder & "NanNS.bmp"
	  elseif $n == 2 Then
		 return $etcFolder & "ShaaNS.bmp"
	  Elseif $n == 3 Then
		 return $etcFolder & "PeiNS.bmp"
	  EndIf
   EndIf
EndFunc

Func RoundWindChanger($plus)
   if $plus == true Then

	  if $tRoundWind == "East" Then
		 $tRoundWind = "South"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Nan.bmp")

	  ElseIf $tRoundWind == "South" Then
		 $tRoundWind = "West"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Shaa.bmp")

	  ElseIf $tRoundWind == "West" Then
		 $tRoundWind = "North"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Pei.bmp")

	  ElseIf $tRoundWind == "North" Then
		 $tRoundWind = "East"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Ton.bmp")
	  EndIf

   Else

	  if $tRoundWind == "East" Then
		 $tRoundWind = "North"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Pei.bmp")

	  ElseIf $tRoundWind == "South" Then
		 $tRoundWind = "East"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Ton.bmp")

	  ElseIf $tRoundWind == "West" Then
		 $tRoundWind = "South"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Nan.bmp")

	  ElseIf $tRoundWind == "North" Then
		 $tRoundWind = "West"
		 GUICtrlSetImage($PicRoundWind, $etcFolder & "Shaa.bmp")
	  EndIf

   EndIf
EndFunc

Func RollDieTable()
   local $die[2]
   $die[0] = random(1,6,1)
   $die[1] = random(1,6,1)

   for $i = 0 to 1 Step 1
	  GUICtrlSetImage($DieFace[$i], "Img\etc\Default\d" & $die[$i] & ".bmp")
   Next
EndFunc