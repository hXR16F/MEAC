#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;Programmed by hXR16F
;hXR16F.ar@gmail.com

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>

Local $16F = "16F"
#Region ### START Koda GUI section ###
$Form1 = GUICreate("Minecraft External AntiCheat", 585, 592, 465, 101, $GUI_SS_DEFAULT_GUI)
$Tab1 = GUICtrlCreateTab(4, 4, 579, 561, $TCS_MULTILINE)
GUICtrlSetFont(-1, 9, 400, 0, "Verdana")
$TabSheet2 = GUICtrlCreateTabItem("Minecraft folders")
$Edit1 = GUICtrlCreateEdit("", 8, 48, 569, 511, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TabSheet3 = GUICtrlCreateTabItem("Installed hacked clients")
$Edit8 = GUICtrlCreateEdit("", 8, 48, 283, 255, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_HSCROLL,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Name method")
$Edit9 = GUICtrlCreateEdit("", 8, 306, 569, 253, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Size method")
$Edit10 = GUICtrlCreateEdit("", 294, 48, 283, 255, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_HSCROLL,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Hash method")
$TabSheet4 = GUICtrlCreateTabItem("Running versions")
$Edit2 = GUICtrlCreateEdit("", 8, 48, 569, 511, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TabSheet5 = GUICtrlCreateTabItem("Cheat folders")
$Edit3 = GUICtrlCreateEdit("", 8, 48, 569, 511, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TabSheet6 = GUICtrlCreateTabItem("Installed mods")
$Edit4 = GUICtrlCreateEdit("", 8, 48, 569, 511, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TabSheet7 = GUICtrlCreateTabItem("Autoclickers/Macros")
$Edit5 = GUICtrlCreateEdit("", 8, 48, 569, 511, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TabSheet8 = GUICtrlCreateTabItem("Browsing history")
$Edit6 = GUICtrlCreateEdit("", 8, 48, 569, 511, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TabSheet9 = GUICtrlCreateTabItem("Log details")
$Edit7 = GUICtrlCreateEdit("", 8, 48, 569, 475, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Button1 = GUICtrlCreateButton("View logs", 8, 526, 569, 33)
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif")
$TabSheet1 = GUICtrlCreateTabItem("Update checker")
$Edit11 = GUICtrlCreateEdit("", 8, 48, 569, 475, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Nothing here...")
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Button2 = GUICtrlCreateButton("Update", 8, 526, 569, 33)
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif")
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
Dim $StatusBar1_PartsWidth[1] = [-1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, @TAB & "Programmed by hXR" & $16F, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Local $autoClickers_Macros = FileOpen(@ScriptDir & "\OUTPUT\autoClickers_Macros.txt", 0)
GUICtrlSetData($Edit5, FileRead($autoClickers_Macros))
FileClose($autoClickers_Macros)

Local $browsingHistory = FileOpen(@ScriptDir & "\OUTPUT\browsingHistory.txt", 0)
GUICtrlSetData($Edit6, FileRead($browsingHistory))
FileClose($browsingHistory)

Local $cheatFolders = FileOpen(@ScriptDir & "\OUTPUT\cheatFolders.txt", 0)
GUICtrlSetData($Edit3, FileRead($cheatFolders))
FileClose($cheatFolders)

Local $installedHackedClients_HASH = FileOpen(@ScriptDir & "\OUTPUT\installedHackedClients_HASH.txt", 0)
GUICtrlSetData($Edit10, FileRead($installedHackedClients_HASH))
FileClose($installedHackedClients_HASH)

Local $installedHackedClients_NAME = FileOpen(@ScriptDir & "\OUTPUT\installedHackedClients_NAME.txt", 0)
GUICtrlSetData($Edit8, FileRead($installedHackedClients_NAME))
FileClose($installedHackedClients_NAME)

Local $installedHackedClients_SIZE = FileOpen(@ScriptDir & "\OUTPUT\installedHackedClients_SIZE.txt", 0)
GUICtrlSetData($Edit9, FileRead($installedHackedClients_SIZE))
FileClose($installedHackedClients_SIZE)

Local $installedMods = FileOpen(@ScriptDir & "\OUTPUT\installedMods.txt", 0)
GUICtrlSetData($Edit4, FileRead($installedMods))
FileClose($installedMods)

Local $logDetails = FileOpen(@ScriptDir & "\OUTPUT\logDetails.txt", 0)
GUICtrlSetData($Edit7, FileRead($logDetails))
FileClose($logDetails)

Local $logPath = FileOpen(@ScriptDir & "\OUTPUT\logPath.txt", 0)
Global $logPathData = StringStripWS(FileRead($logPath), 1+2+4)
FileClose($logPath)

Local $minecraftFolders = FileOpen(@ScriptDir & "\OUTPUT\minecraftFolders.txt", 0)
GUICtrlSetData($Edit1, FileRead($minecraftFolders))
FileClose($minecraftFolders)

Local $runningVersions = FileOpen(@ScriptDir & "\OUTPUT\runningVersions.txt", 0)
GUICtrlSetData($Edit2, FileRead($runningVersions))
FileClose($runningVersions)

Local $update = FileOpen(@ScriptDir & "\OUTPUT\update.txt", 0)
GUICtrlSetData($Edit11, FileRead($update))
FileClose($update)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			;DirRemove("OUTPUT", 1)
			WinClose("MEAC")
			Exit
		Case $Button2
			Run(@ComSpec & " /c start " & "www.minecraft-external-anticheat.5v.pl", "", @SW_MINIMIZE)

		Case $Button1
			;MsgBox(0, "", @ScriptDir & "\OUTPUT\" & $logPathData)
			ShellExecute(@ScriptDir & "\OUTPUT\" & $logPathData)

	EndSwitch
WEnd
