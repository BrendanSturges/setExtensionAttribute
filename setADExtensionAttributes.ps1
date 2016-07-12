Function Get-FileName($initialDirectory){   
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
	$OpenFileDialog.initialDirectory = $initialDirectory
	$OpenFileDialog.filter = "All files (*.*)| *.*"
	$OpenFileDialog.ShowDialog() | Out-Null
	$OpenFileDialog.filename
}

Function doStuff(){
	While(($toggle = Read-Host "What do you want to update for this list?  `n(1) Patch Group `n(2) Organization `n(3) Application") -notmatch '1$|2$|3$'){
	#empty while to keep prompting for correct data
	}
	$changeIt = Read-Host "What do you want this to be set to?"
	foreach($server in $serverList){
		Try{
			Set-ADComputer -identity $server -replace @{ExtensionAttribute$toggle=$changeIt}
		}
		Catch{
			Write-Host "$server : $_.Exception.Message"
		}
	}
}

$ErrorActionPreference=Continue
Import-Module ActiveDirectory

Write-Host "Please choose a server list in TXT or CSV format"

$serverList = Get-Content -Path (Get-FileName)

While(($domain = Read-Host "What domain is this for?  `n(1) DEVGAC `n(2) GAC") -notmatch '1$|2$'){
	#empty while to keep prompting for correct data
}

if($domain -eq "1"){
	#connect to DEV	
	doStuff()
}

if($domain -eq "2"){
	#connect to PROD
	doStuff()
}