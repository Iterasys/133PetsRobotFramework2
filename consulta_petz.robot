*** Settings ***
Documentation    Consultas no site da Petz

Library  SeleniumLibrary
Library  OperatingSystem
Library  String

Test Teardown   close browser

*** Variables ***
${browser}      Chrome
${url}          https://www.petz.com.br

*** Test Cases ***
Consulta Produto com Clique na Lupa
    [Tags]    rapido
    Dado que acesso o site como cliente
    Quando escrevo "Ração" na barra de pesquisa
    E clico no botao da lupa
    Entao exibe um grid e a frase do resultado esperado
    Feche o browser

Consulta Produto Apertando Enter
    [Tags]    rapido
    Dado que acesso o site como cliente
    Quando escrevo "Coleira" na barra de pesquisa
    E aperto a tecla Enter
    Entao exibe um grid e a frase do resultado esperado
    Feche o browser

*** Keywords ***
Dado que acesso o site como cliente
    open browser    ${url}  ${browser}

Quando escrevo "${palavra_chave}" na barra de pesquisa
    set test variable       ${palavra_chave}
    wait until element is enabled   name = q        30000ms
    input text                      name = q        ${palavra_chave}

E clico no botao da lupa
    click button        class = button-search

Entao exibe um grid e a frase do resultado esperado
    # ARROZ                                        arroz
    ${palavra_chave_upper}  convert to upper case  ${palavra_chave}
    wait until element is visible   css = h1.h2Categoria.nomeCategoria
    element should contain          css = h1.h2Categoria.nomeCategoria      RESULTADOS PARA "${palavra_chave_upper}"

Feche o browser
    close browser

E aperto a tecla Enter
    press keys       name = q    ENTER