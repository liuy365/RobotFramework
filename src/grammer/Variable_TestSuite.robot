*** Settings ***
Force Tags        regression
Default Tags      smoke
Library           Collections
Library           DateTime
Library           Dialogs

*** Variables ***
@{list_suite}     1    2    3    4    5
&{dict_in_suite}    name=tony    age=18

*** Test Cases ***
Scalar_TestCase
    [Timeout]    20 seconds
    Set Suite Variable    ${var1}    Hello
    Set Suite Variable    ${var2}    ${var1}, world!
    Log    ${var1}
    Log    ${var2}
    ${var_s}    @{list}    Set Variable    1    2    3

Scalar_2nd_TestCase
    Log    var1=${var1}
    Log    var2=${var2}

List_Suite_TestCase
    Log    第一个：@{list_suite}[0]
    Log    第三个：@{list_suite}[2]
    Log    倒数第一个：@{list_suite}[-1]
    Log    倒数第三个：@{list_suite}[-3]

List_Case_TestCase
    [Documentation]    用builtIn库的Set Variable创建
    @{list_case}    Set Variable    1    2    3    #用Set Variable关键字赋值。@{list_case}=[1,2,3]
    @{list_case2}    Set Variable    @{list_case}    4    5    #Set Variable里可以带list。@{list_case2}=[1,2,3,4,5]
    Log    ${list_case2}    #打印所有元素。

List_Case_TestCase2
    [Documentation]    用Collections库的Create List 创建， Append To List、Insert Into List添加，Remove From List、Remove Values From List删除。
    @{list_t}    Create List    0    #用Create List关键字创建一个list变量，可以为空，也可以现在就赋值。@{list_t} = [ 0 ]。
    Append To List    ${list_t}    1    2    #往list里加元素。@{list_t} = [0,1,2]
    Log    First Log: list_t=${list_t}
    Insert Into List    ${list_t}    0    a    # @{list_t} = [a,0,1,2]
    Log    Second Log: list_t=${list_t}
    Insert Into List    ${list_t}    -1    b    # @{list_t} = [a,0,1,b, 2]
    ${var}    Remove From List    ${list_t}    1    # ${var}=0, @{list_t} = [a,1,b, 2]
    Log    Third Log: var=${var} list_t=${list_t}
    Remove Values From List    ${list_t}    a    b    1    # @{list_t} = [2]
    Log    Fourth Log: list_t=${list_t}

List_Case_TestCase3
    [Documentation]    用Collections库的Copy List方式，或者builtIn的Set Variable
    @{list_1}    Create List    1    2    3
    @{list_2}    Copy List    ${list_1}
    Log    First Log: list_2=${list_2}
    @{list_3}    Set Variable    @{list_2}    4    5
    Log    Second Log: list_3=${list_3}
    @{list_4}    Set Variable    ${list_2}    4    5
    Log    Third Log: list_4=${list_4}

Dict_Suite_TestCase
    Log    &{dict_in_suite}[name]    #打印所有key为name的值
    Log    ${dict_in_suite.age}    #打印所有key为age的值
    Log    ${dict_in_suite}    #以scalar方式打印整个dict

Dict_Case_TestCase
    &{new_dict}    Create Dictionary    a=1    b=2
    Log    First Log: new_dict=${new_dict}
    Set To Dictionary    ${new_dict}    c    3    #往dict里添加key-value键值对
    Log    Second Log: new_dict=${new_dict}
    ${var}    Pop From Dictionary    ${new_dict}    b    #从dict中弹出指定的key，返回key对应的value值
    Log    Third Log:var=${var}, new_dict=${new_dict}
    Remove From Dictionary    ${new_dict}    a    x    y    #从dict中移除指定的key，如果找不到指定的key，则忽略它而不报错
    Log    Fourth Log: new_dict=${new_dict}
    Keep In Dictionary    ${new_dict}    no_exist    #只保留key为“no_exist”的键值对，删除其它。相当于清空dict变量了
    Log    Fifth Log: new_dict=${new_dict}

Transfer_TestCase
    @{var}    Create List    1    2    3
    Log    ${var}    #List->Scalar
    &{dic}    Create Dictionary    name=tony    age=18
    Log    ${dic}    #dictionary->scalar
    ${var2}    Create List    4    5    6

Multiple_Variable_TestCase
    ${v1}    ${v2}    ${v3}    Set Variable    aa    bb    cc
    ${first}    @{rest}    Set Variable    aa    bb    cc
    @{before}    ${last}    Set Variable    aa    bb    cc
    ${begin}    @{middle}    ${end}    Set Variable    aa    bb    cc

Extend_Scope_First_TestCase
    ${var}    Set Variable    Hello,world!
    @{list}    Set Variable    1    2    3    4    5
    &{dict}    Create Dictionary    name=tony    age=18    gender=male
    Set Suite Variable    ${var_new}    a new scalar created in case 1
    Set Suite Variable    &{dict_new}    a=1    b=2    c=3
    Set Suite Variable    ${var}
    Set Suite Variable    @{list}
    Set Global Variable    &{dict}

Extend_Scope_Second_TestCase
    Log    ${var}
    Log    ${list}
    Log    ${dict}
    Log    ${var_new}
    Log    ${dict_new}

Test_empty_TestCase
    ${ret}    myKeyword    a    ${EMPTY}    c
    Log    ret=${ret}
    ${ret}    Set Variable    ${EMPTY}
    Log    ret=${ret}

Variable_in_Variable_TestCase
    ${John Home }    Set Variable    /home/john
    ${Alice Home }    Set Variable    /home/alice
    ${name}    Set Variable    John
    Log    ${${name} Home}

evaluate
    @{list}    Create List    ${0}    ${3}    ${5}    ${9}    ${7}
    ...    ${8}
    @{result}    Evaluate    list(filter(lambda x: x % 3 == 0,${list}))
    Log Many    @{result}
    ${random_int}    Evaluate    random.randint(0, 10)    random
    Log    ${random_int}

temp
    Execute Manual Step    手工执行case：xxx

*** Keywords ***
myKeyword
    [Arguments]    ${arg1}    ${arg2}    ${arg3}
    Log    ${arg1} | ${arg2} | ${arg3}
    ${ret}    Set Variable    ${arg1}
    [Return]    ${ret}
