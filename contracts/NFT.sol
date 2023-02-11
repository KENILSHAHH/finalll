// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";


import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress;

    constructor(address marketplaceAddress) ERC721("Metaverse", "METT") {
        contractAddress = marketplaceAddress;
    }
     function transferFrom(address from, address to, uint256 tokenId) public {
    require(from != address(0), "Cannot transfer from the zero address.");
    require(to != address(0), "Cannot transfer to the zero address.");
    require(isApprovedOrOwner(msg.sender, tokenId), "Only approved or owner can transfer the token.");
    _transferFrom(from, to, tokenId);
  }
  function isApprovedOrOwner(address spender, uint256 tokenId) public view returns (bool) {
    address owner = ownerOf(tokenId);
    return owner == spender || getApproved(tokenId) == spender;
  }

    function createToken(string memory tokenURI) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }
}