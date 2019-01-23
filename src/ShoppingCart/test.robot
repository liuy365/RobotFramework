*** Settings ***
Library           String

*** Test Cases ***
dict_test
    ${str}    set variable    thw=cn; _l_g_=Ug%3D%3D; v=0; sg=634; cookie2=34da56e2f4a69fc63d5c913629cb2bcc; cna=2yzLFDzg6RQCAXAsaecZzfHt; _tb_token_=5efe6333603d1; t=578d4740c264b34681107b9032b014db; unb=49490743; skt=c46aa4f8be8f9d86; cookie1=UNaBRqD5Q4FRgztHTSRiN%2Brc6TJW%2BgujgKA3RDZ508M%3D; csg=7b99f7c4; uc3=vt3=F8dByE%2BgFZx%2BioquXLg%3D&id2=VyUIU7644FM%3D&nk2=D8rzDTiq&lg2=WqG3DMC9VAQiUQ%3D%3D; existShop=MTU0Nzk3NjQyNw%3D%3D; tracknick=liuy36; lgc=liuy36; _cc_=W5iHLLyFfA%3D%3D; mt=ci=13_1; dnk=liuy36; _nk_=liuy36; cookie17=VyUIU7644FM%3D; tg=0; ubn=p; ucn=unsz; uc1=cookie16=URm48syIJ1yk0MX2J7mAAEhTuw%3D%3D&cookie21=UtASsssme%2BBq&cookie15=V32FPkk%2Fw0dUvg%3D%3D&existShop=false&pas=0&cookie14=UoTYMbb7%2BJ0haQ%3D%3D&cart_m=0&tag=8&lng=zh_CN; isg=BHR0o4RNlOO0qACvgH1MAUh7RTIm5V9EmGM3bg7VAP-CeRTDNl1oxyo7_fAEmtCP
    @{list}    Split String    ${str}    ;
    : FOR    ${item}    IN    @{list}
    \    ${item}    Strip String    ${item}
    \    ${key}    Fetch From Left    ${item}    =
    \    ${len}    Get Length    ${key}
    \    ${len}    Evaluate    ${len}+1
    \    ${value}    Get Substring    ${item}    ${len}
    \    Log    ${key}
    \    log    ${value}
