// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "ISimpleExchange.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ImplementSimpleExchange is ISimpleExchange {

    Offer[] public offers;
    Offer[] public offersAccepteds;

    constructor() {
    }

    function getOffersLength() view external override returns (uint) {
        return offers.length;
    }

    function putOffer(uint amountToSell, IERC20 tokenToSell, uint amountToBuy, IERC20 tokenToBuy) external override {
        require(amountToSell !=0, unicode"Não pode ser zero");

        offers.push(Offer({
            amountToSell: amountToSell, 
            tokenToSell: tokenToSell, 
            seller: msg.sender,
            amountToBuy: amountToBuy, 
            tokenToBuy: tokenToBuy        
            }));

        //vendedor manda tokens para o contrato
        tokenToSell.transferFrom(msg.sender, address(this), amountToSell);
    }

    function acceptOffer(uint index) payable external override {
        Offer memory offer = offers[index];
        // require(compare(offer.status, "PENDING"), "Oferta deve estar pendente.");
        
        // offer.status = "ACCEPTED";
        
        IERC20 TokenSell = offer.tokenToSell;
        IERC20 TokenBuy = offer.tokenToBuy;

        //comprador manda tokens para o contrato
        TokenBuy.transferFrom(msg.sender, address(this), offer.amountToBuy);

        //contrato manda tokens para o comprador
        TokenSell.transfer(msg.sender, offer.amountToSell);

        //contrato manda tokens para o vendedor
        TokenBuy.transfer(offer.seller, offer.amountToBuy);

        removeOferta(index);
        offersAccepteds.push(offer);
    }

    function cancelOffer(uint index) public override {
        // Offer memory offer = offers[index];
        // require(compare(offer.status, "PENDING"), "Oferta deve estar pendente.");
        // offer.status = "CANCELED";
        // offers[index] = offer;
        removeOferta(index);
    }

    function balanceOffTokenToSell(uint index) view public returns (uint) {
        Offer memory offer = offers[index];
        return offer.tokenToSell.balanceOf(msg.sender);
    }

    function balanceOffTokenToBuy(uint index) view public returns (uint) {
        Offer memory offer = offers[index];
        return offer.tokenToBuy.balanceOf(msg.sender);
    }

    function stringToByte(string memory text) private pure  returns (bytes32){
        return keccak256(abi.encodePacked(text));
    }

    function compare(string memory text1, string memory text2) private pure returns (bool){
         return stringToByte(text1) == stringToByte(text2);
    }

    function removeOferta(uint index ) private{
            Offer memory offer = offers[index];
            offers[index] = pegaUltimaOferta();
            offers[offers.length - 1] = offer;
            offers.pop();
        }
    function pegaUltimaOferta() private view returns (Offer memory){
         uint lastIndex = offers.length - 1;

         return offers[lastIndex];
    }
    
}