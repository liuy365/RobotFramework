*** Settings ***
Library           OperatingSystem

*** Variables ***
${resource_file}    ${CURDIR}/valueset.data

*** Keywords ***
Write ValueSet
    Create File    ${resource_file}    [Server 1]\n HOST=${TEST NAME}_host\n USERNAME=${TEST NAME}\n PASSWORD=${TEST NAME}_passwd\n

Read ValueSet
    Log File    ${resource_file}
    ${host}=    Get Value From Set    HOST
    ${username}=    Get Value From Set    USERNAME
    ${password}=    Get Value From Set    PASSWORD
    Log    host=${host};username=${username};password=${password}
