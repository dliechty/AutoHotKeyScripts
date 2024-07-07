#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir  ; Ensures a consistent starting directory.
SendMode "Input"

open_chatgpt()
{
    Run "https://chat.openai.com"
}

open_perplexity()
{
    Run "https://www.perplexity.ai"
}