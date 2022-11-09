#/usr/bin/env pwsh

# My gist: https://gist.github.com/JackofSpades707/730739e1d85dc6fc3c6eb4a4f1f41e7b
# Inspired by: https://damopewpew.github.io/nvim/wsl/godot/unity3d/vim/2020/02/29/wsl-nvim-as-external-editor.html

Write-Output "[*] Args: $args"
$file=$args[0]
$file=(wsl.exe wslpath "$file")
Write-Output "[*] wslpath: $file"
$basename=(Split-Path "$file" -leaf)
Write-Output "[*] Basename: $basename"
$line=$args[1]
$column=$args[2]
$winshell = New-Object -ComObject wscript.shell
Start-Process wt.exe -ArgumentList "-w", "0", "-M", "new-tab", "--title", "$basename", "--suppressApplicationTitle", "Arch.exe", "run", "lvim", "'$file'", "'+call($line, $column)'" # Open lvim with Windows Terminal
sleep 1.25
Write-Output "[*] Switching to window..."
$winshell.AppActivate("$basename") # Switch focus to file just opened
