// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Importação do contrato de controle de acesso do OpenZeppelin
import "@openzeppelin/contracts@4.9.2/access/AccessControl.sol";

/// @title CBDCAccessControl
/// @dev Este Smart Contract é responsável pela camada de controle de acesso para o Real Digital/Tokenizado.
/// @notice Ele determina quais carteiras podem enviar/receber tokens e controla os papeis de qual endereço pode emitir/resgatar/congelar saldo de uma carteira.

abstract contract CBDCAccessControl is AccessControl { 

    // Definição dos diversos roles do sistema
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE"); // Role que permite pausar o contrato
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE"); // Role que permite fazer o `mint` nos contratos de token
    bytes32 public constant ACCESS_ROLE = keccak256("ACCESS_ROLE"); // Role que permite habilitar um endereço
    bytes32 public constant MOVER_ROLE = keccak256("MOVER_ROLE"); // Role que permite acesso à função `move`, ou seja, transferir o token de outra carteira
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE"); // Role que permite acesso à função `burn`
    bytes32 public constant FREEZER_ROLE = keccak256("FREEZER_ROLE"); // Role que permite bloquear saldo de uma carteira, por exemplo para o _swap_ de dois passos

    // Mapping para acompanhar quais contas estão autorizadas a receber o token
    mapping(address => bool) public authorizedAccounts;

    // Evento emitido quando uma carteira é habilitada
    event EnabledAccount(address member);

    // Evento emitido quando uma carteira é desabilitada
    event DisabledAccount(address member);

    
    /// @dev Construtor do contrato
    /// @param _authority: endereço da autoridade do contrato que pode fazer todas as operações com o token
    /// @param _admin: endereço do administrador do contrato, que pode trocar a autoridade do contrato caso seja necessário

    constructor(address _authority, address _admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
        _grantRole(BURNER_ROLE, _authority);
        _grantRole(MINTER_ROLE, _authority);
        _grantRole(PAUSER_ROLE, _authority);
        _grantRole(MOVER_ROLE, _authority);
        _grantRole(ACCESS_ROLE, _authority);
        _grantRole(FREEZER_ROLE, _authority);    
    }


    /// @dev Modificador que checa se tanto o pagador quanto o recebedor estão habilitados a receber o token
    /// @param from: endereço da carteira do pagador
    /// @param to: endereço da carteira do recebedor

    modifier checkAccess(address from, address to) {
        require(
            from != address(0) || to != address(0),
            "CBDCAccessControl: Both from and to accounts cannot be zero"
        );
        require(
            (from == address(0) && authorizedAccounts[to]) ||
            (to == address(0) && authorizedAccounts[from]) ||
            (authorizedAccounts[from] && authorizedAccounts[to]),
            "CBDCAccessControl: Both from and to accounts must be authorized"
        );
        _;
    }


    /// @dev Habilita uma carteira a receber o token
    /// @param member: endereço da carteira a ser habilitada

    function enableAccount(address member) public onlyRole(ACCESS_ROLE) {
        authorizedAccounts[member] = true;
        emit EnabledAccount(member);
    }


    /// @dev Desabilita uma carteira a receber o token
    /// @param member: endereço da carteira a ser desabilitada

    function disableAccount(address member) public onlyRole(ACCESS_ROLE) {
        authorizedAccounts[member] = false;
        emit DisabledAccount(member);
    }


    /// @dev Checa se uma carteira pode receber o token
    /// @param account: endereço da carteira a ser checada

    function verifyAccount(address account) public view virtual returns (bool) {
        return authorizedAccounts[account];
    }

}
