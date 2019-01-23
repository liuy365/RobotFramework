*** Settings ***
Documentation     这一个与远程自动助理机器人通信的的资源文件，定义与机器人的之间的基本操作方法：发送问题，获取答案。
Library           SSHLibrary

*** Variables ***
${questions_file}    /home/tauser/assistant_robot/questions.txt
${assistant_robot}    /home/tauser/assistant_robot/assistant_robot.py
${answer_file}    /home/tauser/assistant_robot/answer.txt

*** Keywords ***
Send_Message
    [Arguments]    ${msg}
    [Documentation]    向助理机器人发送命令关键字
    [Tags]    communicate
    ${ret}    ${err}    Execute Command    rm ${questions_file};echo ${msg}>${questions_file}    both
    ${ret}    ${err}    Execute Command    cat ${questions_file}    both
    Log    ${ret}

Get_Reply
    [Documentation]    接收助理机器人返回消息关键字
    ${ret}    ${err}    Execute Command    python ${assistant_robot}    both
    ${content}    ${err}    Execute Command    cat ${answer_file}    both
    Log    ${content}
    [Return]    ${content}
