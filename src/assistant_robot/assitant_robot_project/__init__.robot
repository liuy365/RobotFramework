*** Settings ***
Documentation     助理机器人测试工程
Suite Setup       Log    进入助理机器人测试工程
Suite Teardown    Log    退出助理机器人测试工程
Test Setup        Log    进入定义助理机器人测试工程里的case setup
Test Teardown     Log    进入定义助理机器人测试工程里的case teardown
Force Tags        regression
