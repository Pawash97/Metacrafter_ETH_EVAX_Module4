// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DegenToken is ERC20, Ownable {
    constructor() ERC20("DEGEN", "DEG") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() override public pure returns(uint8){
        return 0;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount must be greater than zero");
        return super.transfer(recipient, amount);
    }

    function storeItems() public pure returns(string[] memory) {
        string[] memory strings = new string[](3);
        strings[0] = "DEGEN NFT";
        strings[1] = "Coupon code";
        strings[2] = "Tshirt";
        return strings;
    }

    struct RedemptionOption {
        string tokenId;
        uint256 tokenAmount;
        uint256 option;
    }

    mapping(address => RedemptionOption) public redemptionOptions;

    function redeem(uint256 option) public {
        require(option >= 1 && option <= 3, "Invalid option");

        if (option == 1) {
            require(balanceOf(msg.sender) >= 100, "Insufficient tokens");
            _burn(msg.sender, 100);
            string memory tokenId = "DEGEN NFT";
            redemptionOptions[msg.sender] = RedemptionOption(tokenId, 1, option);
        } 
        else if (option == 2) {
            require(balanceOf(msg.sender) >= 150, "Insufficient tokens");
            _burn(msg.sender, 150);
            string memory tokenId = "Coupon code";
            redemptionOptions[msg.sender] = RedemptionOption(tokenId, 1,option);
        } 
        else if (option == 3) {
            require(balanceOf(msg.sender) >= 200, "Insufficient tokens");
            _burn(msg.sender, 200);
            string memory tokenId = "T-Shirt";
            redemptionOptions[msg.sender] = RedemptionOption(tokenId, 1,option);
        }
    }


    function burn(uint256 amount) public {
        uint256 balance = balanceOf(msg.sender);
        require(balance >= amount, "Insufficient balance");

        _burn(msg.sender, amount);
    }

    function balanceOf(address account) public view override returns (uint) {
        return super.balanceOf(account);
    }
}