; Initialize variables
selectedOption := 0

; Define GUI
Gui, Add, Text,, Select an option:
Gui, Add, Button, gSubmitDefault, 1. Quick Call
Gui, Add, Button, gSubmitDefault, 2. Quick Opt In
Gui, Add, Button, gSubmitDefault, 3. New Customer
Gui, Add, Button, gSubmitDefault, 4. Existing Customer
Gui, Show

; Hotkey to reset GUI
1:: ; Change this to your desired hotkey
    GuiControl, Choose, 1, 1 ; Reset radio buttons if any
    selectedOption := 0 ; Reset selected option
    return

; Hotkey to destroy GUI and reset
Esc::GuiClose:
    Gui, Destroy
    selectedOption := 0
    return

; Hotkeys for selecting options
1::selectedOption := 1
2::selectedOption := 2
3::selectedOption := 3
4::selectedOption := 4
+1::selectedOption := 5
+2::selectedOption := 6
+3::selectedOption := 7
+4::selectedOption := 8

; Function to handle button clicks
SubmitDefault:
    Gui, Submit
    if (selectedOption = 3) ; New Customer
    {
        Gui, Destroy
        ; Insert code for New Customer options here
        ; Example:
        HandleNewCustomerOption(selectedOption)
    }
    else if (selectedOption = 4) ; Existing Customer
    {
        Gui, Destroy
        ; Insert code for Existing Customer options here
        ; Example:
        HandleExistingCustomerOption(selectedOption)
    }
    else ; Quick Call or Quick Opt In
    {
        Gui, Destroy
        ; Insert code for Quick Call or Quick Opt In options here
        ; Example:
        HandleQuickOption(selectedOption)
    }
    return

; Function to handle New Customer options
HandleNewCustomerOption(option) {
    ; Add your code for handling New Customer options here
    MsgBox, New Customer Option %option% selected
}

; Function to handle Existing Customer options
HandleExistingCustomerOption(option) {
    ; Add your code for handling Existing Customer options here
    MsgBox, Existing Customer Option %option% selected
}

; Function to handle Quick options
HandleQuickOption(option) {
    ; Add your code for handling Quick options here
    MsgBox, Quick Option %option% selected
    ; Example:
    ; If (option = 1)
    ;     MsgBox, Quick Call Option selected
    ; else
    ;     MsgBox, Quick Opt In Option selected
}
