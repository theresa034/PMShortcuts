﻿/*;========================================================
;==  INI Values (DO NOT ADJUST THE LINE SPACING!!!)
;==========================================================
[INI_Section]
version=9
MailShopVersion=6



*/

; Generated by AutoGUI 2.5.8
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

IniRead,AccessToken,L:\FIVEMAPLES\Theresa\AutoHotKey\Shortcuts.ini, AccessTokens, ShortCutAccessToken, "ERROR - NO KEY FOUND!"

#Include L:\FIVEMAPLES\Theresa\AutoHotKey\PMShortcuts\PMShortcuts\Lib\ControlColor.ahk

;===========================================================
;==  Update Module
;===========================================================
; Files if hosted on Github    : L:\FIVEMAPLES\Theresa\AutoHotKey\Shortcuts.ini

SetTimer UpdateCheck, 60000 ; Check each minute
;Return

ButtonRestartToolkit:
^+r:: ;c 🌟 Restart Theresa's ShortCutToolkit ⌨️ Ctrl+Shift++r | Pressing Ctrl+Shift+r will restart the ShortCutToolkit - use this if it freezes up on you.
{
	Progress, w250,,, Hold yer ponies,  I'm restarting…
	vRestart := 0
	loop, 45
	{
        Progress, %vRestart%
        vRestart := vRestart + 10
        sleep, 1
	}
	Progress,  Off
	MsgBox, 0, , Rebooted - please click 'OK' to proceed., 1
	Reload
	;L:\FIVEMAPLES\Theresa\AutoHotKey\Shortcuts.ini
}


UpdateCheck:
If (A_Hour = 01 And A_Min = 12)
{
	Progress, w250,,, Hold yer ponies,  I'm updating…
	Sleep, 2000
	Progress, off
	gosub VersionCheck
	}
Return
*/

VersionCheck:
^!t:: ; c If you didn't trigger this window by pressing 'Win+F2', then it must mean that you had an update last night! Yay! (you can click OK)
{
; IniRead, OutputVar, C:\Temp\myfile.ini, section2, key
; MsgBox, The value is %OutputVar%.
; FileReadLine, %CurrentVer%, ShortcutGUI.ahk, 5
; FileReadLine, %NewVer%, https://raw.githubusercontent.com/theresa034/PMShortcuts/master/ShortcutGUI.ahk?token=AC2LTXPVTNFEJCI5HBCAEQS46ZV52, 5
IniRead, CurrentVer, ShortcutGUI.ahk, INI_Section, version
UrlDownloadToFile, %AccessToken%, JunkKit.ahk ; PRODUCTION
IniRead, NewVer, JunkKit.ahk, INI_Section, version
FileDelete, JunkKit.ahk
if (CurrentVer < NewVer)
	{
	gosub UpdateScript ; Insert the following above if you need to check anything in the future: MsgBox, %CurrentVer% & %NewVer%
	Return
	}
Return
}
ButtonForceUpdate:
UpdateScript:
;^!u:: ;c 🌟 Update Script ⌨️ Ctrl+Shift+Win+u | Typing Ctrl+Shift+Win+u will trigger an update of the script - also automatically triggered every morning at 1:15am
{
	UrlDownloadToFile, %AccessToken%, ShortcutGUI.ahk ;*[ShortcutGUI]
	;Progress, w250,,, Hold yer ponies,  I'm updating…
	MsgBox If you see me, I either just updated when you triggered me to, or I updated last night. Either way, please click 'OK', and go about your day! Also, press 'Win+F2' to open up a quick help cheat-sheet.
	Reload
	ExitApp
}

;===========================================================
;==  PM Dashboard
;===========================================================

#space:: ;c 🌟 PM Dashboard ⌨️ windows+Space | windows+Space will launch what I like to call the "PM Dashboard", which contains most of the clickable commands
{
    IfWinNotExist PM Dashboard
	{

		Gui +hWndhMainWnd
		Gui Color, 0x25408F
		Gui Font, s14, Segoe Print
		Gui Add, Text, hWndhTxt x7 y3 w517 h32 +0x200 +Center -Background, Welcome to the PM Shortcut Menu
		Gui Font, s12, Segoe Print
		ControlColor(hTxt, hMainWnd, 0x25408F, 0xFFFFFF)
		Gui Font, s12, Segoe Print
		Gui Add, Button, x7 y40 w248 h36, Pricing Beta
		Gui Add, Button, x7 y80 w248 h36, Pricing Old
		Gui Add, Button, x7 y120 w248 h36, Turnaround Times
		Gui Add, Button, x7 y160 w248 h36, PM Platform
		Gui Add, Button, x7 y200 w248 h36, Weekly Hours
		Gui Add, Button, x7 y240 w248 h36, Work Order Checklist
		
		Gui Add, Button, x262 y40 w248 h36, Email NCOA PAF
		Gui Add, Button, x262 y80 w248 h36, Email Proofs	
		Gui Add, Button, x262 y120 w248 h36, Email Firebird Proofs
		Gui Add, Button, x262 y160 w248 h36, Email Past Due Invoices
		Gui Add, Button, x262 y200 w248 h36, Force Update
		Gui Add, Button, x262 y240 w248 h36, Estimate Comments

		Gui Show, w517 h420, PM Shortcuts

		Return
	}
    Else
    {
        Gui PMDashboard:Cancel
        Gui, submit
        Return
    }
    Return
}

;===========================================================
;==  Pricing Beta
;===========================================================

ButtonPricingBeta:
Run, L:\FiveMaplesSales\PRICES\pricing-BETA.xlsm
Return
;===========================================================
;==  Pricing Old
;===========================================================

ButtonPricingOld:
Run, L:\FiveMaplesSales\PRICES\pricing-190101.xlsm
Return

;===========================================================
;==  Turnaround Times
;===========================================================

ButtonTurnaroundTimes:
Run, L:\FIVEMAPLES\Procedures and Training\Procedures - Project Management\Standard Turn Around Times\Standard Turn Around Times_Final.xlsm
Return

;===========================================================
;==  PM Platform
;===========================================================

ButtonPMPlatform:
Run, https://sites.google.com/fivemaples.com/pm-toolkit/home
Return

;===========================================================
;==  Weekly Hours
;===========================================================

ButtonWeeklyHours:
#^h:: ;ctrl+win+h
	Run, %A_Desktop%\Weekly Hours for Payroll.xlsx
	Return

;===========================================================
;==  Work Order Checklist
;===========================================================

ButtonWorkOrderChecklist:
Run, https://theresa034.github.io/WorkOrderChecklist/workorderchecklist.html
Return

;===========================================================
;==  Email NCOA PAF Packet
;===========================================================

ButtonEmailNCOAPAF:
;+^n:: ;Ctrl+Shift+n | Ctrl+Shift+n will trigger this code

	m := ComObjCreate("Outlook.Application").CreateItem(0) ; 0 = olMailItem
	m.Subject := "PAF Form for NCOA"
	m.To := ""
	m.Body := "Dear [Client Name] `n`nI have attached an editable PDF of the Processing Acknowledgement Form (PAF) and information packet for your review. This is needed for running the names through the National Change of Address (NCOA) database and is required for all new lists and must be run every 90 days thereafter. The PAF form only needs to be filled out yearly.`n`nPlease fill out the red-highlighted boxes in the first attachment and return to me by [Due Date].`n`nLet me know if you have any questions.`n`nThanks, "
	m.attachments.add("L:\FIVEMAPLES\PMPlatform\ChecklistsAndForms\NCOAPAFpacket.pdf")
	m.Display ;to display the email message...and the really cool part, if you leave this line out, it will not show the window............... but the m.send below will still send the email!!!
	
	Return

;===========================================================
;==  Email Proofs
;===========================================================

ButtonEmailProofs:
;+^p:: ;Ctrl+Shift+p | Ctrl+Shift+p will trigger this code

	m := ComObjCreate("Outlook.Application").CreateItem(0) ; 0 = olMailItem
	m.Subject := "[Work Order]-[Customer]-[Proof Type]"
	m.To := ""
	m.Body := "Hi [Client Name]!`n`nAttached are the [Proof Type] proofs for your [Project] mailing.`n`nPlease let me know if everything looks good or if you’d like to see changes.`n`nThanks! "
	m.Display ;to display the email message...and the really cool part, if you leave this line out, it will not show the window............... but the m.send below will still send the email!!!
	
	Return

;===========================================================
;==  Email Firebird Proofs
;===========================================================

ButtonEmailFirebirdProofs:
;+^f:: ;Ctrl+Shift+f | Ctrl+Shift+f will trigger this code

	m := ComObjCreate("Outlook.Application").CreateItem(0) ; 0 = olMailItem
	m.Subject := "IMB Verification for Five Maples Job [Work Order]"
	m.To := "linda@firebirdpresort.com, kim@firebirdpresort.com"
	m.Body := "Hello! `n`nAttached are some sample IMB’s for Five Maples Job [Work Order]. Please verify that these are correct.`n`nThank you, "
	m.Display ;to display the email message...and the really cool part, if you leave this line out, it will not show the window............... but the m.send below will still send the email!!!
	
	Return
	
;===========================================================
;==  Email Past Due Invoices
;===========================================================

ButtonEmailPastDueInvoices:
;+^i:: ;Ctrl+Shift+i | Ctrl+Shift+i will trigger this code

	m := ComObjCreate("Outlook.Application").CreateItem(0) ; 0 = olMailItem
	m.Subject := "Past Due Invoice"
	m.To := ""
	m.Body := "Hi [Client Name]! `n`nHope this note finds you well! I want to follow up on invoice [Number]. Our billing department has not yet received payment. Could you please check to see that the accounts payable department has received it? I’ve attached the invoice here, just in case!`n`nI appreciate your help!"
	m.Display ;to display the email message...and the really cool part, if you leave this line out, it will not show the window............... but the m.send below will still send the email!!!
	
	Return

;===========================================================
;==  Enter Estimate Comments
;===========================================================

ButtonEstimateComments:
{
Run, L:\FIVEMAPLES\Theresa\AutoHotKey\PMShortcuts\EstimateComments.docx
return
}