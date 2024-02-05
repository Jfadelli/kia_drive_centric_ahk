SetTitleMatchMode, 2
CoordMode, Mouse, Screen

global GuiTitle := ""
global ActionSelection := ""

global Dwell := 500
global TemplateCatagoryDropDownMenu := {x: 950, y: 396, sleepTime:500}
global PersonalTemplateButton := {x: 920, y:465, sleepTime:500}
global TemplateDropDownMenu:= {x:1100,y:400, sleepTime:500}
global TemplateSelection1:= {x:1100, y:445, sleepTime:0}
global TemplateSelection2:= {x: 1100, y:460, sleepTime:0}
global TemplateSelection3:= {x: 1100, y: 480, sleepTime:0}
global TemplateSelection4:= {x: 1100, y:500, sleepTime:0}
global CallTabButton:= {x:660, y:350, sleepTime:250}
global EmailTabButton:= {x:765, y:350, sleepTime:750}
global TextTabButton:= {x: 870, y: 350, sleepTime:250}
global OptInButton := {x:1183, y:525, sleepTime:100}
global CallButton := {x:1184 , y:411 , sleepTime:500}
global RefreshSecondBrowserButton := {x:93, y:-1017 , sleepTime:2500}
global EndCallButton := {x:1170, y:120 , sleepTime:1000}
global CallOutcomeDropdownMenu := {x:830, y:419, sleepTime:500}
global CallOutcomeDidNotLeaveVoicemail := {x:830, y:499, sleepTime:250}
global LogCallButton := {x:1200, y:628, sleepTime:250}
global TextBoxTextArea := {x:536, y:401, sleepTime: 250}
global FirstName := {x:633, y:174, sleepTime:250}
global FirstNameUnderlineSpot := {x:600, y: 401, sleepTime:10}



MoveClick(obj) {
    ; Extract relevant information from the object
    x := obj.x ; X-coordinate relative to the screen
    y := obj.y ; Y-coordinate relative to the screen
    sleepTime := obj.sleepTime
    MouseMove, % x, % y
    Sleep, 25
    Click
    Sleep, % sleepTime
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

~::
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
    } else if (ActionSelection = "Email - New Inquiry") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(TemplateSelection1)
    } else if (ActionSelection = "Text - Opt In" ){
        MoveClick(TextTabButton)
        MoveClick(OptInButton)
    } else if (ActionSelection = "Email - Follow Up") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(TemplateSelection2)
    } else if (ActionSelection = "Text - Follow Up") {
        MoveClick(TextTabButton)
        MoveClick(TextBoxTextArea)
        filePathSubject := "C:\Users\jfadelli\Desktop\AHK\txt files\texts\text_2.txt"
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
    } else if (ActionSelection = "Email - Trade In") {
        MoveClick(EmailTabButton)
        MoveClick(TemplateCatagoryDropDownMenu)
        MoveClick(PersonalTemplateButton)
        MoveClick(TemplateDropDownMenu)
        MoveClick(TemplateSelection3)
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


    } 
    MouseMove, %xOrigin%, %yOrigin%, 0
        return
    
    return

ShowGUI(GuiTitle) {
    if (GuiTitle = "Action Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Quick Call
        Gui, Add, Text, , Press 2 for Email - New Inquiry
        Gui, Add, Text, , Press 3 for Text - Opt In
        Gui, Add, Text, , ---------------------------------
        Gui, Add, Text, , Press 4 for Email - Follow Up
        Gui, Add, Text, , Press 5 for Text - Follow Up
        Gui, Add, Text, , ---------------------------------
        Gui, Add, Text, , Press 6 for Email - Trade In
        Gui, Add, Text, , Press 7 for Text - Trade In
        Gui, Add, Button, Hidden w0 h0 Default gHandleActionSelection, Save
    } 
    Gui, Show, w300 h400, %GuiTitle%
    return
}

#IfWinActive, Action Selector
1:: ActionSelection := "Quick Call", Gosub, HandleActionSelection
2:: ActionSelection := "Email - New Inquiry", Gosub, HandleActionSelection
3:: ActionSelection := "Text - Opt In", Gosub, HandleActionSelection
4:: ActionSelection := "Email - Follow Up", Gosub, HandleActionSelection
5:: ActionSelection := "Text - Follow Up", Gosub, HandleActionSelection
6:: ActionSelection := "Email - Trade In", Gosub, HandleActionSelection
7:: ActionSelection := "Text - Trade In", Gosub, HandleActionSelection
Escape:: Gosub, HandleEscape
#IfWinActive
