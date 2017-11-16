*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Chrome
${URL-HALVATLENNOT}    http://www.halvatlennot.fi
${halvatlennot-xpath1}    xpath=(//*[@id="tbAptDep"])
${halvatlennot-xpath2}    xpath=(//*[@id="tbAptDest"])
${halvatlennot-xpath3}    xpath=(//*[@id="ddDepartDay"])
${halvatlennot-xpath4}    xpath=(//select[@name="ddDepartDay"])
${halvatlennot-xpath5}    xpath=(//*[@id="ddDepartMonth"])
${halvatlennot-xpath6}    xpath=(//select[@name="ddDepartMonth"])
${halvatlennot-xpath7}    xpath=(//*[@id="ddReturnDay"])
${halvatlennot-xpath8}    xpath=(//select[@name="ddReturnDay"])
${halvatlennot-xpath9}    xpath=(//*[@id="ddReturnMonth"])
${halvatlennot-xpath10}    xpath=(//select[@name="ddReturnMonth"])
${halvatlennot-xpath11}    xpath=(//*[@id="ddAdults"])
${halvatlennot-xpath12}    xpath=(//select[@name="ddAdults"])
${halvatlennot-xpath13}    xpath=(//*[@id="ddChildren"])
${halvatlennot-xpath14}    xpath=(//select[@name="ddChildren"])
${halvatlennot-xpath15}    xpath=(//*[@id="btnSearch"])
${halvatlennot-xpath16}    xpath=(//*[@id="stopsFilter"]/table/tbody/tr[2]/td[1]/span)
${halvatlennot-xpath17}    xpath=(//*[@id="stopsFilter"]/table/tbody/tr[3]/td[1]/span)
${DepartureDate}   26
${DepartureMonth}   2017-12
${ReturnDate}   27
${ReturnMonth}   2018-1
${Rounds}   1

*** Test Cases ***
Open HalvatLennot
    Open Browser to HalvatLennot
    : FOR    ${index}    IN RANGE    ${Rounds}
    \    ${dDate} =    Set Variable    ${index + ${DepartureDate}}
    \    ${rDate} =    Set Variable    ${index + ${ReturnDate}}
    \    ${dDate} =    Evaluate    str(${dDate})
    \    ${rDate} =    Evaluate    str(${rDate})
    \    Set Dates    deptDate=${dDate}    deptMonth=${DepartureMonth}    retDate=${rDate}    retMonth=${ReturnMonth}
    \    Get Screenshots
    \    Go Back
    [Teardown]    Close Browser

*** Keywords ***
Set Dates
    [Arguments]    ${deptDate}=${VARIABLE}    ${deptMonth}=${VARIABLE}    ${retDate}=${VARIABLE}    ${retMonth}=${VARIABLE}
    Wait Until Page Contains Element    ${halvatlennot-xpath1}    30
    Click Element    ${halvatlennot-xpath1}
    Input Text    ${halvatlennot-xpath1}    Helsinki
    Wait Until Page Contains Element    ${halvatlennot-xpath2}    30
    Click Element    ${halvatlennot-xpath2}
    Input Text    ${halvatlennot-xpath2}    Bangkok
    Wait Until Page Contains Element    ${halvatlennot-xpath3}    30
    Click Element    ${halvatlennot-xpath3}
    Select From List    ${halvatlennot-xpath4}    ${deptDate}
    Wait Until Page Contains Element    ${halvatlennot-xpath5}    30
    Click Element    ${halvatlennot-xpath5}
    Select From List    ${halvatlennot-xpath6}    ${deptMonth}
    Wait Until Page Contains Element    ${halvatlennot-xpath7}    30
    Click Element    ${halvatlennot-xpath7}
    Select From List    ${halvatlennot-xpath8}    ${retDate}
    Wait Until Page Contains Element    ${halvatlennot-xpath9}    30
    Click Element    ${halvatlennot-xpath9}
    Select From List    ${halvatlennot-xpath10}    ${retMonth}
    Wait Until Page Contains Element    ${halvatlennot-xpath11}    30
    Click Element    ${halvatlennot-xpath11}
    Select From List    ${halvatlennot-xpath12}    2
    Wait Until Page Contains Element    ${halvatlennot-xpath13}    30
    Click Element    ${halvatlennot-xpath13}
    Select From List    ${halvatlennot-xpath14}    1
    Wait Until Page Contains Element    ${halvatlennot-xpath15}    30
    Click Element    ${halvatlennot-xpath15}
    Sleep    20s    to get results
    Click Element    ${halvatlennot-xpath16}
    Click Element    ${halvatlennot-xpath17}
    Sleep    10s    to get results

Open Browser To HalvatLennot
    Open Browser    ${URL-HALVATLENNOT}    ${BROWSER}
    Sleep    5s    to get title
    ${Window1Title}=    Get Title
    Should Contain    ${Window1Title}    HALVAT LENNOT

Get Screenshots
    Execute JavaScript    window.scrollTo(0, 0)
    Capture Page Screenshot
    Execute JavaScript    window.scrollTo(0, 200)
    Capture Page Screenshot
    Execute JavaScript    window.scrollTo(0, 400)
    Capture Page Screenshot
    Execute JavaScript    window.scrollTo(0, 600)
    Capture Page Screenshot
