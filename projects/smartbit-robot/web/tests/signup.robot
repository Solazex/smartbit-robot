*** Settings ***
Documentation        Cenários de testes de pré-cadastro de clientes

Resource    ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke

    ${account}    Create Dictionary
    ...    name=pablo michel
    ...    email=pablomichel@gmail.com
    ...    cpf=93734812070

    Delete Account By Email    ${account}[email]
    
    Submit signup form    ${account}
    Verify welcome message


# Campo nome deve ser obrigatório
#     [Tags]    required

#     ${account}        Create Dictionary
#     ...    name=${EMPTY}
#     ...    email=pablo.ramao@teste.com.br
#     ...    cpf=02811122502

#     Submit signup form    ${account}
#     Notice should be    Por favor informe o seu nome completo


# Campo email deve ser obrigatório
#     [Tags]    required

#     ${account}        Create Dictionary
#     ...    name=pablo ramao
#     ...    email=${EMPTY}
#     ...    cpf=02811122502

#     Submit signup form    ${account}
#     Notice should be    Por favor, informe o seu melhor e-mail
    

# Campo CPF deve ser obrigatório
#     [Tags]    required

#     ${account}        Create Dictionary
#     ...    name=pablo ramao
#     ...    email=pablo.ramao@teste.com.br
#     ...    cpf=${EMPTY}

#     Submit signup form    ${account}
#     Notice should be    Por favor, informe o seu CPF


# Campo email no formato inválido
#     [tags]    erro_format

#     ${account}        Create Dictionary
#     ...    name=pablo ramao
#     ...    email=pablo.ramao#teste.com.br
#     ...    cpf=02811122502

#     Submit signup form    ${account}
#     Notice should be    Oops! O email informado é inválido



# Campo CPF no formato inválido
#     [tags]    erro_format

#     ${account}        Create Dictionary
#     ...    name=pablo ramao
#     ...    email=pablo.ramao@teste.com.br
#     ...    cpf=werew

#     Submit signup form    ${account}
#     Notice should be    Oops! O CPF informado é inválido


Tentativa de pré-cadastro
    [Template]    Attempt signup
    ${EMPTY}       pablo.ramao@teste.com.br    02811122502     Por favor informe o seu nome completo
    Pablo Ramao    ${EMPTY}                    02811122502     Por favor, informe o seu melhor e-mail
    Pablo Ramao    pablo.ramao@teste.com.br    ${EMPTY}        Por favor, informe o seu CPF
    Pablo Ramao    pablo.ramao#teste.com.br    02811122502     Oops! O email informado é inválido
    Pablo Ramao    pablo.ramao@teste.com.br    werew           Oops! O CPF informado é inválido


*** Keywords ***

Attempt signup

    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}        Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    Submit signup form    ${account}
    Notice should be      ${output_message}