*** Settings ***
Library           pabot.PabotLib
Resource          ${CURDIR}/parallel_resource.robot

*** Variables ***

*** Test Cases ***
Test Case 5
    Acquire Lock Keyword
