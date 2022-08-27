function Out-Hash-Map-Build-Script {
	$SourceFiles = Get-ChildItem -File -Path QS哈希表/QS哈希表 -Recurse -ErrorAction SilentlyContinue -Force | Resolve-Path -Relative
	$Script = ""
	foreach($KeyType in "整数型","长整数型","文本型","字节集"){
		foreach($ValueType in "","整数型","长整数型","文本型","字节集"){
			if($ValueType -eq ""){
				$Name = "QS哈希集合_" + $KeyType
			}else{
				$Name = "QS哈希表_" + $KeyType + "_" + $ValueType
			}
			$TargetFile = "_Build/QS哈希表/${Name}.ec" 
			$IntermediateDir = "_IntermediateBuild/QS哈希表/${Name}"
			$ProjectFile = "${IntermediateDir}/QS哈希表.eproject"

			$Script += "build ${ProjectFile}: gencode " + ($SourceFiles -Join " ") + "`r`n"
			$Script += "    indir = QS哈希表/QS哈希表`r`n"
			$Script += "    params = {KeyType:'${KeyType}',ValueType:'${ValueType}'}`r`n"
			$Script += "    outdir = ${IntermediateDir}`r`n"
			$Script += "build ${TargetFile}: eplc ${ProjectFile} | _Build/QS哈希表/QS底层哈希表.ec`r`n"
		}
	}
	$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
	[System.IO.File]::WriteAllText("$PSScriptRoot/build_hash_map.gen.ninja", $Script, $Utf8NoBomEncoding)
}
Out-Hash-Map-Build-Script
EAutoBuild.exe "$PSScriptRoot" --script-name build_normal.gen.ninja --exclude "_IntermediateBuild/**"
