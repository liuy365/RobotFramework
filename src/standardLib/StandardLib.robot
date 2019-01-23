*** Test Cases ***
BuiltIn
    Should Match    Abc    AB?    ignore_case=True
    Should Match Regexp    ABCD    ^[A-Z]{4}$
    Should Match Regexp    Testing String123    \\w+\\d{3}
