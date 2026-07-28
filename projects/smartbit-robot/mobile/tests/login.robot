*** Settings ***

Documentation    Suite de testes de login

Resource    ../resources/Base.resource

Test Setup       Start Session
Test Teardown    Finish session

*** Test Cases ***

Deve logar com o cpf e IP

    ${data}    Get json fixture    login
    Insert Memberships    ${data}

    Signin with document    ${data}[account][cpf]
    User is logged in


Não deve logar com cpf não cadastrado
    [Tags]    temp

    Signin with document    50908162049
    Popup have text         Acesso não autorizado! Entre em contato com a central de atendimento


Não deve logar com cpf com dígito inválido
    [Tags]    temp

    Signin with document    509081620499
    Popup have text         CPF inválido, tente novamente
