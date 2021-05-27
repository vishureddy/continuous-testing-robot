*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://jsonplaceholder.typicode.com
${realtive_url}    posts
*** Test Cases ***
PUT_Registration
    create session    mysession    ${base_url}  
    ${body}=    create dictionary    title=foo    body=bar    userId=1
    ${header}=    create dictionary    Content-Type=application/json
    ${response}=    post request   mysession    /${realtive_url}    data=${body}    headers=${header}
    log to console    ${response.status_code}
    log to console    ${response.content}

    #validations
    ${res_body}=    convert to string    ${response.content}
    #${expected_response}=    create dictionary    title=foo    body=bar    userId=1    id=101
    should contain   ${res_body}    foo
    should contain   ${res_body}    bar
    should contain   ${res_body}    1
    should contain   ${res_body}    101
    
    ${status_code}=    convert to string     ${response.status_code}
    should be equal    ${status_code}    201