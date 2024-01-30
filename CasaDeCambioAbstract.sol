// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "./ControleAcessoDono.sol";

/**
    Crie um contrato que herde desse, receba o endereço de um ERC20 via construtor e venda por ether
    Uma oferta já comprada não pode ser vendida novamente
**/
abstract contract CasaDeCambioAbstract is ControleAcessoDono {

    //Event a ser emitido
    event ofertaRealizada(uint256 ultimaOfertaAdicionada, uint256 quantidade, uint256 preco);

    /**
        1.Apenas o dono pode chamar
        2.Validar a quantidadeTokens e precoLote
        3.Transferir tokens do dono para o contrato
        4.Salvar a oferta
        5.Emitir o evento ofertaRealizada

        *Importante precoLote é em Wei, para conversão: https://eth-converter.com/
    **/
    function realizaOferta(uint256 quantidadeTokens, uint256 precoLote) external virtual;

    /**
        1.Checar se o id é valido
        2.Checar se a oferta está ativa
        3.Checar se o valor repassado bate com o precoLote
        4.Recuperar a oferta
        5.Transferir a quantidade de tokens para a carteira de quem chama
    **/
    function compra(uint256 id) external payable virtual;

    /**
        Retornar a quantidade de ofertas ativas e o id da primeira oferta disponível
    **/
    function consultaOfertas() external view virtual returns (uint, uint);
    
    // Desafio opcional: Retornar uma lista das ofertas ativas

    //Lambuja
    function sacarFundos() public apenasDono virtual{
        address payable recebedor = payable(msg.sender);
        recebedor.transfer(address(this).balance);
    }

    /* Dicas para armazenar ofertas:
        Mapping:
            mapping(xtype => ytype) public zMap;
            zMap[i] = valor;
            valor = zMap[i];
            //Importante: Mapping nunca remove um elemento, controle de inativar via código
        Array Dinamico:
            int[] teste;
            teste.push(int); //Inclui no fim da lista
            teste.length; // tamanho do array
            teste.pop(); // Remove o ultimo elemento
            teste[i];
    */
}