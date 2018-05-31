
# Have it write to XML
# have it zip the xml?
# the line below generates an error... why?
# Get-WmiObject -Class __TimerEvent | get-member


# Get all the wmi objects we'll loop through
$WMIObjects = Get-WMIObject -List *

# Loop through each WMIObject class and pull the properties, methods, and the output thereof.

foreach ($item in $WMIObjects) {

	# Show where we are in the processing queue
	$Item.name

	$FileName = "C:\wmi-hax\results\properties\$($Item.Name)-Properties.txt"
	$OutputStream = [System.IO.StreamWriter] $FileName

	# pull the properties
	#get-wmiobject -class CIM_DiskDrive | Get-Member -MemberType Properties
	$Properties = Get-WmiObject -Class $item.name | Get-Member -MemberType Properties
	$OutputStream.WriteLine("-----------------`n")
	$OutputStream.WriteLine("$($Item.Name) full properties`n")
	$OutputStream.WriteLine("-----------------`n")
	foreach ( $PropertyItem in $Properties ) {
		$OutputStream.WriteLine("$PropertyItem")
	}
	$OutputStream.close()
	
	
	$FileName = "C:\wmi-hax\results\methods\$($Item.Name)-Methods.txt"
	$OutputStream = [System.IO.StreamWriter] $FileName
	
	# pull the methods
	#get-wmiobject -class CIM_DiskDrive | Get-Member -MemberType Method
	$AllMethods = get-wmiobject -class $item.name | Get-Member -MemberType Method
	$OutputStream.WriteLine("-----------------`n")
	$OutputStream.WriteLine("$($Item.Name) full Methods`n")
	$OutputStream.WriteLine("-----------------`n")
	foreach ( $Method in $AllMethods ) { 
		$OutputStream.WriteLine("$Method")
	}	
	$OutputStream.close()



	$FileName = "C:\wmi-hax\results\output\$($Item.Name)-output.txt"
	$OutputStream = [System.IO.StreamWriter] $FileName
	# now pull all info that you can...
	$FullInfo = get-wmiobject -class CIM_DiskDrive | Format-List -Property *
	$OutputStream.WriteLine("-----------------`n")
	$OutputStream.WriteLine("$($Item.Name) full info`n")
	$OutputStream.WriteLine("-----------------`n")
	foreach ( $FullInfoItem in $FullInfo) {
		$OutputStream.WriteLine("$FullInfoItem")
	}	

	# Done with the stream, we don't need it anymore
	$OutputStream.close()

}
