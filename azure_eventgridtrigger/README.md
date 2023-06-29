### EventGrid Subscription to Azure Function

### Usage
1. (사전구성) Azure Subscription - EventGrid Subscription
- 구독에서 발생하는 Activity Logs에 EventGrid를 걸어 필터링된 로그를 별도 Endpoint(logicapp, function 등)에 전달
- EventGrid 펄터링 내용 예시
    - EventType: Microsoft.Resources.ResourceWriteSuccess, Microsoft.Resources.ResourceDeleteSuccess
    - Advanced Filter: data.authorization.action | String contains | Microsoft.Compute/virtualMachines/write

2. Function (EventGrid Trigger) - run.ps1
- 전달된 이벤트 내용을 파싱하여 저장하거나, 알람을 생성하거나(웹훅), 시각화 하여 활용