*** Settings ***
Library           pabot.PabotLib
Resource          ${CURDIR}/parallel_resource.robot

*** Variables ***

*** Test Cases ***
Test Case 3
    Acquire Lock Keyword
