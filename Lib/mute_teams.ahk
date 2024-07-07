#Requires AutoHotkey v2.0
#Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

mute_teams()
{
    TeamsWindows := WinGetList("ahk_exe ms-teams.exe")			;get IDs for all teams windows
    for id in TeamsWindows 							;Loop through IDs of all teams windows
    {
        Title := WinGetTitle("ahk_id " . id)			;get the title of the current window

        if Title != "Microsoft Teams" && Title != "" &&	InStr(Title, "Chat") != 1	;make sure title is not the notification or sharing window or chat
        {
            WinActivate("ahk_id " . id)				;Move to any acceptable teams win, activate it
            Send("^M")								;send ctrl,shift,m shortcut
            break
        }
    }
}
