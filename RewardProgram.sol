// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
 
interface TokenInterface {
    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;
 
    function balanceOf(address account, uint256 id) external returns (uint256);
 
    function transferOwnership(address newOwner) external;
 
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes memory data
    ) external;
 
    function setApprovalForAll(address operator, bool approved) external;
}
 
contract RewardProgram is Ownable, ERC1155Holder {
    //TODO: Declarar variável erc1155Token com a interface criada acima
 
    TokenInterface private erc1155Token;
 
    uint256 public constant UNIT_PRICE = 10;
 
    mapping(address => uint256) public rewardBalances;
 
    event TokensEarned(address indexed user, uint256 amount);
    event TokensExchanged(address indexed user, uint256 amount);
 
    constructor(address _erc1155TokenAddress) Ownable(msg.sender) {
        //TODO: Defina o endereço do contrato ERC-1155 (passado no parâmetro) na variável declarada
        erc1155Token = TokenInterface(_erc1155TokenAddress);
    }
 
    function update1155ContractOwnership(address newOwner) external onlyOwner {
        require(
            newOwner != address(this),
            "Endereco do novo proprietario invalido"
        );
 
        // Transfere a propriedade do contrato ERC-1155 para o novo proprietário
        erc1155Token.transferOwnership(newOwner);
    }
 
    function earnTokens(uint256 _amount, address _receiver) external onlyOwner {
        require(_amount > 0, "O saldo deve ser maior do que 0");
 
        // Verifica se o contrato tem saldo suficiente
        uint256 contractBalance = erc1155Token.balanceOf(address(this), 0);
        if (contractBalance >= _amount) {
            // Transfere tokens ERC-20 do contrato para o beneficiário
            erc1155Token.safeTransferFrom(
                address(this),
                _receiver,
                0,
                _amount,
                "0x00"
            );
        } else {
            // Se não houver saldo suficiente, minta novos tokens
            //TODO: Chama função mint do ERC-1155 para o token fungível
            erc1155Token.mint(_receiver, 0, _amount, "");
        }
 
        // Atualiza o saldo de recompensas do beneficiário
        rewardBalances[_receiver] += _amount;
 
        emit TokensEarned(_receiver, _amount);
    }
 
    function exchangeTokens() external {
        address sender = msg.sender;
        require(
            rewardBalances[sender] >= UNIT_PRICE,
            "Saldo insuficiente"
        );
        // Reduz o saldo de recompensas do beneficiário
        //TODO: Transferir valor do preço unitário da recompensa do remetente para o contrato
        erc1155Token.safeTransferFrom(sender, address(this), 0, UNIT_PRICE, "");
        //TODO: Dar mint de um token de id 1 para o beneficiário
        erc1155Token.mint(sender, 1, 1, "");
        rewardBalances[sender] -= UNIT_PRICE;
 
        emit TokensExchanged(sender, UNIT_PRICE);
    }
}