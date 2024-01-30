// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "./ControleAcessoDono.sol";


interface IArmazenamento {
    
    function guarda(string memory texto) external returns (string memory);

    function recupera() external view returns (string memory);

} 

contract Armazenamento is IArmazenamento, ControleAcessoDono{

    string textoArmazenado;

    function guarda(string memory texto) public onlyOwner returns (string memory){
        textoArmazenado = texto;
        return textoArmazenado;
    }

    function recupera() external view returns (string memory){
        return textoArmazenado;
    }
}