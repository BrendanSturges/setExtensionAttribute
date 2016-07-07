Function Get-FileName($initialDirectory){   
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
	$OpenFileDialog.initialDirectory = $initialDirectory
	$OpenFileDialog.filter = "All files (*.*)| *.*"
	$OpenFileDialog.ShowDialog() | Out-Null
	$OpenFileDialog.filename
}

Import-Module ActiveDirectory

Write-Host "Please choose a server list in TXT or CSV format"

$serverList = Get-Content -Path (Get-FileName)

While(($toggle = Read-Host "What do you want to update for this list?  `n(1) Patch Group `n(2) Application `n(3) DU") -notmatch '1$|2$|3$'){
	#empty while to keep prompting for correct data
}

$changeIt = Read-Host "What do you want this to be set to?"

foreach($server in $serverList){
	Set-ADComputer -identity $server -replace @{ExtensionAttribute$toggle=$changeIt}
}


