// SPDX-License-Identifier: MIT
// Author : spikeyrock - nftit
// Contact : nftit@protonmail.com
// Discription : Payment system to recieve funds for Warlands.io "Chests"
//hexa 0.25 = 3782DACE9D90000
//hexa 0.65 = 905438E60010000
//hexa 1.65 = 16E5FA4207650000
//
//after deployment like previous time update contract abi with the new abi
//
//add the new deployed contract address to the file
//
//update the numbers to the current number of minted completed
//
//update number of total minted in the contract from old contract data
//
//update switch case in file
//update on front end where required 
//


pragma solidity =0.8.9;

contract WarlandsChest  {
    string public name = "Warlands Presale Chests";
    uint256 public SilverCost = 0.25 ether;
    uint256 public totalSilverMinted = ;
    uint256 public GoldCost = 0.65 ether;
    uint256 public totalGoldMinted = ;
    uint256 public DiamondCost = 1.65 ether;
    uint256 public totalDiamondMinted = ;
    
    event boughtChest(address indexed _from, uint256 cost); 
    modifier shouldPay(uint256 _cost) {
        require(msg.value >= _cost, "The chests cost more!");
        _;
    }
    function BuySilverChest() payable public shouldPay(SilverCost) {
        emit boughtChest(msg.sender, SilverCost);
        totalSilverMinted++;
    }
    function BuyGoldChest() payable public shouldPay(GoldCost) {
        emit boughtChest(msg.sender, GoldCost);
        totalGoldMinted++;
    }
    function BuyDiamondChest() payable public shouldPay(DiamondCost) {
        emit boughtChest(msg.sender, DiamondCost);
        totalDiamondMinted++;
    }
    function getFunds() public view returns(uint256) {
        return address(this).balance;
    }
    address payable public owner;
    constructor() payable {
        owner = payable(msg.sender);
    }
    function withdraw() public {
        uint amount = address(this).balance;
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

}