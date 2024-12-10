;----------------------------------------------------------------------------------------------------------------------
; This code is free software: you can redistribute it and/or modify  it under the terms of the 
; version 3 GNU General Public License as published by the Free Software Foundation.
; 
; This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY without even 
; the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
; See the GNU General Public License for more details (https://www.gnu.org/licenses/gpl-3.0.html)
;
; WARNING TO USERS AND MODIFIERS
;
; This script contains "Buy me a coffee" links to honor the author's hard work and dedication in creating
; all the features present in this code. Removing or altering these links not only violates the GPL license
; but also disregards the significant effort put into making this script valuable for the community.
;
; If you find value in this script and would like to show appreciation to the author,
; kindly consider visiting the site below and treating the author to a few cups of coffee:
;
; https://www.buymeacoffee.com/screeneroner
;
; Your honor and gratitude is greatly appreciated.
;----------------------------------------------------------------------------------------------------------------------

; v1.01 2024-12-10 Added delays in clipboard operation to make sure it was completed

#Persistent
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
global MenuFilePath

ShowHelp() {
    MsgBox, 64, Prompter v1.00 by screeneroner, 
    (
Main purpose of this app is to insert AI prompts
previously prepared in the folders/files structure.

It allows you to insert the content of `.txt` files 
at the current cursor position, mostly - in AI chats. 

To properly use Prompter v1.00, follow these steps:
1) Create a Prompts folder in the same directory as the app.
2) Place .txt files containing your prompts inside Prompts.
3) You can use subfolders in Prompts to organize .txt files.
4) Press Win+Alt+P to show the folder structure as a menu.
5) Selected file content will inserted at the current position.
    )
}

Menu, PromptMenu, Add,  Refresh Menu, RefreshMenu
Menu, PromptMenu, Add
Menu, PromptMenu, Add,  Help, ShowHelp
Menu, PromptMenu, Icon, Help, shell32.dll, 24
Menu, PromptMenu, Add,  Buy me a coffee, BuyCoffee
Menu, PromptMenu, Icon, Buy me a coffee, shell32.dll, 160
Menu, PromptMenu, Add,  Exit, ExitApplication
Menu, PromptMenu, Icon, Exit, shell32.dll, 113

Menu, Tray, Tip,     Prompter v1.0 by screeneroner
Menu, Tray, Add,     Prompter v1.00 Help, ShowHelp
Menu, Tray, Icon,    Prompter v1.00 Help, shell32.dll, 222
Menu, Tray, Default, Prompter v1.00 Help
Menu, Tray, Add
Menu, Tray, Add,  Buy me a coffee, BuyCoffee
Menu, Tray, Icon, Buy me a coffee, shell32.dll, 160
Menu, Tray, Add,  Exit, ExitApplication
Menu, Tray, Icon, Exit, shell32.dll, 28

Menu, Tray, NoStandard
Menu, Tray, Icon, shell32.dll, 134

!#p:: 
RefreshMenu()
Menu, PromptMenu, Show
Return

RefreshMenu() {
    global MenuFilePath
    MenuFilePath := Object()  ; Initialize as an object (associative array)
    Menu, PromptMenu, DeleteAll
    BuildMenu("Prompts", "PromptMenu")
}

BuildMenu(Folder, MenuName) {
    global MenuFilePath
    Folders := [], Files := []  ; Initialize arrays for folders and files

    ; Collect folders
    Loop, %Folder%\*, 2
        Folders.Insert(A_LoopFileName)
    Sort, Folders, N
    Loop, % Folders.MaxIndex()
        {
            FolderName := Folders[A_Index]
            SubMenuName := MenuName "_" A_Index
            Menu, %SubMenuName%, Add
            Menu, %SubMenuName%, DeleteAll
            Menu, %MenuName%, Add, %FolderName%, :%SubMenuName%
            Menu, %MenuName%, Icon, %FolderName%, shell32.dll, 4 
            BuildMenu(Folder . "\" . FolderName, SubMenuName)
        }
    
    ; Collect files
    Loop, %Folder%\*.txt
        Files.Insert(A_LoopFileName)
    Sort, Files, N
    Loop, % Files.MaxIndex()
    {
        FileName := Files[A_Index]
        DisplayName := RegExReplace(FileName, "\.txt$")
        Menu, %MenuName%, Add, %DisplayName%, ShowFile
        Menu, %MenuName%, Icon, %DisplayName%, shell32.dll, 71 
        MenuFilePath[DisplayName] := Folder . "\" . FileName
    }
}

ShowFile() {
    global MenuFilePath
    FilePath := MenuFilePath[A_ThisMenuItem]
    if FilePath {
        ClipboardBackup := ClipboardAll 
        FileRead, FileContent, %FilePath%
        Clipboard := FileContent
        ClipWait
        Sleep, 500 
        Send ^v
        Sleep, 500 
        Clipboard := ClipboardBackup 
    }
}

BuyCoffee() {
    Run, https://www.buymeacoffee.com/screeneroner
}

ExitApplication() {
    ExitApp
}
