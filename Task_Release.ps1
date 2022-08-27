& "$PSScriptRoot/Task_Build.ps1"
$PackageName = "QSEC_Build_" + (Get-Date).ToUniversalTime().ToString('yyyyMMdd')
New-Item -Type Directory $PSScriptRoot/$PackageName -Force | Out-Null
Copy-Item $PSScriptRoot/_Build -Destination "$PSScriptRoot/$PackageName/模块" -Recurse -Force
Copy-Item $PSScriptRoot/@Demo -Destination "$PSScriptRoot/$PackageName/例程（源码）" -Recurse -Force
Copy-Item $PSScriptRoot/_DemoBuild -Destination "$PSScriptRoot/$PackageName/例程（编译）" -Recurse -Force
Copy-Item $PSScriptRoot/Changelog.txt -Destination "$PSScriptRoot/$PackageName/Changelog.txt" -Force
Copy-Item $PSScriptRoot/LICENSE.txt -Destination "$PSScriptRoot/$PackageName/LICENSE.txt" -Force
(Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ') | Out-File -NoNewline -Encoding ASCII -Force $PSScriptRoot/$PackageName/BuildDate.txt
Set-Location $PSScriptRoot/$PackageName
../GenChecksums.ps1
try { 
    gpg --detach-sig Checksums.txt
}
catch{ 
    "Failed to sign Checksums.txt, skipped"
}
Set-Location ..
New-Item -Type Directory $PSScriptRoot/_Publish -Force | Out-Null
Compress-Archive $PSScriptRoot/$PackageName -DestinationPath $PSScriptRoot/_Publish/$PackageName.zip -Force
Remove-Item -Recurse -Force $PSScriptRoot/$PackageName
