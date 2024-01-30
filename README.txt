REMIX DEFAULT WORKSPACE

Remix default workspace is present when:
i. Remix loads for the very first time 
ii. A new workspace is created with 'Default' template
iii. There are no files existing in the File Explorer

This workspace contains 3 directories:

1. 'contracts': Holds three contracts with increasing levels of complexity.
2. 'scripts': Contains four typescript files to deploy a contract. It is explained below.
3. 'tests': Contains one Solidity test file for 'Ballot' contract & one JS test file for 'Storage' contract.

SCRIPTS

The 'scripts' folder has four typescript files which help to deploy the 'Storage' contract using 'web3.js' and 'ethers.js' libraries.

For the deployment of any other contract, just update the contract's name from 'Storage' to the desired contract and provide constructor arguments accordingly 
in the file `deploy_with_ethers.ts` or  `deploy_with_web3.ts`

In the 'tests' folder there is a script containing Mocha-Chai unit tests for 'Storage' contract.

To run a script, right click on file name in the file explorer and click 'Run'. Remember, Solidity file must already be compiled.
Output from script will appear in remix terminal.

Please note, require/import is supported in a limited manner for Remix supported modules.
For now, modules supported by Remix are ethers, web3, swarmgw, chai, multihashes, remix and hardhat only for hardhat.ethers object/plugin.
For unsupported modules, an error like this will be thrown: '<module_name> module require is not supported by Remix IDE' will be shown.


carteiras
Karin 7comm: 0x3143ad917c67d260821e6E3b255E50b876f3791B
karin 2: 0x07afAba94d0bF15fD51a00Bc12dc5eb69b4a01D5
karin 3: 0xb63a9D1E33d38126a54199EC6C30eED1A159A7B2j

TOKENS address
PIX: 0x1157BEBDA9A67F5298513eCB382EAC410504f8F4
TYF: 0xBb04A3071b24270574Bae76eFECE74bbEFb0f41B
TYF2: 0xd301AED718042ADdCAcb64B6a9d726347e2f85ed
K7: 0xA400546372dfEf723a489c48b365771b3b76f1ce
KARIN7: 0xE2A696b7b2EC82bA261B26a42bEC26F8af87CDaC

NFT address
MyToken.sol: 0x99681d5288Ae8703233bdE3112eE0d2117457972

Desafio exchange
com status: 0xe8D889873327c74DB92f839E9d7AF736Ab315427
sem status: 0x6bDc50587A6725ee1954fD1033a87bdFb9EB5431

Casa de cambio
0xAFC1B0Bb12F032e4Fd56849DA932e1F98Be5098c

NFT
https://github.com/karindoy/minternft/