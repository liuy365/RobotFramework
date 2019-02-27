*** Settings ***
Library           pabot.PabotLib    #导入pabotLib
Library           OperatingSystem

*** Variables ***
${valueset_file}    ${CURDIR}/valueset.dat

*** Keywords ***
Read ValueSet
    ${host}    Get Value From Set    HOST
    ${username}    Get Value From Set    USERNAME
    ${password}    Get Value From Set    PASSWORD
    Log    host=${host};username=${username};password=${password}

Acquire ValueSet Keyword
    Log    所有case现在都能使用这个${valueset_file}
    Log File    ${valueset_file}
    ${valuesetname}    Acquire Value Set    #争抢对valueset.dat文件的访问
    Log    只有${TEST NAME}现在能使用这个valueset.dat
    sleep    2
    Read ValueSet
    Release Value Set    #使用完毕，释放变量文件锁
