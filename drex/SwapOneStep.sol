// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./RealDigital.sol";
import "./RealTokenizado.sol";

/// @title SwapOneStep
/// @dev Este contrato implementa a troca de Real Tokenizado entre dois participantes distintos.

/// A troca destrói Real Tokenizado do cliente pagador, 
/// transfere Real Digital do participante pagador para o participante recebedor
/// e emite Real Tokenizado para o cliente recebedor.

/// Todos os passos dessa operação de _swap_ são realizados em apenas uma transação.

contract SwapOneStep {

    // Referência ao contrato para que seja efetuada a movimentação de Real Digital
    RealDigital private CBDC;

    // Evento de swap executado
    event SwapExecuted(
        uint256 indexed senderNumber, // O CNPJ8 do pagador
        uint256 indexed receiverNumber, // O CNPJ8 do recebedor
        address sender, // A carteira do pagador
        address receiver, // A carteira do recebedor
        uint256 amount // O valor que foi movimentado
    );

    /// @dev Construtor do contrato
    /// @param _CBDC: endereço do contrato Real Digital

    constructor(RealDigital _CBDC) {
        CBDC = _CBDC;
    }

    /// @dev Transfere o Real Tokenizado do cliente pagador para o recebedor. O cliente pagador é identificado pela carteira que estiver executando esta função.
    /// @param tokenSender: O endereço do contrato de Real Tokenizado do participante pagador
    /// @param tokenReceiver: O endereço do contrato de Real Tokenizado do participante recebedor
    /// @param receiver: O endereço do cliente recebedor
    /// @param amount: O valor a ser movimentado

    function executeSwap(
        RealTokenizado tokenSender,
        RealTokenizado tokenReceiver,
        address receiver,
        uint256 amount
    ) public {
        // O valor é retirado do pagador
        //OK: Executar o burn de real tokenizado do pagador
        tokenSender.burnFrom(msg.sender,amount);
        // Real Digital é transferido do participante pagador para o recebedor
        //OK: Transfere real digital do participante pagador para o recebedor
        CBDC.transferFrom(tokenSender.reserve(), tokenReceiver.reserve(), amount);
        // Real Tokenizado é emitido para o recebedor
        //OK: Executar o mint de real tokenizado para o recebedor
        tokenReceiver.mint(receiver, amount);

        // Emite o evento SwapExecuted
        emit SwapExecuted(
            tokenSender.cnpj8(),
            tokenReceiver.cnpj8(),
            msg.sender,
            receiver,
            amount
        );
    }
}
