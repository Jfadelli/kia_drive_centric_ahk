SetTitleMatchMode, 2
CoordMode, Mouse, Screen

global GuiTitle := ""
global TextSelection := ""
global ModelSelection := ""
global CustomerTypeSelection := ""
global ActionSelection := ""

loc := [
    {"EmailCategory", [ 950, 396]},
    {"TemplatesButton", [950 ,473]},
    {"TemplateCategory", [1100 ,400]},
    {"TemplateSelection1", [1100, 445]},
    {"TemplateSelection2", [1100, 460]},
    {"TemplateSelection3", [1100, 480]},
    {"TemplateSelection4", [1100,500]},
    {"Call", [660, 350]},
    {"Email", [765, 350]},
    {"Text", [870, 350]}
];


`::
    GuiTitle := ""
    TextSelection := ""
    ModelSelection := ""
    CustomerTypeSelection := ""
    ActionSelection := ""
    GuiTitle := "Customer Selector"
    ShowGui(GuiTitle)
    return

HandleEscape:
    Gui, Destroy
    return

HandleCustomerTypeSelection:
    Gui, Submit
    Gui, Destroy
    ShowGUI("Action Selector")
    return

HandleActionSelection:
    Gui, Submit
    Gui, Destroy
    if (ActionSelection = "Text") 
        {
            ShowGUI("Text Selector")
        }
        else if (ActionSelection = "Email") {
            ShowGUI("Email Selector")
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
    Gui, Add, Text, , Customer Type: %CustomerTypeSelection%
    Gui, Add, Text, , Action: %ActionSelection%
    Gui, Add, Text, , Communication Selection: %TextSelection%%EmailSelection%
    Gui, Add, Text, , Model: %ModelSelection%
    Gui, Add, Button, Hidden w0 h0 Default gMainLoop, Save

MainLoop:
    Gui, Destroy
    if(TextSelection = "Opt in") {
        MouseGetPos, xOrigin, yOrigin
        Click, loc.EmailCategory[0], loc.EmailCategory[1]
        Sleep, 10
        MouseMove, %xOrigin%, %yOrigin%, 0
    }


ShowGUI(GuiTitle) {
    if (GuiTitle = "Customer Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for New Inquiry
        Gui, Add, Text, , Press 2 for Mining - Cold Follow Up
        Gui, Add, Text, , Press 3 for Trade In
        Gui, Add, Text, , Press 4 for 1 Year Anniversary
        Gui, Add, Button, Hidden w0 h0 Default gHandleCustomerTypeSelection, Save
    } else if (GuiTitle = "Action Selector") {
        Gui +ToolWindow +AlwaysOnTop
        Gui, Add, Text,, Select an option:
        Gui, Add, Text, , Press 1 for Email
        Gui, Add, Text, , Press 2 for Text
        Gui, Add, Text, , Press 3 for Call
        Gui, Add, Button, Hidden w0 h0 Default gHandleActionSelection, Save
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
    }
    Gui, Show, w300 h400, %GuiTitle%
    return
}

#IfWinActive, Customer Selector
1:: CustomerTypeSelection := "New Inquiry", Gosub, HandleCustomerTypeSelection ; Pressing 1 sets Selection and triggers ButtonSave1
2:: CustomerTypeSelection := "Mining", Gosub, HandleCustomerTypeSelection
3:: CustomerTypeSelection := "Trade In", Gosub, HandleCustomerTypeSelection
4:: CustomerTypeSelection := "1 Year Anniversary", GoSub, HandleCustomerTypeSelection
Escape:: Gosub, HandleEscape
#IfWinActive

#IfWinActive, Action Selector
1:: ActionSelection := "Email", Gosub, HandleActionSelection ; Pressing 1 sets Selection and triggers ButtonSave1
2:: ActionSelection := "Text", Gosub, HandleActionSelection
3:: ActionSelection := "Call", Gosub, HandleActionSelection
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
1:: TextSelection := "Opt in", Gosub, HandleTextSelection
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
