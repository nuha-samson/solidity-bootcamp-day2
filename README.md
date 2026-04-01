# TokenRegistry Contract

## 📝 What This Contract Does

A blockchain-based registry that stores tokens with names, symbols, owners, and active status. Think of it as a simple database for cryptocurrencies or digital assets on the blockchain.

## 🔧 What I Built

### Data Structure
- **Token Struct**: Holds name, symbol, owner address, and active status
- **Mapping**: Stores tokens by unique ID for fast lookup
- **Array**: Tracks all token IDs so I can list them

### Functions

| Function | What It Does | Who Can Use It |
|----------|--------------|----------------|
| `registerToken(name, symbol)` | Creates a new token with auto-incremented ID | Anyone |
| `deactivateToken(id)` | Marks a token as inactive | Only the token owner |
| `getToken(id)` | Returns all info about a token | Anyone (read-only) |
| `getAllTokenIds()` | Returns array of all registered IDs | Anyone |
| `getTotalTokens()` | Returns total number of tokens | Anyone |

## 🧪 How I Tested It

1. **Deployed** on Remix VM (Cancun)
2. **Registered** two tokens:
   - Token 1: "Ethereum" with symbol "ETH"
   - Token 2: "Bitcoin" with symbol "BTC"
3. **Verified** both appeared in `getAllTokenIds()` → `[1, 2]`
4. **Retrieved** Token 1 info → name: Ethereum, symbol: ETH, owner: my address, isActive: true
5. **Deactivated** Token 1 → only owner could do this
6. **Confirmed** Token 1 is now inactive → isActive: false
7. **Tested security** → another account couldn't deactivate Token 1

## 🎯 What I Learned

### Mappings vs Arrays
- **Mappings** = fast lookup by key (like Python dict)
- **Arrays** = ability to iterate through all items
- In Solidity, you need BOTH because you can't loop through a mapping

### Memory vs Storage
- `memory` = temporary data that disappears after function ends
- `storage` = permanent data on the blockchain
- Strings and arrays need explicit location declarations

### msg.sender
- Automatically the address calling the function
- No need to pass "current user" as parameter
- Used for ownership and permissions

### require()
- Validates conditions before executing
- If condition fails, transaction reverts
- Gas is refunded (except for used computation)

## 💡 Challenges I Faced

1. **Understanding why mapping and array together** - Realized mappings can't be iterated
2. **Memory keyword** - Forgot to add it to string parameters at first
3. **String validation** - `bytes(name).length != 0` to check empty strings
4. **Token existence check** - Needed `id > 0 && id < nextTokenId` since IDs start at 1
