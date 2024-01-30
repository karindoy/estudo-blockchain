// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Fatorial {

    function fatorial(uint256 num) pure public returns(uint256){
        uint resultado = 1;
        for(uint256 i=1; i<=num ;i++){    
            resultado=resultado*i;    
        }         


        return resultado;
    }

}