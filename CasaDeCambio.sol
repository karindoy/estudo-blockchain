// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./CasaDeCambioAbstract.sol";

/**
    Crie um contrato que herde desse, receba o endereço de um ERC20 via construtor e venda por ether
    Uma oferta já comprada não pode ser vendida novamente
**/

interface TokenInterface {
    function minter(address account, uint256 amount) external;
}
contract CasaDeCambio is CasaDeCambioAbstract{

    ERC20 public immutable token;
    struct Oferta {
        uint256 id;
        uint256 quantidadeTokens;
        uint256 precoLote;
        address dono;
        bool ehAtivo;
    }
    uint256 qtddOfertas = 0;
    uint256 qtddOfertasAtivas = 0;
    Oferta pOfertaAtiva;

    mapping(uint256 => Oferta) public ofertas;
    mapping(uint256 => Oferta) public ofertasAtivas;


    constructor(address tokenAdress){
        token = ERC20(tokenAdress);
    }
    
    /**
        1.Apenas o dono pode chamar
        2.Validar a quantidadeTokens e precoLote
        3.Transferir tokens do dono para o contrato
        4.Salvar a oferta
        5.Emitir o evento ofertaRealizada

        *Importante precoLote é em Wei, para conversão: https://eth-converter.com/
    **/
    function realizaOferta(uint256 quantidadeTokens, uint256 precoLote) external apenasDono override {
        require(quantidadeTokens !=0, unicode"Não pode ser zero");
        require(token.balanceOf(address(msg.sender)) > 100000, "sdasd ");
        require(precoLote !=0, "Nao pode ser zero");

        token.transferFrom(msg.sender, address(this), quantidadeTokens);
        
        Oferta memory novaOferta;
        novaOferta.quantidadeTokens = quantidadeTokens;
        novaOferta.precoLote = precoLote;
        novaOferta.dono = address(msg.sender);
        novaOferta.ehAtivo = true;
        qtddOfertas = qtddOfertas+1;
        novaOferta.id = qtddOfertas;
        ofertas[novaOferta.id] = novaOferta;
        ofertasAtivas[novaOferta.id] = novaOferta;

        qtddOfertasAtivas = qtddOfertasAtivas +1;
        if(qtddOfertasAtivas == 1){
            pOfertaAtiva = novaOferta;
        }
        emit ofertaRealizada(novaOferta.id, quantidadeTokens, precoLote);
    }

    /**
        1.Checar se o id é valido
        2.Checar se a oferta está ativa
        3.Checar se o valor repassado bate com o precoLote
        4.Recuperar a oferta
        5.Transferir a quantidade de tokens para a carteira de quem chama
    **/
    function compra(uint256 id) external payable override{
        require(id <= qtddOfertas, "id invalido");
        Oferta memory oferta = ofertas[id];
        require(oferta.ehAtivo == true, "deve ser ativo");

        token.transferFrom(address(this), address(msg.sender), oferta.quantidadeTokens);
        oferta.ehAtivo = false;
        ofertas[id] = oferta;

        qtddOfertasAtivas = qtddOfertasAtivas -1;

        for (uint i; i< qtddOfertas; i++) {
            Oferta memory ofertaTest = ofertas[i];
            if(ofertaTest.ehAtivo){
                qtddOfertasAtivas = qtddOfertasAtivas +1;
                if(qtddOfertasAtivas == 1){
                    pOfertaAtiva = ofertaTest;
                }
            }
             
        }
    }

    /**
        Retornar a quantidade de ofertas ativas e o id da primeira oferta disponível
    **/
    function consultaOfertas() external view override returns (uint, uint){
        return (qtddOfertasAtivas, pOfertaAtiva.id);
    }
    
    // Desafio opcional: Retornar uma lista das ofertas ativas

    //Lambuja
    function sacarFundos() public apenasDono override{
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