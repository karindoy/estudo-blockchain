// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Sum {

    event Soma(uint256 resultado);

    function sum(uint256 num1, uint256 num2) public returns (uint256){
        emit Soma(num1 + num2);
        return num1 + num2;
    }

}