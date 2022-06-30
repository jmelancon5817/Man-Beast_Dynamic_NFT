// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// Chainlink Imports
// This import includes functions from both ./KeeperBase.sol and
// ./interfaces/KeeperCompatibleInterface.sol
import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";

// Dev imports
import "hardhat/console.sol";


contract ManBeast is ERC721, ERC721Enumerable, ERC721URIStorage, KeeperCompatibleInterface, Ownable  {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    
    /**
    * Use an interval in seconds and a timestamp to slow execution of Upkeep
    */
    uint public /* immutable */ interval; 
    uint public lastTimeStamp;
    
    // IPFS URIs for the dynamic nft graphics/metadata.
    string[] IpfsUri = [
        "https://ipfs.io/ipfs/QmNUEW668hPgjeE2bHDLduhJaUQtVGMkhmCLaxSPjEho7n?filename=DayWalker.json",
        "https://ipfs.io/ipfs/QmWbiENyj7U3KTC69fgaGDs1DzDRB63QfLY3LCMX7QWX1h?filename=Beast.json"
    ];

    constructor(uint updateInterval) ERC721("Man&Beast", "MBTK") {
        // Set the keeper update interval
        interval = updateInterval; 
        lastTimeStamp = block.timestamp;  //  seconds since unix epoch
    }

    function safeMint(address to) public  {
        // Current counter value will be the minted token's token ID.
        uint256 tokenId = _tokenIdCounter.current();

        // Increment it so next time it's correct when we call .current()
        _tokenIdCounter.increment();

        // Mint the token
        _safeMint(to, tokenId);

        // Default to a human NFT
        string memory defaultUri = IpfsUri[0];
        _setTokenURI(tokenId, defaultUri);

        console.log("DONE!!! minted token ", tokenId, " and assigned token url: ", defaultUri);
    }

    function checkUpkeep(bytes calldata /* checkData */) external view override returns (bool upkeepNeeded, bytes memory /*performData */) {
         upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;

    }

    function performUpkeep(bytes calldata /* performData */ ) external override {
        if ((block.timestamp - lastTimeStamp) > interval ) {
            lastTimeStamp = block.timestamp;
            morph(0);        
        } 
    }

    // Helpers
  
    function morph(uint256 _tokenId) public {
        if (currentForm(_tokenId) == 0) {
            uint newVal = currentForm(_tokenId) + 1;
            string memory newUri = IpfsUri[newVal];
            _setTokenURI(_tokenId, newUri);
            
            
        } else {     
            uint newVal = currentForm(_tokenId) - 1;
            string memory newUri = IpfsUri[newVal];
            _setTokenURI(_tokenId, newUri);
            } 
         
    }

    function currentForm(uint256 _tokenId) public view returns (uint256) {
        string memory _uri = tokenURI(_tokenId);
        // Man
        if (compareStrings(_uri, IpfsUri[0])) {
            return 0;
        }

        // Beast
        return 1;
    }

    function setInterval(uint256 newInterval) public onlyOwner {
        interval = newInterval;
    }
    

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }


    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
}
