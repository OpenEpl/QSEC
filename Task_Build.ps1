Try { Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop' } Catch {}
./GenBuildScript.ps1
[console]::InputEncoding = [console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
ninja -f build_all.ninja