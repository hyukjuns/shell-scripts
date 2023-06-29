# Auto Tagging by Event Grid Subscription and Azure Functions
리소스 생성시 생성자와 생성일을 태그로 자동 등록해주는 시스템 입니다.

## Tags
- Created By: 홍길동
- Created Date: 2022/09/14 16:00

## Automation Flow
1. Azure Resource Creation
2. Event Fired
3. EventGrid delivery Message to Azure Function (Subscription's Activity Logs - EventGrid Schema) 
4. Azure Function's Powershell function Activation (Tagging resources)