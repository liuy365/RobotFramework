*** Settings ***
Documentation     助理机器人测试工程
Suite Setup       Open and Login Server    192.168.199.118    tauser    TaUser_111
Suite Teardown    Close All Connections
Force Tags        regression
Library           SSHLibrary

*** Keywords ***
Open and Login Server
    [Arguments]    ${ip}    ${user}    ${passwd}
    ${id}    Open Connection    ${ip}
    ${ret}    Login    ${user}    ${passwd}
    Should Contain    ${ret}    ${user}@
