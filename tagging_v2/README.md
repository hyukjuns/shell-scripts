# Auto Tagging by Event Grid Subscription and Azure Functions
리소스 생성시 생성자를 태그로 자동 등록해주는 시스템 입니다.

## Tags
- Created By: 홍길동

## How to Use
1. Azure Functions 생성 (EventHandler)
    1. Azure Functions 생성 (Runtime Stack: Powershell 7.2)
    2. function 생성 (EventGridTrigger Template)
        - eventgrid_tagging.ps1을 run.ps1에서 사용
    3. App Files 편집 (requirements.psd1)
        ```
        # Untag below
        'Az' 'x.x'
        ```
    4. System Assigent Managed Identity 활성 & 'Tag Contributor' 권한 부여

2. EventGrid 생성
    1. EventGrid System Topic 생성 (type: Subscription)
    2. Event Subscription 생성 (eventgrid_subscription.sh)
        - Advanced Filter 포함
 
## Automation Flow
1. Azure Resource Creation
2. Event Fired
3. EventGrid delivery Message to Azure Function (Subscription's Activity Logs - EventGrid Schema) 
4. Azure Function's Powershell function Activation (Tagging resources)

## Tips
- Created Date: Azure Policy로 구현 가능
- Azure Policy는 GetDate() 함수를 호출할 수 있으며, 생성일은 GetDate()함수를 통해 태깅 가능
- Azure Policy 에서는 리소스의 속성값을 참조할수 있으며, 생성자의 경우 리소스 속성에는 명시되지 않고, Activity Logs에서 확인이 가능 하므로, 정책에선 생성자 식별이 불가능함
- Function의 Contents (ps1파일 등등)는 함께 생성한 StorageACcount에 존재, Function -> Configuration -> Application Setting -> 'AzureWebJobsStorage' 확인