// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
//OK: Importar contrato RealDigital.sol
import "./RealDigital.sol";

/// @title RealTokenizado
/// @dev Implementação do contrato Real Tokenizado (DVt e MEt).

//OK: Herdar contrato RealDigital
contract RealTokenizado  is RealDigital{
    
    string public participant;
    uint256 public cnpj8;
    address public reserve;

    /// @dev Construtor do contrato
    /// @param _name nome do token
    /// @param _symbol símbolo do token
    /// @param _authority endereço da autoridade do contrato
    /// @param _admin endereço do administrador
    /// @param _participant identificação do participante
    /// @param _cnpj8 CNPJ da instituição
    /// @param _reserve endereço da reserva

    //OK: Passar os argumentos necessários para o construtor do contrato RealDigital
    constructor(
        string memory _name,
        string memory _symbol,
        address _authority,
        address _admin,
        string memory _participant,
        uint256 _cnpj8,
        address _reserve
    ) RealDigital(_name, _symbol, _authority, _admin) {
        participant = _participant;
        cnpj8 = _cnpj8;
        reserve = _reserve;
    }

    // Função para atualizar a carteira de reserva do token. A carteira de reserva é usada pelo DvP
    function updateReserve(address newReserve) public whenNotPaused onlyRole(ACCESS_ROLE) {
        reserve = newReserve;
    }

}
