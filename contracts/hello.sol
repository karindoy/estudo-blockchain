// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Hello
 * @dev Hellowold
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Hello {

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "apenas o dono pode fazer essa operacao");
        _;
    }
    function hello() public view onlyOwner returns (string memory){
        return "Hello world karin";
    }


    function helloName(string memory name) public pure returns (string memory){
        return string.concat("Hello world ", name);
    }
}