*** Settings ***
Documentation     这一个与自动助理机器人通信的的资源文件，
...               定义与机器人的之间的基本操作方法：发送问题，获取答案。
Library           OperatingSystem

*** Variables ***
${questions_file}    ${CURDIR}/../assistant_robot/questions.txt
${assistant_robot}    ${CURDIR}/../assistant_robot/assistant_robot.py
${answer_file}    ${CURDIR}/../assistant_robot/answer.txt

*** Keywords ***
Send_Message
    [Arguments]    ${msg}
    [Documentation]    向助理机器人发送命令关键字
    Create File    ${questions_file}    ${msg}    UTF-8
    File Should Not Be Empty    ${questions_file}
    Log File    ${questions_file}

Get_Reply
    [Documentation]    接收助理机器人返回消息关键字
    ${ret}    ${output}    Run And Return Rc And Output    python ${assistant_robot}
    Should Be Equal As Integers    ${ret}    0
    Log File    ${answer_file}
    ${content}    Get File    ${answer_file}
    [Return]    ${content}
