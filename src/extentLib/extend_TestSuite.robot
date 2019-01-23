*** Settings ***
Library           ${CURDIR}${/}myExtLibrary

*** Test Cases ***
hello
    ${ret}    getHelloMsg    robot
    Log    ${ret}
    ${ret}    get_Hello_Msg    robot
    Log    ${ret}
    ${ret}    Get Hello Msg    robot
    Log    ${ret}
    ${ret}    get_hello_msg    robot
    Log    ${ret}
