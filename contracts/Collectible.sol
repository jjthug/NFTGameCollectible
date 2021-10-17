//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract Collectible is ERC721 {

    struct Item{
        uint256 id;
        uint256 blockNumber;
    }

    uint256 public tokenCounter;
    enum Breed{PUG, SHIBA_INU, ST_BERNARD}
    // add other things
    mapping(bytes32 => address) public requestIdToSender;
    mapping(bytes32 => string) public requestIdToTokenURI;
    mapping(uint256 => Breed) public tokenIdToBreed;
    mapping(bytes32 => uint256) public requestIdToTokenId;
    event requestedCollectible(bytes32 indexed requestId);

    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    bytes32 internal keyHash;
    uint256 internal fee;
    
    constructor()
    public 
    ERC721("Greek Mythological Weapons", "GMP")
    {

    }


    function _mint(address to, uint256 tokenId) internal override {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    function _completeMint(uint256 tokenId) external {
        require(_owns(tokenId, msg.sender));
    }

    function _owns(uint256 tokenId, address sender) internal{
        require(_owners(tokenId) == sender, "Not the owner of the collectible");
    }
}