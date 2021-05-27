*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://jsonplaceholder.typicode.com
${realtive_url}    posts

*** Test Cases ***
GET_postsInfo
    create session    session1    ${base_url}
    ${response}=    get request    session1    /${realtive_url}/1
    #log to console    ${response.status_code}
    #log to console    ${response.content}
    #log to console    ${response.headers}

    #Validations
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}    200
    
    ${body}=    convert to string    ${response.content}
    should contain    ${body}    userId

    ${contentTypeValue}=    get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contentTypeValue}    application/json; charset=utf-8

    #https://jsonplaceholder.typicode.com/posts/1