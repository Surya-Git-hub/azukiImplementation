// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract testAzuki is ERC721A, Ownable {
    uint256 MAX_MINTS = 10000000000000;
    uint256 MAX_SUPPLY = 1000000000000000;

    string public baseURI = "abc.com";

    constructor() ERC721A("testAzuki", "ta") {}

    function mint(uint256 quantity) external  {
        require(quantity + _numberMinted(msg.sender) <= MAX_MINTS, "Exceeded the limit");
        require(totalSupply() + quantity <= MAX_SUPPLY, "Not enough tokens left");
        _safeMint(msg.sender, quantity);
    }

    function withdraw() external payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}
