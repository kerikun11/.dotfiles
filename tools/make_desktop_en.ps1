# Windows のディレクトリの表示名を英語にする PowerShell スクリプト
# desktop.ini の LocalizedResourceName をコメントアウトする

# Get-ChildItem $env:userprofile/*/desktop.ini,$env:userprofile/*/*/desktop.ini -Hidden -ErrorAction silentlycontinue | ForEach-Object {
Get-ChildItem $env:userprofile -Depth 2 -filter desktop.ini -Hidden -ErrorAction silentlycontinue | ForEach-Object {
    $file = $_.FullName
    echo "  File: $file"
    $LRN = 'LocalizedResourceName'
    $(Get-Content $file) -replace "^$LRN", ";$LRN" | Set-Content $file -force
}
