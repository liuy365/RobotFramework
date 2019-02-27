*** Settings ***
Library           pabot.PabotLib
Resource          ${CURDIR}/parallel_resource.robot

*** Variables ***

*** Test Cases ***
Test Case 2
    Acquire Lock Keyword
