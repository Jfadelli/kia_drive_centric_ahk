SetTitleMatchMode, 2
CoordMode, Mouse, Screen
#Include ./coords.ahk

global GuiTitle := ""
global ActionSelection := ""
global Dwell := 250

MoveClick(obj) {
    ; Extract relevant information from the object
    x := obj.x ; X-coordinate relative to the screen
    y := obj.y ; Y-coordinate relative to the screen
    sleepTime := obj.sleepTime
    MouseMove, % x, % y
    Sleep, 25
    Click
    Sleep, % sleepTime
    Sleep, % Dwell
}

MoveDoubleClick(obj){
    ; Extract relevant information from the object
    x := obj.x ; X-coordinate relative to the screen
    y := obj.y ; Y-coordinate relative to the screen
    sleepTime := obj.sleepTime 
    MouseMove, % x, % y
    Sleep, 5
    Click
    Click
    Sleep, % sleepTime
}

`::
    Gui, Destroy
    ActionSelection := ""
    GuiTitle := "Action Selector"
    ShowGui(GuiTitle)
    return

HandleActionSelection:
    Gui, Destroy
    Gosub, MainLoop

HandleEscape:
    Gui, Destroy
    return

MainLoop:
    Gui, Destroy
    MouseGetPos, xOrigin, yOrigin
    if(ActionSelection = "Quick Call"){
        MoveClick(CallTabButton)
        MoveClick(CallButton)
        MoveClick(RefreshSecondBrowserButton)
        MoveClick(EndCallButton)
        MoveClick(CallOutcomeDropdownMenu)
        MoveClick(CallOutcomeDidNotLeaveVoicemail)
        MoveClick(LogCallButton)
    } else if (ActionSelection = "Quick Call - Log 2nd Call") {
        MoveClick(LogCall2OutcomeDropDown)
        MoveClick(LogCall2OutcomeDropDownDidNotLeaveVoicemail)
        MoveClick(LogCall2Button)
    } else if (ActionSelection = "Email - New Inquiry") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(TemplateSelection1)
    } else if (ActionSelection = "Text - Opt In" ){
        MoveClick(TextTabButton)
        MoveClick(OptInButton)
    } else if (ActionSelection = "Text - New Inquiry" ){
        MoveClick(TextTabButton)
        MoveClick(TextTemplateButton)
        MoveClick(TextTemplateSelection1)
        MoveClick(TextTemplateSelectionConfirmationButton)
        MoveClick(TextSendButton)
    } else if (ActionSelection = "Email - Follow Up") {
        MoveClick(EmailTabButton)
        MoveClick(EmailTemplateCatagoryDropDownMenu)
        MoveClick(EmailPersonalTemplateButton)
        MoveClick(EmailTemplateDropDownMenu)
        MoveClick(EmailTemplateFollowUpGeneral)
    } else if (ActionSelection = "Text - Follow Up") {
        MoveClick(TextTabButton)
        MoveClick(TextTemplateButton)
        MoveClick(TextTemplateSelection2)
        MoveClick(TextTemplateSelectionConfirmationButton)
        MoveClick(TextSendButton)
    } else if (ActionSelection = "Email - Trade In") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(TemplateSelection3)
    } else if (ActionSelection = "Email - Back In Stock") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(EMailTemplateBackInStock)
    } else if (ActionSelection = "Text - Trade In") {
        MoveClick(TextTabButton)
        MoveClick(TextBoxTextArea)
        filePathSubject := "C:\Users\jfadelli\Desktop\AHK\txt files\texts\trade_in_text.txt"
        fileSubject := FileOpen(filePathSubject, "r")
        if (fileSubject)
        {
            fileSubjectContents := fileSubject.Read()
            fileSubject.Close()
            clipboard := fileSubjectContents
        }
        else
        {
            MsgBox, Failed to open the subject file., 100
        }
        send, ^v
        MoveDoubleClick(FirstName)
        send, ^c
        MoveDoubleClick(FirstNameUnderlineSpot)
        send, ^v
        send, {Backspace}
        sleep, 10
        MoveDoubleClick(VehicleUnderlineSpot)

    } else if (ActionSelection = "Email - Mining") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(TemplateSelection5)
    }
    MouseMove, %xOrigin%, %yOrigin%, 0
        return
    
    return

ShowGUI(GuiTitle) {
    if (GuiTitle = "Action Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Quick Call
        Gui, Add, Text, , Press Shift + 1 for Quick Call
        Gui, Add, Text, , Press 2 for Email - New Inquiry
        Gui, Add, Text, , Press 3 for Text - Opt In
        Gui, Add, Text, , Press 3 for Text - New Inquiry
        Gui, Add, Text, , ---------------------------------
        Gui, Add, Text, , Press 4 for Email - Follow Up
        Gui, Add, Text, , Press Shift + 4 for Email - Back In Stock

        Gui, Add, Text, , Press 5 for Text - Follow Up
        Gui, Add, Text, , ---------------------------------
        Gui, Add, Text, , Press 6 for Email - Trade In
        Gui, Add, Text, , Press 7 for Text - Trade In
        Gui, Add, Text, , ---------------------------------
        Gui, Add, Text, , Press 8 for Email - Mining
        Gui, Add, Button, Hidden w0 h0 Default gHandleActionSelection, Save
    } 
    Gui, Show, w300 h400, %GuiTitle%
    return
}

#IfWinActive, Action Selector
1:: ActionSelection := "Quick Call", Gosub, HandleActionSelection
+1:: ActionSelection := "Quick Call - Log 2nd Call", Gosub, HandleActionSelection
2:: ActionSelection := "Email - New Inquiry", Gosub, HandleActionSelection
3:: ActionSelection := "Text - Opt In", Gosub, HandleActionSelection
+3:: ActionSelection := "Text - New Inquiry", Gosub, HandleActionSelection
4:: ActionSelection := "Email - Follow Up", Gosub, HandleActionSelection
+4:: ActionSelection := "Email - Back In Stock", Gosub, HandleActionSelection
5:: ActionSelection := "Text - Follow Up", Gosub, HandleActionSelection
6:: ActionSelection := "Email - Trade In", Gosub, HandleActionSelection
7:: ActionSelection := "Text - Trade In", Gosub, HandleActionSelection
8:: ActionSelection := "Email - Mining", Gosub, HandleActionSelection

Escape:: Gosub, HandleEscape
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Launch New Chrome Window
^!t:: Run, chrome.exe

; Misc Hotkeys

; Text Loop
#`::
counter := 0
; Path to the text file containing the names
filePath := "C:\Users\jfadelli\Desktop\AHK\txt files\names\text.txt"
; Open the file for reading
FileRead, fileContent, %filePath%
; Split the file content into lines (names)
Loop, parse, fileContent, `n, `r
{
    counter ++ 1
    currentName := A_LoopField
    ; Trim any extra whitespace from the name
    currentName := Trim(currentName)
    
    MoveClick(SearchForCustomer)
    Send, ^a
    Send, {Backspace}
    Sleep, 50
    Send, %currentName%
    Sleep, 1000
    MoveClick(SelectCustomerFromSearch)
    MoveClick(TextTabButton)
    MoveClick(TextTemplateButton)
    MoveClick(TextTemplateSelection5)
    MoveClick(TextTemplateSelectionConfirmationButton)
    MoveClick(TextSendButton)
    MoveClick(ExitCustomerProfilePage)
    if (mod(counter, 10) == 0)
        {
            MsgBox, 4, , Reached 5 cycles. Continue? (Yes/No)
            IfMsgBox, No
                break  ; Stop the loop if 'No' is clicmod(counter,
        }
}

return

; Email loop 2.0
+#`::
counter := 0
; Path to the text file containing the names
filePath := "C:\Users\jfadelli\Desktop\AHK\txt files\names\email.txt"
; Open the file for reading
FileRead, fileContent, %filePath%
; Split the file content into lines (names)
Loop, parse, fileContent, `n, `r
{
    counter ++ 1
    currentName := A_LoopField
    ; Trim any extra whitespace from the name
    currentName := Trim(currentName)
    
    MoveClick(SearchForCustomer)
    Send, ^a
    Send, {Backspace}
    Sleep, 50
    Send, %currentName%
    Sleep, 750
    MoveClick(SelectCustomerFromSearch)
    MoveClick(EmailTabButton)
    MoveClick(EmailTemplateCatagoryDropDownMenu)
    MoveClick(EmailPersonalTemplateButton)
    MoveClick(EmailTemplateDropDownMenu)
    MoveClick(EmailTemplateMyOrphans)
    MoveClick(EmailSendButton)
    MoveClick(ExitCustomerProfilePage)

    if (mod(counter, 10) == 0)
        {
            MsgBox, 4, , Reached 5 cycles. Continue? (Yes/No)
            IfMsgBox, No
                break  ; Stop the loop if 'No' is clicmod(counter,
        }
        
    }
return


+F5::
    ; Check if Chrome is active
    IfWinNotExist, Google Sheets
    {
        ; If Chrome is not active, activate it and open a new tab with the specified URL
        Run, chrome.exe "https://sheets.google.com"
        WinWait, Google Sheets
    }
    else
    {
        ; If Chrome is already active, open a new tab with the specified URL
        WinActivate, Google
        Send, ^t
        Sleep, 100
        Send, https://sheets.google.com
    }
return

+F4::
    ; Check if Chrome is active
    IfWinNotExist, Google Docs
    {
        ; If Chrome is not active, activate it and open a new tab with the specified URL
        Run, chrome.exe "https://docs.google.com"
        WinWait, Google Docs
    }
    else
    {
        ; If Chrome is already active, open a new tab with the specified URL
        WinActivate, Google
        Send, ^t
        Sleep, 100
        Send, https://docs.google.com
    }
return

PgDn::
    ; Check if Chrome is active
    WinActivate, ahk_exe chrome.exe
    Sleep, 50
    ; Activate the tab with the specified title
    WinActivate, Home / DriveCentric
    Sleep, 50

    ; Additional mouse actions after opening the Shift+F3 URL
    MouseMove, 33, 225
    SendEvent {Click}
    Sleep, 750
    MouseMove, 420, 225
    SendEvent {Click}
return

#Right::
    CoordMode, mouse, Screen
    MouseGetPos, xOrigin, yOrigin
    MouseMove, 1644, 529, 0
    SendEvent, {Click}
    Sleep, 5
    MouseMove, %xOrigin%, %yOrigin%, 0
    CoordMode, Mouse, Window
return

#Left::
    CoordMode, mouse, Screen
    MouseGetPos, xOrigin, yOrigin
    MouseMove, 276, 529, 0
    SendEvent, {Click}
    Sleep, 5
    MouseMove, %xOrigin%, %yOrigin%, 0
    CoordMode, Mouse, Window
return


#u::
    ; Copy currently selected text to clipboard
    Send, ^c
    ClipWait
    
    ; Get the clipboard content
    ClipboardContent := Clipboard
    
    ; If there's text in the clipboard
    if (ClipboardContent != "") {
        ; Open new Chrome tab with the specified URL
        Run, chrome.exe "https://www.premierkiaofcarlsbad.com/used-vehicles/?q="%ClipboardContent%"&_dFR%5Btype%5D%5B0%5D=Used",, UseErrorLevel
        ; Check for errors
        if ErrorLevel
            MsgBox, Error opening Chrome tab.
    } else {
        MsgBox, No text selected to use in the URL.
    }
return

#n::
    ; Copy currently selected text to clipboard
    Send, ^c
    ClipWait
    
    ; Get the clipboard content
    ClipboardContent := Clipboard
    
    ; If there's text in the clipboard
    if (ClipboardContent != "") {
        ; Open new Chrome tab with the specified URL
        Run, chrome.exe "https://www.premierkiaofcarlsbad.com/new-vehicles/?q="%ClipboardContent%"&_dFR%5Btype%5D%5B0%5D=New",, UseErrorLevel
        ; Check for errors
        if ErrorLevel
            MsgBox, Error opening Chrome tab.
    } else {
        MsgBox, No text selected to use in the URL.
    }
return

^#w:: ; Wishlist
    Run, chrome.exe "https://docs.google.com/spreadsheets/d/1ky3eBpprlqT-PRmj6WgcM7yrUjQLpl0SRuzP3uvJMro/edit#gid=0"
return


;get monroney
; Hotkey to trigger the input box
^#v::  ; win + ctrl + v as the hotkey.
InputBox, vin, Enter VIN, Please enter the VIN:
if ErrorLevel  ; Checks if the user pressed Cancel.
{
    MsgBox, You cancelled.
}
else
{
    url := "https://get-monroney-server-43d02c80534a.herokuapp.com/getMonroney/" . vin
    Run, chrome.exe %url%
}
return

^#n:: ; New Cars
    Run, chrome.exe "https://www.premierkiaofcarlsbad.com/new-vehicles/"
return


^#u:: ;Used carsv
    Run, chrome.exe "https://www.premierkiaofcarlsbad.com/used-vehicles/"
return

^#r:: ;Recon
    Run, chrome.exe "https://app2.reconvelocity.com/login"
return

^#k:: ;Kdealer
    Run, chrome.exe "https://www.kdealer.com/commonDashboard"
return 

; 
#c:: ;Costco Auto Program
    Run, chrome.exe "https://dealers.costcoauto.com/" ;
return

>!n::  ; This is the hotkey for Right Alt + N
    Send, 760.496.3140 
return

>!j::  ; This is the hotkey for Right Alt + J
    Send, Jason 
return


#LButton::
MouseGetPos, xOrigin, yOrigin
Send, {Click}
Sleep, 100
MoveClick(RemoveTaskConfirmation)
MouseMove, %xOrigin%, %yOrigin%
return


#Enter::
MouseGetPos, xOrigin, yOrigin
MoveClick(EmailSendButton)
MouseMove, %xOrigin%, %yOrigin%
return

>^Enter::
MouseGetPos, xOrigin, yOrigin
MoveClick(EmailSendButton)
MouseMove, %xOrigin%, %yOrigin%
return

^#Enter::
MouseGetPos, xOrigin, yOrigin
MoveClick(ResendOptInTextButton)
Sleep, 5
MoveClick(OptInButtonUpper)
MouseMove, %xOrigin%, %yOrigin%
return


#v::
    MouseGetPos, xOrigin, yOrigin
    MoveClick(SecondWindowCallOutcomeDropDownMenu)
    MoveClick(SecondWindowOutcomeLeftVoicemail)
    MoveClick(SecondWindowLogCall)
    MouseMove, %xOrigin%, %yOrigin%
return 

; ; Remap Control + XButton1 to copy
; ^XButton1::
;     Send, ^c
;     return

; ; Remap Control + XButton2 to paste
; ^XButton2::
;     Send, ^v
;     return

; USED CAR CUSTOMERS
; ////////////////////////////////////////////////////
; XButton2::
    ; Send, ^w
    ; return

; ; XButton1:: 
;     Send, {Click}
;     ClipWait
;     ClipboardContent := Clipboard
;     if (ClipboardContent != "") {
;         ; Open new Chrome tab with the specified URL
;         Run, chrome.exe "https://www.premierkiaofcarlsbad.com/inventory?keyword="%ClipboardContent%"&submit=Submit&type=used",, UseErrorLevel
;         ; Check for errors
;         if ErrorLevel
;             MsgBox, Error opening Chrome tab.
;     } else {
;         MsgBox, No text selected to use in the URL.
;     }
;     return
; /////////////////////////////////////////////////////////
F1::
Click 1190, 402
Sleep, 2500
Click 1184, 113
Sleep, 1500
Click 891, 407
Sleep, 250
Click 767, 492
Sleep, 250
Click 1200, 607

F2:: 
CoordMode, mouse, Screen
MouseGetPos, xOrigin, yOrigin
MouseMove, 1644, 529, 0
SendEvent, {Click}
Sleep, 5
MouseMove, %xOrigin%, %yOrigin%, 0
CoordMode, Mouse, Window
Return