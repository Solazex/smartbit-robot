*** Settings ***
Documentation        Teste para verificar o slogan da smartbit na webapp

Library        Browser


*** Test Cases ***

Deve exibir o Slogan na landing Page
    New Browser     chromium    headless=False
    New Page        http://localhost:3000/
    Get Text        css=.headline h2        equal    Sua Jornada Fitness Começa aqui!
