// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts@4.9.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.2/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.9.2/security/Pausable.sol";

import "./CBDCAccessControl.sol";

/// @title RealDigital
/// @dev Implementação do contrato Real Digital.

contract RealDigital is ERC20, ERC20Burnable, CBDCAccessControl, Pausable {

    // Cria um mapeamento entre endereços e suas quantidades de saldo congelado.
    mapping(address => uint256) public frozenBalanceOf;

    // Define um evento que é acionado sempre que o saldo congelado de uma carteira é alterado.
    event FrozenBalance(address wallet, uint256 amount);
    
    modifier checkFrozenBalance(address from, uint256 amount) {
        require(
            from == address(0) || balanceOf(from) - frozenBalanceOf[from] >= amount,
            string(
                    abi.encodePacked(
                        "Contract address ",
                        Strings.toHexString(address(this)),
                        ": Insufficient liquid balance"
                    )
                )
        );
        _;
    }

    // O construtor é chamado quando o contrato é publicado. Ele define o nome e o símbolo do token, e configura as funções de permissão.
    constructor(string memory _name, string memory _symbol, address _authority, address _admin) ERC20(_name, _symbol) CBDCAccessControl(_authority, _admin) {
    }

    // A função 'pause' permite que um endereço com PAUSER_ROLE pause todas as transferências de tokens.
    function pause() public whenNotPaused onlyRole(PAUSER_ROLE) {
        _pause();
    }

    // A função 'unpause' permite que um endereço com PAUSER_ROLE retome todas as transferências de tokens.
    function unpause() public whenPaused onlyRole(PAUSER_ROLE) {
        _unpause();
    }


    // Função que é chamada antes de qualquer transferência de tokens. Ela verifica se a transferência é válida
    // e permite que a transferência seja pausada.
    //OK: Adicionar modificador de checagem de acesso (olhar CBDCAccessControl)
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal whenNotPaused checkFrozenBalance(from, amount) checkAccess(from, to) override {
        super._beforeTokenTransfer(from, to, amount);
    }

    // A função 'burn' permite que um endereço com a permissão BURNER_ROLE queime uma quantidade específica de tokens de
    // seu próprio saldo.
    function burn(uint256 amount) public whenNotPaused onlyRole(BURNER_ROLE) override {
        _burn(_msgSender(), amount);
    }

    // A função 'burnFrom' permite que um endereço queime uma quantidade específica de tokens de qualquer endereço,
    // desde que o queimador tenha uma permissão de 'allowance' suficiente do endereço de onde os tokens serão queimados.
    function burnFrom(address account, uint256 amount) public whenNotPaused onlyRole(BURNER_ROLE) override {
        super.burnFrom(account, amount);
    }

    // A função 'decimals' retorna o número de casas decimais que o token usa - neste caso, 2.
    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    // Função para incrementar tokens parcialmente bloqueados de uma carteira. Somente quem possuir FREEZER_ROLE pode executar.
    function increaseFrozenBalance(address from, uint256 amount) public whenNotPaused onlyRole(FREEZER_ROLE) {
        frozenBalanceOf[from] += amount;
        emit FrozenBalance(from, frozenBalanceOf[from]);
    }

    // Função para decrementar tokens parcialmente bloqueados de uma carteira. Somente quem possuir FREEZER_ROLE pode executar.
    function decreaseFrozenBalance(address from, uint256 amount) public whenNotPaused onlyRole(FREEZER_ROLE) {
        require(frozenBalanceOf[from] >= amount,
            string(
                abi.encodePacked(
                    "Contract address ",
                    Strings.toHexString(address(this)),
                    ": Insufficient frozen balance"
                )
            )
        );
        frozenBalanceOf[from] -= amount;
        emit FrozenBalance(from, frozenBalanceOf[from]);
    }

    // Função que permite a um endereço com MINTER_ROLE criar uma certa quantidade de tokens e enviá-los para um endereço.
    //OK: Somente quem tiver MINTER_ROLE deve poder executar essa função
    function mint(address to, uint256 amount) public whenNotPaused onlyRole(MINTER_ROLE){
        _mint(to, amount);
    }

    // Função para mover tokens de uma carteira para outra. Somente quem possuir MOVER_ROLE pode executar.
    function move(address from, address to, uint256 amount) public whenNotPaused onlyRole(MOVER_ROLE) {
        _transfer(from, to, amount);
    }

    // Função para destruir tokens de uma carteira. Somente quem possuir MOVER_ROLE pode executar.
    function moveAndBurn(address from, uint256 amount) public whenNotPaused onlyRole(MOVER_ROLE) {
        //OK: Executar função interna de transferencia de 'from' para quem chamou essa função
        _transfer(from, msg.sender, amount);
        //OK: Executar função interna de queima de quem chamou essa função
        _burn(msg.sender, amount);
    }
}
