#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
SendMode "Input"
SetKeyDelay 40 ; not actually used except when using SendRaw/Event
SetMouseDelay 40

#Include <hotstrings>

#Include <mute_teams>
#Include <look_up>
#Include <work_mode>
#Include <sites>

F13::mute_teams()
F14::open_gemini()
F15::open_perplexity()

F17::google(1) ; Regular search
F18::google(2) ; Images search
F19::google(3) ; Maps search
F20::google(4) ; Translation

F21::start_work()
F22::stop_work()