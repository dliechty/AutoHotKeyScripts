#Requires AutoHotkey v2.0
#Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"
CoordMode("Mouse")

F15::
{
    Send("^#{Right}") ; move to virtual desktop 2
    Sleep(100) ; wait for active windows to register
    TerminalStart()
    ToDoStart()
    TeamsStart()
    OutlookStart()
}

F16::
{
    Send("^#{Right}") ; move to virtual desktop 2 (probably already there)
    Sleep(100) ; wait for active windows to register
    TerminalStop()
    IntellijStop()
    ToDoStop()
    TeamsStop()
    OutlookStop()
    Send("^#{Left}")
}

IntellijStop()
{
    IntellijName := "ahk_exe idea64.exe"

    while WinExist(IntellijName) ; keep looping until all intellij windows are closed
    {
        WinClose(IntellijName)
    }

    DataGripName := "ahk_exe datagrip64.exe"

    while WinExist(DataGripName) ; keep looping until all datagrip windows are closed
    {
        WinClose(DataGripName)
    }
}

ToDo(isStart := true)
{
    ToDoName := "Microsoft To Do"

    if (isStart = true) {
        if not WinExist(ToDoName) {
            Run "C:\nextgate\shortcuts\ToDo.lnk"
            if WinWaitActive(ToDoName, , 5)
                Send("#{Left}")
            else
                MsgBox "ToDo timed out."
        }
    } else {
        if WinExist(ToDoName) {
            WinClose(ToDoName)
        }
    }
}

ToDoStart()
{
    ToDo()
}

ToDoStop()
{
    ToDo(false)
}

Teams(isStart := true)
{
    TeamsName := "Microsoft Teams"

    if (isStart = true) {
        if not WinExist(TeamsName) {
            Run "C:\nextgate\shortcuts\Teams.lnk"
            if WinWaitActive(TeamsName, , 10, "Loading")
                Send("#{Left}")
            else
                MsgBox "Teams timed out."
        }
    } else {
        if WinExist(TeamsName) {
            WinClose(TeamsName)
        }
    }
}

TeamsStart()
{
    Teams()
}

TeamsStop()
{
    Teams(false)
}

Outlook(isStart := true)
{
    OutlookName := "Outlook"
    OutlookCalName := "^Calendar.*Outlook$"

    if (isStart = true) {
        if not WinExist(OutlookName) {
            Run "C:\nextgate\shortcuts\Outlook.lnk"
            if WinWaitActive(OutlookName, , 10, "Opening") {
                Send("#{Left}")
                Sleep(1000)
                ;MouseClick("R", 20, 100) ; open calendar right-click menu
                ;Sleep(1000)
                ;MouseClick("L", 100, 125) ; open calendar as separate window

                SetTitleMatchMode "RegEx" ; allow regex matching
                if WinWaitActive(OutlookCalName, , 5) {
                    Send("#{Right}")
                }
                SetTitleMatchMode 2 ; revert to default behavior
            }
            else
                MsgBox "Outlook timed out."
        }
    } else {

        SetTitleMatchMode "RegEx" ; allow regex matching
        if WinExist(OutlookCalName) {
            WinClose(OutlookCalName)
        }
        SetTitleMatchMode 2 ; revert to default behavior

        if WinExist(OutlookName) {
            WinClose(OutlookName)
        }
    }
}

OutlookStart()
{
    Outlook()
}

OutlookStop()
{
    Outlook(false)
}

Terminal(isStart := true)
{
    TerminalName := "ahk_exe WindowsTerminal.exe"

    if (isStart = true) {
        if not WinExist(TerminalName) {
            Run "C:\nextgate\shortcuts\Terminal.lnk", , "Max"
            if WinWaitActive(TerminalName, , 5) {
                Send("#+{Left}") ; move terminal to upper-most monitor
            }
            else
               MsgBox "Terminal timed out."
        }
    } else {
        if WinExist(TerminalName) {
            WinClose(TerminalName)
        }
    }
}

TerminalStart()
{
    Terminal()
}

TerminalStop()
{
    Terminal(false)
}
