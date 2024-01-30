// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract ControleAcessoDono {
    address public owner;

    modifier apenasDono() {
        require(msg.sender == owner, unicode"Deve ser dono para chamar essa função");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}