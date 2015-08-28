#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <HotKeys.au3>
#include <Importer.au3>
#include <Database.au3>
#include <Settings.au3>
#include <Table.au3>

Global $TileTopRow[23]
Global $TileMidRow[17]
Global $TileBotRow[17]
Global $DoraTopRow[6]
Global $DoraBotRow[6]

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Mahjong Leaderboard", 818, 444, 192, 124)
$Tab = GUICtrlCreateTab(8, 8, 801, 425)
$TabSheet1 = GUICtrlCreateTabItem("Top Hand")
$inputHandName = GUICtrlCreateInput("Hand Name", 56, 216, 721, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))

#Region Tab Hand
; Mid Row Upside, 17 max, because the final tile will be on the TOP most row
; Mid row is for closed sets
for $i = 0 to 16 Step 1
   $TileMidRow[$i] 	= GUICtrlCreatePic("Img\Default\null.bmp", 50+($i * 43), 82, 43, 55)
Next

; Bot Row for Opened Sets
for $i = 0 to 16 Step 1
   $TileBotRow[$i] 	= GUICtrlCreatePic("Img\Default\null.bmp", 50+($i * 43), 144, 43, 55)
Next

; Top Row, the final drawn tile
for $i = 0 to 12 Step 1
   $TileTopRow[$i] 	= GUICtrlCreatePic("Img\Default90\null.bmp", 55+($i * 55), 40, 55, 43)
Next

; Dora Top
For $i = 0 to 5
   $DoraTopRow[$i] = GUICtrlCreatePic("Img\Default\empty.bmp", 56+($i*43), 296, 43, 55)
Next

;Dora Bottom
For $i = 0 to 5
   $DoraBotRow[$i] = GUICtrlCreatePic("Img\Default\empty.bmp", 56+($i*43), 350, 43, 55)
Next


$inputHan = GUICtrlCreateInput("Han / Type", 72, 256, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$inputFu = GUICtrlCreateInput("Fu / (N/A)", 208, 256, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$inputPlayerName = GUICtrlCreateInput("Player Name", 352, 256, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$inputDNoneDealer = GUICtrlCreateInput("Non Dealer / Dealer", 496, 256, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$inputTotalValue = GUICtrlCreateInput("Total Value", 640, 256, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$bImportToDB = GUICtrlCreateButton("Import to DB", 375, 310, 75, 25)
$bDeleteFromDB = GUICtrlCreateButton("DEL from DB", 375, 365, 75, 25)
$HandList = GUICtrlCreateList("", 496, 288, 280, 136)
#EndRegion

#Region Config
$TabSheet3 = GUICtrlCreateTabItem("Config")
$Group1 = GUICtrlCreateGroup("", 24, 40, 769, 385)
$Group2 = GUICtrlCreateGroup("Skin Options", 24, 40, 161, 89, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$Default = GUICtrlCreateCombo("Default", 32, 64, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$Default90 = GUICtrlCreateCombo("Default90", 32, 96, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
#EndRegion

#Region Hand Search
$TabSheet2 = GUICtrlCreateTabItem("Specific Hand")
$Group3 = GUICtrlCreateGroup("", 16, 40, 785, 385)
$iSearchByName = GUICtrlCreateInput("Search by Player Name", 36, 63, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$bSearchByName = GUICtrlCreateButton("Search", 172, 60, 75, 25)
$iSearchScore = GUICtrlCreateInput("Search by Score", 36, 104, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$bSearchScore = GUICtrlCreateButton("Search", 172, 104, 75, 25)
$List2 = GUICtrlCreateList("", 32, 192, 745, 214)
$iSearchType = GUICtrlCreateInput("Search by Type", 36, 144, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$bSearchType = GUICtrlCreateButton("Search", 172, 142, 75, 25)
$Input1 = GUICtrlCreateInput("Search by Han", 300, 64, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Button1 = GUICtrlCreateButton("Search", 444, 60, 75, 25)
$Input2 = GUICtrlCreateInput("Search by Fu", 300, 104, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Button2 = GUICtrlCreateButton("Search", 444, 104, 75, 25)
$Input3 = GUICtrlCreateInput("Search for Yakuman", 564, 64, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Button3 = GUICtrlCreateButton("Search", 700, 60, 75, 25)
$Input4 = GUICtrlCreateInput("Search for Yaku", 564, 104, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Button4 = GUICtrlCreateButton("Search", 700, 100, 75, 25)
$Input5 = GUICtrlCreateInput("Search by Nr of Yaku", 300, 144, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Button5 = GUICtrlCreateButton("Search", 444, 144, 75, 25)
$Input6 = GUICtrlCreateInput("Random", 564, 144, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Button6 = GUICtrlCreateButton("Search", 700, 140, 75, 25)
#EndRegion

Global $DieFace[2]
Global $dealerpic[4]
Global $bRiichiP[4]
Global $PlayerIcon[4]
Global $iPointsP[4]
Global $iPlayerName[4]
Global $imgRiichi[4]

#Region Table
$TabSheet4 = GUICtrlCreateTabItem("Table")
GUICtrlSetState(-1, $GUI_SHOW)

$iPlayerName[0] = GUICtrlCreateInput("iPlayerName1", 376, 344, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iPlayerName[1] = GUICtrlCreateInput("iPlayerName2", 656, 200, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iPlayerName[2] = GUICtrlCreateInput("iPlayerName3", 376, 56, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iPlayerName[3] = GUICtrlCreateInput("iPlayerName4", 86, 200, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))

$imgRiichi[0] = GUICtrlCreatePic("Img\etc\Default\RiichiStick.bmp", 316, 310, 174, 14)
GUICtrlCreateLabel("x0", 496, 311)

$iPointsP[0] = GUICtrlCreateInput("100000", 376, 368, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iPointsP[1] = GUICtrlCreateInput("100000", 656, 224, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iPointsP[2] = GUICtrlCreateInput("100000", 376, 80, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iPointsP[3] = GUICtrlCreateInput("100000", 86, 224, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))

$PlayerIcon[0] = GUICtrlCreatePic("Img\etc\Default\TonNS.bmp", 320, 344, 44, 44)
$PlayerIcon[1] = GUICtrlCreatePic("Img\etc\Default\NanNS.bmp", 600, 200, 44, 44)
$PlayerIcon[2] = GUICtrlCreatePic("Img\etc\Default\ShaaNS.bmp", 320, 56, 44, 44)
$PlayerIcon[3] = GUICtrlCreatePic("Img\etc\Default\PeiNS.bmp", 32, 200, 44, 44)

$dealerpic[0] = GUICtrlCreatePic("Img\etc\Default\dealer.bmp", 320, 390, 44, 22)
$dealerpic[1] = GUICtrlCreatePic("Img\etc\Default\dealer.bmp", 320, 106, 44, 22)
$dealerpic[2] = GUICtrlCreatePic("Img\etc\Default\dealer.bmp", 32, 250, 44, 22)
$dealerpic[3] = GUICtrlCreatePic("Img\etc\Default\dealer.bmp", 600, 250, 44, 22)

$bRiichiP[0] = GUICtrlCreateButton("Riichi", 396, 396, 75, 25)
$bRiichiP[1] = GUICtrlCreateButton("Riichi", 678, 254, 75, 25)
$bRiichiP[2] = GUICtrlCreateButton("Riichi", 396, 108, 75, 25)
$bRiichiP[3] = GUICtrlCreateButton("Riichi", 108, 254, 75, 25)

$DieFace[0] = GUICtrlCreatePic("Img\etc\Default\d1.bmp", 288, 200, 44, 44)
$DieFace[1] = GUICtrlCreatePic("Img\etc\Default\d1.bmp", 344, 200, 44, 44)
$bDiceRoll = GUICtrlCreateButton("Roll Dice", 300, 254, 75, 25)

$PicRoundWind = GUICtrlCreatePic("Img\etc\Default\Ton.bmp", 416, 200, 84, 84)
$bWindChangerMainPlus = GUICtrlCreateButton("+", 512, 208, 27, 25)
$bWindChangerMainMinus = GUICtrlCreateButton("-", 512, 248, 27, 25)

$bTie = GUICtrlCreateButton("Tie", 666, 376, 27, 25)
$iValue = GUICtrlCreateInput("", 624, 352, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$bRon = GUICtrlCreateButton("Ron", 624, 376, 35, 25)
$bTusmo = GUICtrlCreateButton("Tsumo", 702, 376, 43, 25)

Global $nHandNum = 1
Global $nBonusNum = 0
$iHandNumber = GUICtrlCreateInput($tRoundWind & " " & $nHandNum, 32, 56, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$iBonusNum = GUICtrlCreateInput("Renchan: " & $nBonusNum, 32, 96, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))

$bNextHand = GUICtrlCreateButton("Next Hand", 680, 56, 75, 25)
$bRenchan = GUICtrlCreateButton("Renchan", 680, 96, 75, 25)


$bDeselectAll = GUICtrlCreateButton("Deselect All", 56, 320, 75, 25)
$bSelectedDealer = GUICtrlCreateButton("Dealer", 56, 360, 75, 25)
#EndRegion

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; Inital Discoveries
Database()
FindSkinsTiles()

While 1
	$nMsg = GUIGetMsg()

	Selector($nMsg)

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		 Case $bDiceRoll
			RollDieTable()
		 Case $bImportToDB
			MoveToDB()
		 Case $bDeleteFromDB
			FileDelete("db/" & GUICtrlRead($HandList))
			_GUICtrlListBox_DeleteString($HandList, _GUICtrlListBox_GetCaretIndex($HandList))
			ClearHand()
		 Case $HandList
			ImportFromDB("db/" & GUICtrlRead($HandList))
			Show_Import()
		 Case $bWindChangerMainPlus
			RoundWindChanger(true)
		 Case $bWindChangerMainMinus
			RoundWindChanger(false)
	EndSwitch
WEnd
