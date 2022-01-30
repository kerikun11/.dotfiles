# Windows のディレクトリの表示名を英語にする PowerShell スクリプト
# desktop.ini の LocalizedResourceName をコメントアウトする

Get-ChildItem $HOME -Depth 2 -filter desktop.ini -Hidden -ErrorAction silentlycontinue | ForEach-Object {
    $file = $_.FullName
    Write-Output "  File: $file"
    $LRN = 'LocalizedResourceName'
    $(Get-Content $file) -replace "^$LRN", ";$LRN" | Set-Content $file -force
}
