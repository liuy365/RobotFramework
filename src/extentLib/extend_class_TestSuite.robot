*** Settings ***
Library           ${CURDIR}${/}myExtClassLibrary    中文

*** Test Cases ***
hello_class
    ${ret}    get Hello Msg Class    robot
    Log    ${ret}
