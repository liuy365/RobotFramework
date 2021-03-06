*** Variables ***
${id_of_user}     id_of_user
${id_of_passwd}    id_of_passwd
${id_of_login}    id_of_login
@{data}           1    5    6    3    9    2

*** Test Cases ***
data driven
    [Template]    Invalid Login Check
    abc    password
    ${EMPTY}    password

keywords driven invalid login
    input    ${id_of_user}    abc
    input    ${id_of_passwd}    password
    click button    ${id_of_login}
    main page cannot be open
    input    ${id_of_user}    ${EMPTY}
    input    ${id_of_passwd}    password
    click button    ${id_of_login}
    main page cannot be open

argument
    test_multi_args    1    2    a=3    b=4
    test_multi_args    1    2    3    aa=4    bb=5

Return_Value_Testcase_1
    ${result}    add_two_number_kw    1    2
    Log    ${result}

If_Control_Testcase
    ${ret}    flow_control_if_kw    -5
    ${ret}    flow_control_if_kw    0
    ${ret}    flow_control_if_kw    35
    ${ret}    flow_control_if_kw    300

FOR_Normal_TestCase
    : FOR    ${item}    IN    a    b    c    d
    ...    e    f    g    h
    \    Log    ${item}
    @{list_var}    Set Variable    1    2    3    4    5
    : FOR    ${item}    IN    @{list_var}
    \    Log    ${item}

FOR_Nested_TestCase
    @{List1}    Create List    1    2    3
    @{List2}    Create List    a    b    c
    @{List3}    Create List    A    B    C
    @{Lists}    Create List    ${List1}    ${List2}    ${List3}
    : FOR    ${List}    IN    @{Lists}
    \    Second Loop    @{List}

FOR_IN_RANGE_TestCse
    : FOR    ${item}    IN RANGE    10
    \    Log    ${item}
    : FOR    ${item}    IN RANGE    1    10
    \    Log    ${item}
    : FOR    ${item}    IN RANGE    1    10    2
    \    Log    ${item}
    \    ${index}    set variable    4

FOR_IN_ENUMERATE_TestCase
    @{list}    Set Variable    a    b    c    d
    : FOR    ${index}    ${item}    IN ENUMERATE    @{list}
    \    Log    ${item} at index ${index}

FOR_IN_ZIP_TestCase
    ${header}    Set Variable    ID    Name    Score
    ${row1}    Set Variable    1    张三    80
    : FOR    ${header_item}    ${row1_item}    IN ZIP    ${header}    ${row1}
    \    Log    ${header_item}|${row1_item}

FOR_EXIT_LOOP_TestCase
    @{t_list}    Create List    a    b    c    d    e
    : FOR    ${i}    IN RANGE    5
    \    Run Keyword If    '@{t_list}[${i}]'=='d'    Exit For Loop
    \    Log    @{t_list}[${i}]

FOR_CONTINUE_TestCase
    @{t_list}    Create List    a    b    c    d    e
    : FOR    ${i}    IN RANGE    5
    \    Continue For Loop If    '@{t_list}[${i}]'=='d'
    \    Log    @{t_list}[${i}]

*** Keywords ***
Invalid Login Check
    [Arguments]    ${username}    ${passwd}
    input    ${id_of_user}    ${username}
    input    ${id_of_passwd}    ${passwd}
    click button    ${id_of_login}
    main page cannot be open

input
    [Arguments]    ${id}    ${value}=file_a.txt
    log    put ${value} in input box ${id}

click button
    [Arguments]    ${id}
    Log    button ${id} clicked

main page cannot be open
    Should Be True    True

test_multi_args
    [Arguments]    @{arg_list}    &{arg_dict}
    Log Many    @{arg_list}
    Log Many    &{arg_dict}

add_two_number_kw
    [Arguments]    ${arg1}    ${arg2}
    ${result}    Evaluate    ${arg1}+${arg2}
    Return From Keyword    ${result}
    Comment    后面的语句将不再执行
    [Teardown]    test    arg1

flow_control_if_kw
    [Arguments]    ${arg1}
    Run Keyword If    0<${arg1}<100    Return From Keyword    Middle Number
    ...    ELSE IF    ${arg1}==0    Return From Keyword    Zero
    ...    ELSE IF    ${arg1}<0    Return From Keyword    Negative Number
    ...    ELSE    Return From Keyword    Large Number

Second Loop
    [Arguments]    @{list_arg}
    : FOR    ${i}    IN    @{list_arg}
    \    Log    ${i}
