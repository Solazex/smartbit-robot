*** Settings ***
Documentation        Cenários de testes de adesões de plano

Resource    ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***

Deve poder realizar nova adesão

    ${data}    Get json fixture    memberships    create

    Delete Account By Email    ${data}[account][email]
    Insert Account             ${data}[account]
    
    SignIn admin
    Go to Memberships
    Create new membership    ${data}

    # Click        css=[data-testid="${cpf}"]
    # Sleep    2
    # ${html}    Get Page Source
    # Log    ${html}

    Toast should be    Matrícula cadastrada com sucesso.


Não deve realizar adesão duplicada
    [Tags]    dup

    ${data}    Get json fixture    memberships    duplicate

    Insert Memberships    ${data}

    SignIn admin
    Go to Memberships
    Create new membership    ${data}
    Toast should be    O usuário já possui matrícula.
    Sleep    3


Deve buscar Matrículas por nome
    [tags]    search

    ${data}    Get json fixture    memberships    search

    Insert Memberships    ${data}

    SignIn admin
    Go to Memberships
    Search by name           ${data}[account][name]
    Should filter by name    ${data}[account][name]


Deve excluir uma matrícula
    [tags]    remove

    ${data}    Get json fixture    memberships    remove

    Insert Memberships    ${data}

    SignIn admin
    Go to Memberships
    Request removal    ${data}[account][name]
    Confirm Removal
    Membership should not be visible    ${data}[account][name]

