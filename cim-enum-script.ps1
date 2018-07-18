

# Get all the wmi objects we'll loop through
$CIMClasses = Get-CIMClass

# Loop through each WMIObject class and pull the properties, methods, and the output thereof.

foreach ($item in $CIMClasses.CIMClassName) {

	# Show where we are in the processing queue
	$Item

	$FileName = "C:\cim-hax\results\properties\$($Item)-Properties.txt"
	$OutputStream = [System.IO.StreamWriter] $FileName

	## pull the properties
	$CIMClassProperties = Get-CIMClass -ClassName $item | Get-Member -MemberType Properties
	$OutputStream.WriteLine("-----------------`n")
	$OutputStream.WriteLine("$($Item) full properties`n")
	$OutputStream.WriteLine("-----------------`n")
	foreach ( $PropertyItem in $CIMClassProperties ) {
		$OutputStream.WriteLine("$PropertyItem")
	}
	$OutputStream.close()
	
	
	$FileName = "C:\cim-hax\results\methods\$($Item)-Methods.txt"
	$OutputStream = [System.IO.StreamWriter] $FileName
	
	# pull the methods
	$AllMethods = get-CIMClass -ClassName $item | Get-Member -MemberType Method
	$OutputStream.WriteLine("-----------------`n")
	$OutputStream.WriteLine("$($Item) full Methods`n")
	$OutputStream.WriteLine("-----------------`n")
	foreach ( $Method in $AllMethods ) { 
		$OutputStream.WriteLine("$Method")
	}	
	$OutputStream.close()

}
