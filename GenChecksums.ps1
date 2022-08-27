if(Test-Path checksums.txt){
	Remove-Item checksums.txt
}
$FullPath = (Get-ChildItem -File -Recurse).FullName | Sort-Object


$Path = $FullPath.Substring(((Get-Location).Path+"\").Length).Replace("\","/")
"Checksums: " | Out-File -Encoding UTF8 Checksums.txt
for($i=0;$i -lt $Path.Length;$i++){
	"-----------------------------------------------------------" | Out-File -Append -Encoding UTF8 checksums.txt
	$MD5FileHash = Get-FileHash -LiteralPath  $FullPath[$i] -Algorithm MD5
	$SHA1FileHash = Get-FileHash -LiteralPath $FullPath[$i] -Algorithm SHA1
	$SHA256FileHash = Get-FileHash -LiteralPath $FullPath[$i] -Algorithm SHA256
	$RIPEMD160FileHash = Get-FileHash -LiteralPath $FullPath[$i] -Algorithm RIPEMD160
	"Path: " + $Path[$i] | Out-File -Append -Encoding UTF8 checksums.txt
	"MD5: " + $MD5FileHash.Hash | Out-File -Append -Encoding UTF8 checksums.txt
	"SHA1: " + $SHA1FileHash.Hash | Out-File -Append -Encoding UTF8 checksums.txt
	"SHA256: " + $SHA256FileHash.Hash | Out-File -Append -Encoding UTF8 checksums.txt
	"RIPEMD160: " + $RIPEMD160FileHash.Hash | Out-File -Append -Encoding UTF8 checksums.txt
}
"-----------------------------------------------------------" | Out-File -Append -Encoding UTF8 Checksums.txt