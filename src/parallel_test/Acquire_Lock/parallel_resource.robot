*** Settings ***
Library           OperatingSystem

*** Variables ***
${conf_file}      ${CURDIR}/conf.txt

*** Keywords ***
Write Conf File
    Create File    ${conf_file}    item=${TEST NAME}

Read Conf File
    Log File    ${conf_file}

Acquire Lock Keyword
    ${random_int}    Evaluate    random.randint(1,5)    random
    Acquire Lock    MyLock    #争抢MyLock锁
    Log    这时关键区域， 需互斥访问。
    Write Conf File
    sleep    ${random_int}
    Read Conf File
    Release Lock    MyLock    #使用完毕，释放锁
    sleep    ${random_int}
    Read Conf File
