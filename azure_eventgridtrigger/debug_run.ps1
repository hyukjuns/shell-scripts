param($eventGridEvent, $TriggerMetadata)

# Make sure to pass hashtables to Out-String so they're logged correctly
$eventGridEvent | Out-String | Write-Host
$eventGridEvent | convertto-json | Write-Host

$Subject=$eventGridEvent.subject
$EventType=$eventGridEvent.eventType

# $authorization=$eventGridEvent.data.authorization
$scope=$eventGridEvent.data.authorization.scope
$action=$eventGridEvent.data.authorization.action
$role=$eventGridEvent.data.authorization.evidence.role

if ( $eventGridEvent.data.claims.idtyp -eq "app" )
{
    $Name="application"
} else {
    $Name=$eventGridEvent.data.claims.name
    $ipaddress=$eventGridEvent.data.claims.ipaddr
}
$resourceID=$eventGridEvent.data.resourceUri
$operationName=$eventGridEvent.data.operationName
$subscriptionId=$eventGridEvent.data.subscriptionId
$tenantId=$eventGridEvent.data.tenantId

$eventTime=$eventGridEvent.eventTime
$eventTime=Get-Date($eventTime)
$eventTime=[TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($eventTime, 'UTC', 'Korea Standard Time')
$eventTime=[DateTime]::ParseExact($eventTime, "MM/dd/yyyy HH:mm:ss", $null).ToString('yyyy-MM-dd HH:mm')

Write-Host "Subject: $Subject"
Write-Host "EventType: '$EventType"

Write-Host "Scope: $scope"
Write-Host "Action: $action"
Write-Host "Role: $role"

Write-Host "IP: $ipaddress"
Write-Host "Name: $Name"
Write-Host "Resource ID: $resourceID"
Write-Host "OperationName: $operationName"
Write-Host "SubscriptionId: $subscriptionId"
Write-Host "TenantId: $tenantId"

Write-Host "EventTime: $eventTime (KST)"