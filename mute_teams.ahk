#Requires AutoHotkey v2.0
#Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

F16::
{
    TeamsWindows := WinGetList("ahk_exe Teams.exe")			;get IDs for all teams windows
    for id in TeamsWindows 							;Loop through IDs of all teams windows
    {
        Title := WinGetTitle("ahk_id " . id)			;get the title of the current window

        if Title != "Microsoft Teams Notification" && Title != ""		;make sure title is not the notification or sharing window
        {
            WinActivate("ahk_id " . id)				;This should be the correct win, activate it
            Send("^M")								;send ctrl,shift,m shortcut
            break								;There are two teams windows, the main win and the meeting win, break the loop so that the mute commmand doesnt get sent twice
        }
    }
}
