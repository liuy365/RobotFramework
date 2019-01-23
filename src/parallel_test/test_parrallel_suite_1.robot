*** Settings ***
Library           pabot.PabotLib    #导入pabotLib
Resource          ${CURDIR}/parallel_resource.robot    #公共关键字放到单独的资源文件里

*** Variables ***

*** Test Cases ***
test1
    Acquire Lock    MyLock    #争抢MyLock锁
    Log    This part is critical section
    Set Global Variable    ${myvar}    ${TEST NAME}
    sleep    5
    Log    in ${TEST NAME}, myvar=${myvar}
    Release Lock    MyLock    #使用完毕，释放锁
    Log    所有case现在都能使用这个${resource_file}
    Log File    ${resource_file}
    ${valuesetname}=    Acquire Value Set    #争抢一个变量文件锁
    Log    只有${TEST NAME}现在能使用这个valueset.data
    Write ValueSet
    sleep    10
    Read ValueSet
    Release Value Set    #使用完毕，释放变量文件锁
