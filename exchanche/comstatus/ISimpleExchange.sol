
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ISimpleExchange {

    struct Offer {
        uint amountToSell;
        IERC20 tokenToSell;
        address seller;
        uint amountToBuy;
        IERC20 tokenToBuy;
        string status;
    }

    function getOffersLength() external view returns (uint);

    function putOffer(uint amountToSell, IERC20 tokenToSell, uint amountToBuy, IERC20 tokenToBuy) external;

    function acceptOffer(uint index) payable external;

    function cancelOffer(uint index) external;
}