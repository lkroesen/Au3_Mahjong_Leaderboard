Global $SkinFolder = "Img\"
Global $SkinFolder90 = "Img\"
Global $Skins
; Todo modability of etc folder
Global $etcFolder = "Img\etc\Default\"

Func Settings()
   $SkinFolder = "Img\" & GUICtrlRead($Default) & "\"
   $SkinFolder90 = "Img\" & GUICtrlRead($Default90) & "\"
EndFunc

Func FindSkinsTiles()
    $Skins = _FileListToArray("Img\","*",$FLTA_FOLDERS)
	$Skins90 = _FileListToArray("Img\","*90",$FLTA_FOLDERS)

	for $i = 1 to $Skins90[0] Step 1
	  GUICtrlSetData($Default90, $Skins90[$i])
   Next

   for $i = 1 to $Skins[0] Step 1
	  if $Skins[$i] == "etc"  Then
	  Elseif $Skins[$i] == ($Skins[$i-1] & "90") Then
	  Else
	  GUICtrlSetData($Default, $Skins[$i])
	  EndIf
   Next
EndFunc
