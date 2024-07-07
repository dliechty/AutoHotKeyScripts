#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

google(service := 1)
{
    static urls := Map()

    urls[1] := "https://www.google.com/search?hl=en&q=" ; regular
    urls[2] := "https://www.google.com/search?site=imghp&tbm=isch&q=" ; image
    urls[3] := "https://www.google.com/maps/search/" ; map
    urls[4] := "https://translate.google.com/?sl=auto&tl=en&text=" ; translate

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

        query := A_Clipboard

        ; Modify some characters that screw up the URL
        ; RFC 3986 section 2.2 Reserved Characters (January 2005):  !*'();:@&=+$,/?#[]
        query := StrReplace(query, "`r`n", A_Space)
        query := StrReplace(query, "#", "`%23")
        query := StrReplace(query, "&", "`%26")
        query := StrReplace(query, "+", "`%2b")
        query := StrReplace(query, "`"", "`%22")

        Run urls[service] . query
    }
    Return
}