# Auto Tagging by Event Grid Subscription and Azure Functions
리소스 생성시 생성자와 생성일을 태그로 자동 등록해주는 시스템 입니다.

## Flow
- Azure Resource Created -> Event Fired -> Event grid -> (Topic(Activity Logs)) -> Azure Functions -> Powershell(Resource Tagging)