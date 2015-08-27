Global $SkinFolder = "Img\"
Global $SkinFolder90 = "Img\"

Func Settings()
   $SkinFolder = "Img\" & GUICtrlRead($Default) & "\"
   $SkinFolder90 = "Img\" & GUICtrlRead($Default90) & "\"
EndFunc
