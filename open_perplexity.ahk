#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

F13::
{
    Run "https://www.perplexity.ai"
}