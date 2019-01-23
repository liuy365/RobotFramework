*** Settings ***
Library           pabot.PabotLib
Resource          ${CURDIR}/parallel_resource.robot

*** Variables ***

*** Test Cases ***
test5
    Acquire Lock    MyLock
    Log    This part is critical section
    Set Global Variable    ${myvar}    ${TEST NAME}
    sleep    5
    Log    in ${TEST NAME}, myvar=${myvar}
    Release Lock    MyLock
    Log    所有case现在都能使用这个${resource_file}
    Log File    ${resource_file}
    ${valuesetname}=    Acquire Value Set
    Log    只有${TEST NAME}现在能使用这个valueset.data
    Write ValueSet
    sleep    10
    Read ValueSet
    Release Value Set
