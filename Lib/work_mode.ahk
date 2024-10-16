#Requires AutoHotkey v2.0
#Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"
CoordMode("Mouse")

start_work()
{
    Send("^#{Right}") ; move to virtual desktop 2
    Sleep(100) ; wait for active windows to register
    TerminalStart()
    ObsidianStart()
    TeamsStart()
    OutlookStart()
    DockerStart()
}

stop_work()
{
    Send("^#{Right}") ; move to virtual desktop 2 (probably already there)
    Sleep(100) ; wait for active windows to register
    DockerStop()
    TerminalStop()
    IntellijStop()
    ToDoStop()
    LogseqStop()
    ObsidianStop()
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

Logseq(isStart := true)
{
    LogseqName := "ahk_exe Logseq.exe"

    if (isStart = true) {
        if not WinExist(LogseqName) {
            Run "C:\nextgate\shortcuts\Logseq.lnk"
            if WinWaitActive(LogseqName, , 10)
                Send("#{Right}")
            else
                MsgBox "Logseq timed out."
        }
    } else {
        if WinExist(LogseqName) {
            WinClose(LogseqName)
        }
    }
}

LogseqStart()
{
    Logseq()
}

LogseqStop()
{
    Logseq(false)
}

Obsidian(isStart := true)
{
    ObsidianName := "ahk_exe Obsidian.exe"

    if (isStart = true) {
        if not WinExist(ObsidianName) {
            Run "C:\nextgate\shortcuts\Obsidian.exe.lnk"
            if WinWaitActive(ObsidianName, , 10)
                Send("#{Right}")
            else
                MsgBox "Obsidian timed out."
        }
    } else {
        if WinExist(ObsidianName) {
            WinClose(ObsidianName)
        }
    }
}

ObsidianStart()
{
    Obsidian()
}

ObsidianStop()
{
    Obsidian(false)
}

Teams(isStart := true)
{
    TeamsName := "| Microsoft Teams"

    if (isStart = true) {
        if not WinExist(TeamsName) {
            Run "C:\nextgate\shortcuts\ms-teams.exe.lnk"
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
    OutlookName := "- Outlook"
    OutlookCalName := "^Calendar.*Outlook$"

    if (isStart = true) {
        if not WinExist(OutlookName) {
            Run "C:\nextgate\shortcuts\olk.exe.lnk"
            if WinWaitActive(OutlookName, , 10, "Opening") {
                Sleep(3000)
                MouseClick("R", 20, 110) ; open calendar right-click menu
                Sleep(1250)
                MouseClick("L", 100, 110) ; open calendar as separate window

                SetTitleMatchMode "RegEx" ; allow regex matching
                WinWait(OutlookCalName,, 5)
                Sleep(1000)
                WinActivate(OutlookCalName)
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
            Run "C:\nextgate\shortcuts\WindowsTerminal.exe.lnk", , "Max"
            if WinWaitActive(TerminalName, , 5) {
                Send("#+{Left}") ; move terminal to upper-most monitor
                Sleep(3000)
                Send("stmux{Enter}")
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

Docker(isStart := true)
{
    DockerName := "ahk_exe Docker Desktop.exe"

    if (isStart = true) {
        if not WinExist(DockerName) {
            Run "C:\nextgate\shortcuts\Docker Desktop.exe.lnk"
        }
    } else {
        if WinExist(DockerName) {
            WinClose(DockerName)
        }
    }
}

DockerStart()
{
    Docker()
}

DockerStop()
{
    Docker(false)
}
