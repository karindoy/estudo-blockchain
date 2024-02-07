DREX 

No REAL DIGITAL o endereço do BACEN será tanto a autoridade quanto o admin
No REAL TOKENIZADO o endereço do BACEN será somente o ADMIN e a autoridade será o endereço do Banco X
No REAL TOKENIZADO o reserve e autoridade são os mesmos endereços

Pré-requisitos
Mint: A instituição deve possuir real digital suficiente em sua reserva para a transferência. Para que a instituição possa receber Real Digital, é necessário que a conta esteja habilitada, executar enableAccount (APENAS BACEN!). Além disso, para que a instituição possa ter Real Digital, é necessário que seja cunhado pelo BACEN (APENAS BACEN!).
Mint: Cliente deve ter tokens (da instituição) suficientes para a transferência. Além disso, é necessário que a instituição habilite a conta do cliente no contrato real tokenizado do remetente, executar enableAccount. E o cliente destinatário também deve ter sua conta habilitada no real tokenizado do destinatário.
grantRole (APENAS BACEN!): SwapOneStep deve possuir permissão para executar o burn do real tokenizado. Atribuir BURNER_ROLE ao endereço do contrato SwapOneStep no Real tokenizado da instituição remetente.
grantRole (APENAS BACEN!): SwapOneStep deve possuir permissão para executar o mint do real tokenizado. Atribuir MINTER_ROLE ao endereço do contrato SwapOneStep no Real tokenizado da instituição destinatária.
Para cada executeSwap
approve: executar pela conta do cliente o método approve do Real Tokenizado do remetente, informando o endereço do swapOneStep e o valor a ser transferido.
approve: executar pela conta reserva (reserve account registrada no Real Tokenizado) do participante remetente o método approve do Real Digital, informando o endereço do swapOneStep e o valor a ser transferido.
Executar executeSwap pela conta do cliente.


Shangai
BACEN: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
BANCO A: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
BANCO B: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
CLIENTE A: 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
CLIENTE B: 0x617F2E2fD72FD9D5503197092aC168c91465E7f2

Real digital: 0xd9145CCE52D386f254917e481eB44e9943F39138
Real tokenizado A: 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8
Real tokenizado B: 0xf8e81D47203A594245E36C48e151709F0C19fBe8
SwapOneStep: 0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD

steps:

Real digital
enableAccount -> BANCO A e BACEN
grantRole -> BACEN e role de mint em bytes
mint -> BANCO A e 1000

Real tokenizado A
enableAccount -> BANCO A e CLIENTE A
grantRole -> BANCO A e role de mint em bytes com conta do bacen
mint -> CLIENTE A e 200

Real tokenizado B
enableAccount -> BANCO A e CLIENTE B
grantRole -> BANCO A e role de mint em bytes com conta do bacen
mint -> CLIENTE A e 100

Real tokenizado A
grantRole -> BACEN e role de access em bytes com conta do bacen
updateReserva -> Banco A com conta do bacen

Real tokenizado B
grantRole -> BACEN e role de access em bytes com conta do bacen
updateReserva -> Banco B com conta do bacen

Real digital
increaseAllowance -> SwapOneStep , 100 com conta do Banco A
Real tokenizado A 
increaseAllowance -> SwapOneStep , 100 com conta do Cliente A
Real tokenizado B
increaseAllowance -> SwapOneStep , 100 com conta do Banco B
enableAccount -> Real tokenizado B

SwapOneStep
executeSwap -> Real tokenizado A, Real tokenizado B, Cliente B, 100 com conta do Cliente A

No REAL DIGITAL o endereço do BACEN será tanto a autoridade quanto o admin
No REAL TOKENIZADO o endereço do BACEN será somente o ADMIN e a autoridade será o endereço do Banco X
No REAL TOKENIZADO o reserve e autoridade são os mesmos endereços

Pré-requisitos
Mint: A instituição deve possuir real digital suficiente em sua reserva para a transferência. Para que a instituição possa receber Real Digital, é necessário que a conta esteja habilitada, executar enableAccount (APENAS BACEN!). Além disso, para que a instituição possa ter Real Digital, é necessário que seja cunhado pelo BACEN (APENAS BACEN!).
Mint: Cliente deve ter tokens (da instituição) suficientes para a transferência. Além disso, é necessário que a instituição habilite a conta do cliente no contrato real tokenizado do remetente, executar enableAccount. E o cliente destinatário também deve ter sua conta habilitada no real tokenizado do destinatário.
grantRole (APENAS BACEN!): SwapOneStep deve possuir permissão para executar o burn do real tokenizado. Atribuir BURNER_ROLE ao endereço do contrato SwapOneStep no Real tokenizado da instituição remetente.
grantRole (APENAS BACEN!): SwapOneStep deve possuir permissão para executar o mint do real tokenizado. Atribuir MINTER_ROLE ao endereço do contrato SwapOneStep no Real tokenizado da instituição destinatária.
Para cada executeSwap
approve: executar pela conta do cliente o método approve do Real Tokenizado do remetente, informando o endereço do swapOneStep e o valor a ser transferido.
approve: executar pela conta reserva (reserve account registrada no Real Tokenizado) do participante remetente o método approve do Real Digital, informando o endereço do swapOneStep e o valor a ser transferido.
Executar executeSwap pela conta do cliente.


SEPOLIA
BACEN: 0x73D398EE024aCb420eCD5Af0995783324c168877
BANCO A: 0xC24aa729AfbcBd22f000f069c1ceA513B3039AEc
BANCO B: 0x428DB28A374339c04643BAC897c5C4D25183d050
CLIENTE A: 0xc1151bB67be20dF2BFf4DF56eDdE14792c9bd71f
CLIENTE B: 0x755A99f3351224d6E3ad318F834EB9336a7C43cb

Real digital
Deploy com conta do BACEN
contrato: 0x4F84F746B224813a6A3FF51e3A18CA793f3eA5Ac
txhash: 0x242b1c18c6e1540e689205f39649ade684a97b6e158794fe6bf277278dcd7d1b
input:
{
	"string _name": "Real",
	"string _symbol": "RS",
	"address _authority": "0x73D398EE024aCb420eCD5Af0995783324c168877",
	"address _admin": "0x73D398EE024aCb420eCD5Af0995783324c168877"
}

Real tokenizado A
Deploy com conta do BACEN
contrato: 0x0195d58acf9BE0Ed19CD464E199649577Aa4FA4b
txhash: 0x413d23d7250cdf690da58c290996a30c0a3950db01b476dd14d25078f85ba3c1
input:
{
	"string _name": "Real Token A",
	"string _symbol": "RTA",
	"address _authority": "0xC24aa729AfbcBd22f000f069c1ceA513B3039AEc",
	"address _admin": "0x73D398EE024aCb420eCD5Af0995783324c168877",
	"string _participant": "Banco A",
	"uint256 _cnpj8": "92521193000144",
	"address _reserve": "0xC24aa729AfbcBd22f000f069c1ceA513B3039AEc"
}

Real tokenizado B
Deploy com conta do BACEN
contrato: 0x0F6416BE50CA14B62cC2B56dc1cf95c8FAE3806C
txhash: 0x4c5e8d1f85882378e59a73e806ef01002853d9ea9a5a341f9cce1311def5003e
input:
{
	"string _name": "Real Token B",
	"string _symbol": "RTB",
	"address _authority": "0x428DB28A374339c04643BAC897c5C4D25183d050",
	"address _admin": "0x73D398EE024aCb420eCD5Af0995783324c168877",
	"string _participant": "Banco B",
	"uint256 _cnpj8": "72776285000168",
	"address _reserve": "0x428DB28A374339c04643BAC897c5C4D25183d050"
}

SwapOneStep:
Deploy com conta do BACEN
contrato: 0xDc0abAED9776AB132Ff106819a130a06518636CF
txhash: 0x1f3e40b8b5964fc362d475712e1b43830827e3ceda2ebbb9c35d04974fd0983f
input: 
{
	"address _CBDC": "0x4F84F746B224813a6A3FF51e3A18CA793f3eA5Ac"
}

steps:

Na conta do BACEN - MINT de 100 reais para o BANCO A
Real digital
    enableAccount -> member: 0xC24aa729AfbcBd22f000f069c1ceA513B3039AEc 
    mint -> to: 0xC24aa729AfbcBd22f000f069c1ceA513B3039AEc amount: 10000
    balanceOf -> account: 0xC24aa729AfbcBd22f000f069c1ceA513B3039AEc

Na conta do BANCO A - MINT de 2 reais tokenizados para o CLIENTE A
Real tokenizado A
    enableAccount -> member: 0xc1151bB67be20dF2BFf4DF56eDdE14792c9bd71f
    mint -> to: 0xc1151bB67be20dF2BFf4DF56eDdE14792c9bd71f amount: 200
    balanceOf -> account: 0xc1151bB67be20dF2BFf4DF56eDdE14792c9bd71f

Na conta do BACEN - Dar autorização para o Banco B
Real digital
    enableAccount -> member: 0x428DB28A374339c04643BAC897c5C4D25183d050

Na conta do BACEN - Dar role de BURNER_ROLE para o contrato do SwapOneStep
Real tokenizado A
    grantRole -> role: 0x3c11d16cbaffd01df69ce1c404f6340ee057498f5f00246190ea54220576a848 
                account: 0xDc0abAED9776AB132Ff106819a130a06518636CF

Na conta do BACEN - Dar role de MINTER_ROLE para o contrato do SwapOneStep
Real tokenizado B
    grantRole -> role: 0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6
                account: 0xDc0abAED9776AB132Ff106819a130a06518636CF
    
Na conta do BANCO B - Dar autorização para o CLIENTE B
Real tokenizado B
    enableAccount -> member: 0x755A99f3351224d6E3ad318F834EB9336a7C43cb

Na conta do BANCO A - Dar Allowance para o contrato do SwapOneStep
Real digital
    increaseAllowance -> 
        spender: 0xDc0abAED9776AB132Ff106819a130a06518636CF
        addedValue: 200

Na conta do CLIENTE A - Dar role approve para o contrato do SwapOneStep
Real tokenizado A
    approve -> apender: 0xDc0abAED9776AB132Ff106819a130a06518636CF
                amount: 200

Na conta do CLIENTE A - Fazer o executeSwap no SwapOneStep
SwapOneStep
    executeSwap -> 
        tokenSender: 0x0195d58acf9BE0Ed19CD464E199649577Aa4FA4b
        tokenReceiver: 0x0F6416BE50CA14B62cC2B56dc1cf95c8FAE3806C
        receiver: 0x755A99f3351224d6E3ad318F834EB9336a7C43cb
        amount: 200
        
    executeSwap txhash: 0x4730deafa3cf4ce0ea16704bdfc70392a78fa8f906aa451ac19420c4b226dc00



