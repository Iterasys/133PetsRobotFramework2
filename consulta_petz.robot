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

# Consulta Produto com Clique na Lupa
#   [Tags]    rapido
#    Dado que acesso o site como cliente
#    Quando escrevo "Ração" na barra de pesquisa
#    E clico no botao da lupa
#    Entao exibe um grid e a frase do resultado esperado
#
# Consulta Produto Apertando Enter
#    [Tags]    rapido
#    Dado que acesso o site como cliente
#    Quando escrevo "Coleira" na barra de pesquisa
#    E aperto a tecla Enter
#    Entao exibe um grid e a frase do resultado esperado

Compra de Produto
    [Tags]    rapido
    Dado que acesso o site como cliente
    E concordo com a Politica de Privacidade
    Quando escrevo "Pote" na barra de pesquisa
    E aperto a tecla Enter
    Entao exibe um grid e a frase do resultado esperado
    Quando seleciono o produto "Porta Ração Petz Rosa 1kg"
    Entao exibe a pagina do produto com o preco de "R$ 59,99"
    Quando mudo a quantidade do produto para "2"
    E clico no botao Adicionar no Carrinho
    Entao exibe a pagina do carrinho com o total de "R$ 119,98"


*** Keywords ***
Dado que acesso o site como cliente
    open browser    ${url}  ${browser}

E concordo com a Politica de Privacidade
    click button    id = aceiteLgpd

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

E aperto a tecla Enter
    press keys       name = q    ENTER

Quando seleciono o produto "${produto}"
    set test variable               ${produto}
    wait until element is enabled   xpath = //a[@data-nomeproduto="${produto}"]      30000ms
    click element                   xpath = //a[@data-nomeproduto="${produto}"]

Entao exibe a pagina do produto com o preco de "${preco}"
    wait until element is visible   xpath = //h1
    element should contain          xpath = //h1                 ${produto}
    element should contain          class = current-price-left   ${preco}

Quando mudo a quantidade do produto para "2"
    click button                    xpath = //button[@onclick="changeQuantity('plus')"]

E clico no botao Adicionar no Carrinho
    click button                    id = adicionarAoCarrinho

Entao exibe a pagina do carrinho com o total de "${preco_total}"
    #wait until element is visible   xpath = //div[@id="cart-item-147547"]   60000ms
    #element should contain          xpath = //div[@id="cart-item-147547"]   ${produto}
    wait until element is visible   class = tx-blue.money
    element should contain          class = tx-blue.money                   ${preco_total}