// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenRegistry {
    // 1. Define the Token struct
    struct Token {
        string name;
        string symbol;
        address owner;
        bool isActive;
    }
    
    // 2. Storage: mapping and array
    mapping(uint256 => Token) public tokens;
    uint256[] public tokenIds;
    
    // Auto-increment counter (starts at 1)
    uint256 private nextTokenId = 1;
    
    // Bonus: Event for when tokens are registered
    event TokenRegistered(uint256 indexed tokenId, string name, string symbol, address owner);
    
    // 4a. Register a new token
    function registerToken(string memory name, string memory symbol) public {
        // Bonus: Validate inputs
        require(bytes(name).length > 0, "Name cannot be empty");
        require(bytes(symbol).length > 0, "Symbol cannot be empty");
        
        // Create token struct
        Token memory newToken = Token({
            name: name,
            symbol: symbol,
            owner: msg.sender,
            isActive: true
        });
        
        // Store in mapping
        tokens[nextTokenId] = newToken;
        
        // Track in array
        tokenIds.push(nextTokenId);
        
        // Emit event
        emit TokenRegistered(nextTokenId, name, symbol, msg.sender);
        
        // Increment for next token
        nextTokenId++;
    }
    
    // 4b. Deactivate a token (only owner)
    function deactivateToken(uint256 id) public {
        // Check token exists
        require(id < nextTokenId, "Token does not exist");
        
        Token storage token = tokens[id];
        
        // Only owner can deactivate
        require(token.owner == msg.sender, "Only owner can deactivate");
        
        // Deactivate
        token.isActive = false;
    }
    
    // 4c. Get token info
    function getToken(uint256 id) public view returns (string memory, string memory, address, bool) {
        require(id < nextTokenId, "Token does not exist");
        
        Token memory token = tokens[id];
        return (token.name, token.symbol, token.owner, token.isActive);
    }
    
    // 4d. Get all token IDs
    function getAllTokenIds() public view returns (uint256[] memory) {
        return tokenIds;
    }
}