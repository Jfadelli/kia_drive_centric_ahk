SetTitleMatchMode, 2
CoordMode, Mouse, Screen

global GuiTitle := ""
global TextSelection := ""
global ModelSelection := ""
global EmailSelection := ""
global CustomerTypeSelection := ""
global ActionSelection := ""
global NewInquirySelection := ""
global ExistingCustomerSelection := ""

global TemplateCatagoryDropDownMenu := {x: 950, y: 396, sleepTime:500}
global PersonalTemplateButton := {x: 920, y:465, sleepTime:500}
global TemplateDropDownMenu:= {x:1100,y:400, sleepTime:500}
global TemplateSelection1:= {x:1100, y:445, sleepTime:0}
global TemplateSelection2:= {x: 1100, y:460, sleepTime:0}
global TemplateSelection3:= {x: 1100, y: 480, sleepTime:0}
global TemplateSelection4:= {x: 1100, y:500, sleepTime:0}
global CallTabButton:= {x:660, y:350, sleepTime:250}
global EmailTabButton:= {x:765, y:350, sleepTime:250}
global TextTabButton:= {x: 870, y: 350, sleepTime:250}
global OptInButton := {x:1183, y:525, sleepTime:100}
global CallButton := {x:1184 , y:411 , sleepTime:500}
global RefreshSecondBrowserButton := {x:93, y:-1017 , sleepTime:2500}
global EndCallButton := {x:1170, y:120 , sleepTime:1000}
global CallOutcomeDropdownMenu := {x:830, y:419, sleepTime:500}
global CallOutcomeDidNotLeaveVoicemail := {x:830, y:499, sleepTime:250}
global LogCallButton := {x:1200, y:628, sleepTime:250}
global Dwell := 500

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

`::
    Gui, Destroy
    GuiTitle := ""
    TextSelection := ""
    ModelSelection := ""
    EmailSelection := ""
    CustomerTypeSelection := ""
    ActionSelection := ""
    NewInquirySelection := ""
    ExistingCustomerSelection := ""

    GuiTitle := "Customer Selector"
    ShowGui(GuiTitle)
    return

HandleEscape:
    Gui, Destroy
    return

HandleCustomerTypeSelection:
    Gui, Submit
    Gui, Destroy
    if (CustomerTypeSelection = "New Inquiry") {
        ShowGUI("New Inquiry Selector")
        ; MsgBox, , % CustomerTypeSelection
        return
    } else if (CustomerTypeSelection = "Existing Customer"){
        ShowGUI("Existing Customer Selector")
        ; MsgBox, , % CustomerTypeSelection
        return
    } else if (CustomerTypeSelection = "Opt In - Quick"){
        ShowGUI("Confirmation Screen")
        ; msgbox, Opt In - Quick
        return
    }
    return  

HandleNewInquirySelection:
    Gui, Submit
    Gui, Destroy
    ShowGUI("Confirmation Screen")
    return

HandleExistingCustomerSelection:
    Gui, Submit
    Gui, Destroy
    if (ExistingCustomerSelection = "Text") { 
        ShowGUI("Text Selector")
        return
    } else if (ExistingCustomerSelection = "Email") {
        ShowGUI("Email Selector")
        return
    }
    return

HandleModelSelection:
    Gui, Submit
    Gui, Destroy
    return

HandleTextSelection:
    Gui, Submit
    Gui, Destroy
    ShowGUI("Confirmation Screen")
    return

HandleEmailSelection:
    Gui, Submit
    Gui, Destroy
    ShowGUI("Confirmation Screen")
    return

HandleConfirmation:
    Gui, Submit
    return

MainLoop:
    Gui, Destroy
    if(CustomerTypeSelection = "New Inquiry"){
        MouseGetPos, xOrigin, yOrigin
        if (NewInquirySelection = "Opt In" ){
            MoveClick(TextTabButton)
            MoveClick(OptInButton)
        } else if (NewInquirySelection = "New Inquiry Email") {
            MoveClick(EmailTabButton)
            MoveClick(TemplateCatagoryDropDownMenu)
            MoveClick(PersonalTemplateButton)
            MoveClick(TemplateDropDownMenu)
            MoveClick(TemplateSelection1)
        } else if (NewInquirySelection = "Quick Call") {
            MoveClick(CallTabButton)
            MoveClick(CallButton)
            MoveClick(RefreshSecondBrowserButton)
            MoveClick(EndCallButton)
            MoveClick(CallOutcomeDropdownMenu)
            MoveClick(CallOutcomeDidNotLeaveVoicemail)
            MoveClick(LogCallButton)
        }
        MouseMove, %xOrigin%, %yOrigin%, 0
        return
    } else if (CustomerTypeSelection = "Existing Customer"){
        msgbox, 123456
        if (ExistingCustomerSelection = "Text") {
            msgbox, 12345

        } else if (ExistingCustomerSelection = "Email") {
            
        } else if (ExistingCustomerSelection = "Call") {

        }
        return
    } else if (CustomerTypeSelection = "Opt In - Quick") {
        MouseGetPos, xOrigin, yOrigin
        MoveClick(TextTabButton)
        MoveClick(OptInButton)
        MouseMove, %xOrigin%, %yOrigin%, 0
        return
    } 
    return

ShowGUI(GuiTitle) {
    if (GuiTitle = "Customer Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for New Inquiry
        Gui, Add, Text, , Press 2 for Existing Customer
        Gui, Add, Text, , Press 3 for Opt In - Quick
        Gui, Add, Button, Hidden w0 h0 Default gHandleCustomerTypeSelection, Save
    } else if (GuiTitle = "New Inquiry Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Opt In
        Gui, Add, Text, , Press 2 for New Inquiry Email
        Gui, Add, Text, , Press 3 for Quick Call
        Gui, Add, Button, Hidden w0 h0 Default gHandleNewInquirySelection, Save
    } else if (GuiTitle = "Existing Customer Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Text
        Gui, Add, Text, , Press 2 for Email
        Gui, Add, Text, , Press 3 for Call
        Gui, Add, Button, Hidden w0 h0 Default gHandleExistingCustomerSelection, Save
    } else if (GuiTitle = "Text Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Opt In
        Gui, Add, Text, , Press 2 for Initial Text
        Gui, Add, Text, , Press 3 for Follow up 1
        Gui, Add, Text, , Press 4 for Follow up 2
        Gui, Add, Button, Hidden w0 h0 Default gHandleTextSelection, Save
    } else if (GuiTitle = "Email Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Initial Email
        Gui, Add, Text, , Press 2 for Follow up 1
        Gui, Add, Text, , Press 3 for Follow up 2
        Gui, Add, Button, Hidden w0 h0 Default gHandleEmailSelection, Save
    } else if (GuiTitle = "Confirmation Screen") {
        Gui, Add, Text, , Customer Type: %CustomerTypeSelection%
        Gui, Add, Text, , New Inquiry: %NewInquirySelection%
        Gui, Add, Text, , Action: %ActionSelection%
        Gui, Add, Text, , Communication Selection: %EmailSelection%
        Gui, Add, Text, , Model: %ModelSelection%
        Gui, Add, Button, Hidden w0 h0 Default gMainLoop, Save
    }
    Gui, Show, w300 h400, %GuiTitle%
    return
}

#IfWinActive, Customer Selector
1:: CustomerTypeSelection := "New Inquiry", Gosub, HandleCustomerTypeSelection ; Pressing 1 sets Selection and triggers SubRoutine HandleCustomerTypeSelection
2:: CustomerTypeSelection := "Existing Customer", Gosub, HandleCustomerTypeSelection
3:: CustomerTypeSelection := "Opt In - Quick", Gosub, HandleCustomerTypeSelection
Escape:: Gosub, HandleEscape
#IfWinActive

#IfWinActive, New Inquiry Selector
1:: NewInquirySelection := "Opt In", Gosub, HandleNewInquirySelection
2:: NewInquirySelection := "New Inquiry Email", Gosub, HandleNewInquirySelection
3:: NewInquirySelection := "Quick Call", Gosub, HandleNewInquirySelection
Escape:: Gosub, HandleEscape
#IfWinActive

#IfWinActive, Existing Customer Selector
1:: ExistingCustomerSelection := "Text", Gosub, HandleExistingCustomerSelection ; Pressing 1 sets Selection and triggers ButtonSave1
2:: ExistingCustomerSelection := "Email", Gosub, HandleExistingCustomerSelection
3:: ExistingCustomerSelection := "Call", Gosub, HandleExistingCustomerSelection
Escape:: Gosub, HandleEscape
#IfWinActive

#IfWinActive, Model Selector
1:: ModelSelection := "Telluride", Gosub, HandleModelSelection ; Pressing 1 sets Selection and triggers ButtonSave
2:: ModelSelection := "Sportage", Gosub, HandleModelSelection
+2:: ModelSelection := "Sportage Hybrid/PHEV", Gosub, HandleModelSelection
3:: ModelSelection := "Sorento", Gosub, HandleModelSelection
+3:: ModelSelection := "Sorento Hybrid/PHEV", Gosub, HandleModelSelection
4:: ModelSelection := "Forte", Gosub, HandleModelSelection
5:: ModelSelection := "K5", Gosub, HandleModelSelection
6:: ModelSelection := "EV6", Gosub, HandleModelSelection
+6:: ModelSelection := "EV9", Gosub, HandleModelSelection
7:: ModelSelection := "Niro", Gosub, HandleModelSelection
8:: ModelSelection := "Carnival", Gosub, HandleModelSelection
9:: ModelSelection := "Soul", Gosub, HandleModelSelection
+9:: ModelSelection := "Seltos", Gosub, HandleModelSelection
0:: ModelSelection := "Rio", Gosub, HandleModelSelection
-:: ModelSelection := "pre-owned vehicle", Gosub, HandleModelSelection
+:: ModelSelection := "car", Gosub, HandleModelSelection
Escape:: Gosub, HandleEscape
#IfWinActive

#IfWinActive, Text Selector
1:: TextSelection := "Opt In", Gosub, HandleTextSelection
2:: TextSelection := "Initial Text", Gosub, HandleTextSelection
3:: TextSelection := "Follow up 1", Gosub, HandleTextSelection
4:: TextSelection := "Follow up 2", Gosub, HandleTextSelection
Escape:: Gosub, HandleEscape
#IfWinActive

#IfWinActive, Email Selector
1:: EmailSelection := "Initial Email", Gosub, HandleEmailSelection
2:: EmailSelection := "Follow up 1", Gosub, HandleEmailSelection
3:: EmailSelection := "Follow up 2", Gosub, HandleEmailSelection
Escape:: Gosub, HandleEscape
#IfWinActive


