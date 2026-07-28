*** Settings ***

Documentation    Arquivo para testar o consumo da API com tasks

Resource    ./Service.resource

# Test Setup       Start Session
# Test Teardown    Finish session

*** Tasks ***

Testando a API

    Set User Token
    Get account by name    Usuario medidas App