; Initialize variables
selectedOption := 0

; Define function to create and show the GUI
ShowGUI() {
    Gui, New
    Gui, Add, Text,, Please make a selection:
    Gui, Add, Radio, vOption1 gRadioSelect, Quick Call
    Gui, Add, Radio, vOption2 gRadioSelect, Quick Opt In
    Gui, Add, Radio, vOption3 gRadioSelect, New Customer
    Gui, Add, Radio, vOption4 gRadioSelect, Existing Customer
    Gui, Add, Button, Default gSubmit, Submit
    Gui, Add, Button, gExit, Exit
    Gui, Show
}

; Define function to handle radio button selection
RadioSelect:
    Gui, Submit
    return

; Define function to handle submit button
Submit:
    Gui, Destroy
    if (selectedOption = 1) {
        ; Quick Call - Insert code here
        ; ...
        ; Comment block for code insertion
        ; TODO: Insert Quick Call code here
    } else if (selectedOption = 2) {
        ; Quick Opt In - Insert code here
        ; ...
        ; Comment block for code insertion
        ; TODO: Insert Quick Opt In code here
    } else if (selectedOption = 3) {
        ; New Customer - Insert code here to show new options
        Gui, Add, Text,, Please make a selection:
        Gui, Add, Radio, vOption1 gRadioSelect, New Inquiry Text
        Gui, Add, Radio, vOption2 gRadioSelect, Shelby Follow Up Text
        Gui, Add, Radio, vOption3 gRadioSelect, New Trade in or Street Purchase Text
        Gui, Add, Button, Default gSubmit, Submit
        Gui, Add, Button, gExit, Exit
        Gui, Show
        ; Comment block for code insertion
        ; TODO: Insert New Customer code here
    } else if (selectedOption = 4) {
        ; Existing Customer - Insert code here to show existing options
        Gui, Add, Text,, Please make a selection:
        Gui, Add, Radio, vOption1 gRadioSelect, New Inquiry Follow Up Text
        Gui, Add, Radio, vOption3 gRadioSelect, Trade in or Street Purchase Follow Up Text
        Gui, Add, Button, Default gSubmit, Submit
        Gui, Add, Button, gExit, Exit
        Gui, Show
        ; Comment block for code insertion
        ; TODO: Insert Existing Customer code here
    }
    return

; Define function to handle exit button
Exit:
    Gui, Destroy
    selectedOption := 0 ; Reset selected option
    return

; Define hotkeys
1:: ; Hotkey for showing the GUI
    selectedOption := 0 ; Reset selected option
    ShowGUI()
    return

Esc:: ; Hotkey for destroying the GUI and clearing selections
    Gui, Destroy
    selectedOption := 0 ; Reset selected option
    return
