*** Settings ***
Documentation        Cenários de testes do login SAC

Resource        ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve logar como gestor de academia
    
    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com


Não deve logar com senha incorreta
    [Tags]    inv_pass
    Go to login page
    Submit login form    sac@smartbit.com    abc123

    #esses comandos temp funciona para pegar log html de campos que desaparecem de tela por um período
    # Sleep    3
    # ${temp}    Get Page Source
    # Log    ${temp}

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!


Não deve logar com email não cadastrado
    [Tags]    inv_email
    Go to login page
    Submit login form    404@smartbit.com    abc123

    #esses comandos temp funciona para pegar log html de campos que desaparecem de tela por um período
    # Sleep    3
    # ${temp}    Get Page Source
    # Log    ${temp}

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!


Tentativa de login com dados incorretos
    [Tags]    temp
    [Template]    Login with verify notice
    ${EMPTY}            ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}            pwd123      Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    www.smartbit.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    www.smartbit.com    pwd123      Oops! O email informado é inválido
    sac&smartbit.com    pwd123      Oops! O email informado é inválido
    dsfsfdsfdsffdsfd    pwd123      Oops! O email informado é inválido
    3453465657567678    pwd123      Oops! O email informado é inválido
    asdasrs@@#$$$546    pwd123      Oops! O email informado é inválido
    test*gmail.com      pwd123      Oops! O email informado é inválido
    teste.com@&*        pwd123      Oops! O email informado é inválido

*** Keywords ***

Login with verify notice
    [Arguments]    ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form    ${email}    ${password}
    Notice should be     ${output_message}

