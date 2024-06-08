#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

F13::look_up()

google(service := 1)
{
    static urls := { 0: ""
        , 1 : "https://www.google.com/search?hl=en&q=" ; regular
        , 2 : "https://www.google.com/search?site=imghp&tbm=isch&q=" ; image
        , 3 : "https://www.google.com/maps/search/" ; map
        , 4 : "https://translate.google.com/?sl=auto&tl=en&text=" } ; translate
    backup := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0
    if ErrorLevel
        InputBox query, Google Search,,, 200, 100
    else query := Clipboard
    Run % urls[service] query
    Clipboard := backup
}

look_up()
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