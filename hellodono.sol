// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Hello
 * @dev Hellowold
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */

import "./ControleAcessoDono.sol";

contract Hello is ControleAcessoDono {

    function hello(string memory texto) public view apenasDono returns (string memory){
        return texto;
    }
}