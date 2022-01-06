// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract WarlandsChest2  {
    string public name = "Warlands Presale Chests 2";
    uint256 public SilverCost = 0.1 ether;
    uint256 public GoldCost = 0.3 ether;
    uint256 public DiamondCost = 1.65 ether;
    uint256 public totalSilverMinted = 80;
    uint256 public totalGoldMinted = 115;
    uint256 public totalDiamondMinted = 150;
    
    event boughtChest(address indexed _from, uint256 cost); 
    event withdrawing(address indexed _from,address indexed _to, uint256 withdrawAmount); 
    
    modifier shouldPay(uint256 _cost) {
        require(msg.value >= _cost, "The chest costs more!");
        _;
    }
    modifier onlyOwner(){
            require(msg.sender == owner, "Only owner can access this!");
            _;
        }

function setTotalSilverMinted(uint newSilverMintedCount) public onlyOwner
    {
        totalSilverMinted = newSilverMintedCount;
    }
    function setTotalGoldMinted(uint newGoldMintedCount) public onlyOwner
    {
        totalGoldMinted = newGoldMintedCount;
    }
    function setTotalDiamondMinted(uint newDiamondMintedCount) public onlyOwner
    {
        totalDiamondMinted = newDiamondMintedCount;
    }


        function setSilverChestPrice(uint newSilverChest) public onlyOwner
    {
        SilverCost = newSilverChest;
    }
    function setGoldChestPrice(uint newGoldChest) public onlyOwner
    {
        GoldCost = newGoldChest;
    }
    function setDiamondChestPrice(uint newDiamondChest) public onlyOwner
    {
        DiamondCost = newDiamondChest;
    }


    function BuySilverChest() payable external shouldPay(SilverCost) {
        emit boughtChest(msg.sender, SilverCost);
        totalSilverMinted++;
    }
    function BuyGoldChest() payable external shouldPay(GoldCost) {
        emit boughtChest(msg.sender, GoldCost);
        totalGoldMinted++;
    }
    function BuyDiamondChest() payable external shouldPay(DiamondCost) {
        emit boughtChest(msg.sender, DiamondCost);
        totalDiamondMinted++;
    }
    function getFunds() public view onlyOwner returns(uint256)  {
        return address(this).balance;
    }
    address payable private owner;
    constructor() payable {
        owner = payable(msg.sender);
    }
    function Withdraw() public onlyOwner{
        uint amount = address(this).balance;
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send BNB");
        emit withdrawing(msg.sender, owner, amount);
    }
}