// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
//pragma solidity ^0.5.7;



contract Will {  
    address owner;
    uint  fortune;  
    bool isDeceased;

    constructor() payable  {
        owner = msg.sender; // msg sender represents address that is being called
        fortune = msg.value; // msg value represents address that is being sent
        isDeceased = false;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased {
        require(isDeceased == true);
        _;
    }

    //list of family wallets
    address payable[] familyWallets;

    //map through inheritance
    mapping(address => uint) inheritance;

    //set inheritance for each address

    function setInheritance(address payable _wallet, uint _amount) public onlyOwner{
        familyWallets.push(_wallet);
        inheritance[_wallet] = _amount;
    }

    //pay each family member based on heir wallet address

    function payout() private mustBeDeceased {
        for(uint i = 0; i < familyWallets.length; i++) {
           familyWallets[i].transfer(inheritance[familyWallets[i]]) ;
        } 
       
    }

    function deceased() public onlyOwner {
        isDeceased = true;
        payout();
    }

       
}

