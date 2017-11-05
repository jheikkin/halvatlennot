*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Chrome
${URL}            https://www.google.fi
${URL-FINNAIR}    http://www.travellink.fi
${URL-TRAVELLINK}    http://www.travellink.fi
${travellink-xpath1}    xpath=(//*[@id="departure-autocomplete0"]/div[2]/div[3]/div[1]/div[2]/input)
${travellink-xpath2}    xpath=(//*[@id="destination-autocomplete0"]/div[2]/div[3]/div[1]/div[2]/input)
${travellink-xpath3}    xpath=(//*[@id="flights-manager"]/div[2]/div[2]/div[1]/div[3]/div[1])
${travellink-xpath4}    xpath=(//*[@id="flights-manager"]/div[2]/div[2]/div[1]/div[3]/div[1]/div[2]/div)
${travellink-xpath5}    xpath=(//*[@id="calendar0"])
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

*** Test Cases ***
Open Google
    Open Browser To Google
    [Teardown]    Close Browser

Open Finnair
    Open Browser to Finnair
    : FOR    ${index}    IN RANGE    5
    \    ${dDate} =    Set Variable    ${index + 26}
    \    ${rDate} =    Set Variable    ${index + 27}
    \    ${dDate} =    Evaluate    str(${dDate})
    \    ${rDate} =    Evaluate    str(${rDate})
    \    Set Dates    deptDate=${dDate}    deptMonth=2017-12    retDate=${rDate}    retMonth=2018-1
    \    Get Screenshots
    \    Go Back
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Google
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Google

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

Open Browser To Finnair
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
    #    below code moves the actual browser window position
    #    Set Window Position    0    -100