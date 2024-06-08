#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
SendMode "Input"
SetKeyDelay 40 ; not actually used except when using SendRaw/Event
SetMouseDelay 40

#Include <hotstrings>

#Include <mute_teams>
#Include <work_mode>
#Include <open_chatgpt>