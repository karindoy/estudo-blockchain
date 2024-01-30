// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Verifica {

    function ehPar(uint256 num1) public pure returns (bool){
           return (num1 % 2 == 0);
    }

}