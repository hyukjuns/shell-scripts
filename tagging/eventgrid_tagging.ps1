param(
    $eventGridEvent, 
    $TriggerMetadata
)

# # Make sure to pass hashtables to Out-String so they're logged correctly
$eventGridEvent | Out-String | Write-Host
$eventGridEvent | convertto-json | Write-Host

$createBy=$eventGridEvent.data.claims.name
$createDate=$eventGridEvent.eventTime
$resourceId=$eventGridEvent.data.resourceUri

$createDate=Get-Date($createDate)
Write-Host $createDate

$createDate=[TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($createDate, 'UTC', 'Korea Standard Time')
Write-Host $createDate
$createDate=[DateTime]::ParseExact($createDate, "MM/dd/yyyy HH:mm:ss", $null).ToString('yyyy-MM-dd HH:mm')
Write-Host $createDate

$tags = @{"Created by"="$createBy"; "Created Date"="$createDate"}

try {
    Update-AzTag -ResourceId $resourceId -Tag $tags -operation Merge -ErrorAction Stop
}
catch {
    $err = $_.Exception.message
    Write-Host "Error Occured : $err"
    exit
}