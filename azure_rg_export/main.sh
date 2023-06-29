#!/bin/bash

# Azure Storage Table에 저장된 서로 다른 테넌트와 구독에 등록된 앱정보를 읽고, 각각의 리소스 그룹 ARM Template을 추출하여 별도 Blob Storage에 저장하는 Script

# 타겟 리소스 그룹 추출
function export_arm_template() {
    # 타겟 이름, 추출 날짜, 리소스 그룹 목록
    target=$1
    today="$(date -I)"
    resource_group_list=$(az group list -o tsv --query "[*].name")

    # 추출 시작
    cnt=0
    for resource_group in $resource_group_list
    do
        echo "-------------------- Count $cnt: Exporting $resource_group resource group... --------------------"
        ((cnt++))
        az group export --name $resource_group > ./$target-$today-$resource_group.json
        echo "$target-$today-$resource_group.json" >> arm_template_list.txt
    done
}

# 추출된 타겟 리소스 그룹을 자신의 블롭 스토리지에 업로드
function upload_arm_template() {
    # 타겟 이름(Blob), 추출된 리소스 그룹을 저장할 스토리지 계정, 스토리지에 대한 SAS 토큰, 추출된 리소스 그룹 목록
    target=$1
    destination_storage_account=$2
    sas_token=$3
    arm_template_list=$(cat ./arm_template_list.txt)

    # 타겟 Blob 컨테이너 조회, 없을 경우 신규 생성
    isContainerExist=$(az storage container exists -n $target --account-name $destination_storage_account --sas-token $sas_token --query 'exists')
    if [ $isContainerExist = false ]
    then
        isContainerCreated=$(az storage container create -n $target --account-name $destination_storage_account --sas-token $sas_token)
        if [ $isContainerCreated = false ]
        then
            echo "-------------------- Fail on $target Container Create, Please Check Containers and Re-Try --------------------"
            exit 0
        fi
        echo "-------------------- New $target container created! --------------------"
    fi

    # 업로드
    for arm_template in $arm_template_list
    do
        az storage blob upload -f ./$arm_template -c $target -n $arm_template --account-name $destination_storage_account --sas-token $sas_token
    done
    # 파일 삭제
    for arm_template in $arm_template_list
    do
        rm -rf $arm_template
    done
}

function main () {
    # app_info 스토리지 이름, 앱키 테이블 이름, 리소스 그룹 저장 스토리지 이름, 자신의 앱 아이디, 시크릿, 테넌트
    app_info_storage=$1
    app_info_table=$2
    rg_storage=$3
    my_app_id=$4
    my_app_secret=$5
    my_tenant_id=$6
    
    # app_info 스토리지를 접근을 위해 SP 로그인
    az login --service-principal -u $my_app_id -p $my_app_secret --tenant $my_tenant_id

    # SAS Token for app_info Table Storage
    expire_date=$(date -d "+1 days" "+%Y-%m-%d")
    app_info_sac_sas_token="$(az storage account generate-sas --account-name $app_info_storage  --services t --resource-types sco --permissions cdlruwap --expiry $expire_date -o tsv)"

    # SAS Token for RG Blob Storage
    expire_date=$(date -d "+1 days" "+%Y-%m-%d")
    rg_sac_sas_token="$(az storage account generate-sas --account-name $rg_storage  --services b --resource-types sco --permissions cdlruwap --expiry $expire_date -o tsv)"

    # 자신의 SP 로그아웃
    az logout

    # 앱정보를 보유한 타겟 조회
    key_cnt=$(az storage entity query --account-name $app_info_storage --table-name $app_info_table --sas-token $app_info_sac_sas_token --query "length(items)" -o tsv)
    echo "==================== 현재 보유 앱 정보 개수: $key_cnt ===================="

    # 작업 시작
    for (( i=0; i<$key_cnt; i++ ))
    do
        # 타겟의 앱키로 SP 로그인
        app_id=$(az storage entity query --account-name $app_info_storage --table-name $app_info_table --query "items[$i].AppID" --sas-token $app_info_sac_sas_token -o tsv)
        app_secret=$(az storage entity query --account-name $app_info_storage --table-name $app_info_table --query "items[$i].AppSecret" --sas-token $app_info_sac_sas_token -o tsv)
        tenant_id=$(az storage entity query --account-name $app_info_storage --table-name $app_info_table --query "items[$i].TenantID" --sas-token $app_info_sac_sas_token -o tsv)
        target=$(az storage entity query --account-name $app_info_storage --table-name $app_info_table --query "items[$i].targetNameEng" --sas-token $app_info_sac_sas_token -o tsv)
        
        # 영문 이름이 없다면 continue
        if [[ -z $target ]]
        then
            continue
        fi

        # 타겟 app 로그인
        az login --service-principal -u $app_id -p $app_secret --tenant $tenant_id
        
        echo "==================== $i 번째 작업 ===================="
        # 타겟 리소스 그룹 ARM TEMPLATE 추출
        echo "==================== $target 타겟 리소스 그룹 ARM_TEMPLATE 추출 시작 ===================="
        export_arm_template $target
        
        # 타겟 SP 로그아웃
        az logout

        # 추출된 리소스 그룹 ARM TEMPLATE 업로드
        echo "==================== $target 타겟 리소스 그룹 ARM_TEMPLATE 업로드 시작 ===================="       
        upload_arm_template $target $rg_storage $rg_sac_sas_token

        # ARM_TEMPLATE_LIST 파일 초기화, 타겟 이름 파일 초기화
        cat /dev/null > ./arm_template_list.txt
        cat /dev/null > ./target.txt
    done
}

# app_info storage, app_info table, rg storage, my app id, my app secret, my app tenant id
main $1 $2 $3 $4 $5 $6
