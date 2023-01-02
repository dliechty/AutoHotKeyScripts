#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

F13::
{
    A_Clipboard := ""

    Send("^c")
    if !ClipWait(2)
    {
        MsgBox "Couldn't copy text to clipboard."
    }

    if RegExMatch(A_Clipboard, "^[^ ]*\.[^ ]*$")
    {
        Run A_Clipboard
    }
    else  
    {
        ; Modify some characters that screw up the URL
        ; RFC 3986 section 2.2 Reserved Characters (January 2005):  !*'();:@&=+$,/?#[]
        A_Clipboard := StrReplace(A_Clipboard, "`r`n", A_Space)
        A_Clipboard := StrReplace(A_Clipboard, "#", "`%23")
        A_Clipboard := StrReplace(A_Clipboard, "&", "`%26")
        A_Clipboard := StrReplace(A_Clipboard, "+", "`%2b")
        A_Clipboard := StrReplace(A_Clipboard, "`"", "`%22")
        Run "https://www.google.com/search?hl=en&q=" . A_Clipboard ; uriEncode(clipboard)
    }
    Return
}
