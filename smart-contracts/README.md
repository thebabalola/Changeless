# BlockTacToe 🎮 – Smart Contracts

A fully decentralized, peer-to-peer Tic Tac Toe game built on Ethereum with ETH betting functionality. Players can create games, join existing games, and compete for ETH rewards in a trustless, onchain environment.

## ✨ Features

- **🎯 PvP Gameplay:** Play against other players in real-time
- **💰 ETH Betting:** Bet ETH tokens on game outcomes
- **🏆 Winner Takes All:** Winner receives both players' bet amounts
- **🔒 Trustless:** All game logic and funds managed by smart contract
- **⚡ Fast Transactions:** Leverages Ethereum's fast block times
- **⏰ Timeout Protection:** Anti-griefing mechanism with forfeit system
- **🏆 Social Competition:** Winner celebration and challenge sharing system

Create/join/play flows for PvP Tic Tac Toe:
- Bets escrowed in contract; winner takes all
- Turn enforcement and move validation
- Automatic winner detection (3-in-a-row)
- Timeout/forfeit mechanism (anti-griefing)
- Read-only getters for UI rendering
- Events for off-chain indexing and realtime UI

## 🧰 Tech & Tooling

- **Language:** Solidity ^0.8.x
- **Framework:** Hardhat
- **Network:** Base Sepolia Testnet
- **Dependencies:** OpenZeppelin (ReentrancyGuard, helpers)

**Key Features:**
- Game creation with custom bet amounts
- Turn-based move validation
- Automatic winner detection
- ETH token transfers
- Multiple concurrent games support
- Timeout/forfeit mechanism
- Winner celebration and social sharing

## 🎯 Game Rules

1. **Board:** 3x3 grid with positions 0-8
2. **Moves:** Player 1 uses X (value 1), Player 2 uses O (value 2)
3. **Winning:** Three in a row (horizontal, vertical, or diagonal)
4. **Betting:** Both players must bet equal amounts
5. **Reward:** Winner receives both players' ETH
6. **Timeout:** 24-hour timeout per move, forfeit available after timeout

## 📁 Project Structure

```
smart-contracts/
├── contracts/
│   └── TicTacToe.sol
├── scripts/
│   ├── deploy.ts
│   └── verify.ts
├── test/
│   ├── TicTacToe.core.spec.ts
│   ├── TicTacToe.timeout.spec.ts
│   └── TicTacToe.security.spec.ts
└── hardhat.config.ts
```

## 🔧 Smart Contract Functions

### Public Functions

- `createGame(uint256 betAmount, uint8 moveIndex)` - Create new game with first move
- `joinGame(uint256 gameId, uint8 moveIndex)` - Join existing game
- `play(uint256 gameId, uint8 moveIndex)` - Make a move in ongoing game
- `forfeitGame(uint256 gameId)` - Forfeit game due to timeout

### Read-Only Functions

- `getGame(uint256 gameId)` - Get game details
- `getLatestGameId()` - Get total number of games created
- `getTimeRemaining(uint256 gameId)` - Get time remaining for current move

### Suggested Game Struct

```solidity
struct Game {
    address playerOne;
    address playerTwo;      // address(0) until joined
    uint256 betAmount;      // in wei
    uint8[9] board;         // 0=empty, 1=X, 2=O
    bool isPlayerOneTurn;   // true=>X turn
    address winner;         // address(0) until decided
    uint256 lastMoveTs;     // unix timestamp of last move
    // optional: status enum (Active, Ended, Forfeited)
}
```

## ⏰ Timeout / Forfeit Mechanism

- `lastMoveTs` updated on each valid move
- Constant threshold (e.g., 24h) enforced
- If opponent exceeds threshold, current player can call `forfeitGame` to end and withdraw
- Emits `GameForfeited(gameId, winner)` event

## 🔒 Security Features

- **Input Validation:** All moves validated for bounds and availability
- **Turn Enforcement:** Players can only move on their turn
- **Fund Security:** ETH locked in contract until game completion
- **Winner Verification:** Automatic winner detection prevents disputes
- **Timeout Protection:** Anti-griefing with forfeit mechanism
- **Reentrancy Protection:** Secure against reentrancy attacks

**Security Considerations:**
- Reentrancy protection on state-changing functions that transfer ETH
- Checks-Effects-Interactions pattern
- Input validation (bounds, empty cell, correct turn/move)
- Use of custom errors for gas-efficient revert reasons
- Pull over push for payouts (if adopting claim pattern)

## 📡 Events (for Indexers/UI)

- `GameCreated(gameId, playerOne, betAmount, moveIndex)`
- `GameJoined(gameId, playerTwo, moveIndex)`
- `MovePlayed(gameId, by, moveIndex)`
- `GameWon(gameId, winner, payout)`
- `GameForfeited(gameId, winner)`

## 🛠️ Development Setup

### Prerequisites

- Node.js 18+
- Hardhat
- Ethereum wallet for testing

### Smart Contract Development

```bash
# Navigate to contract directory
cd smart-contracts

# Install dependencies
npm install

# Run tests
npm test

# Deploy to testnet
npm run deploy:sepolia
```

## 🌐 Network Configuration

### Base Sepolia Testnet

- **RPC URL:** `https://sepolia.infura.io/v3/YOUR_PROJECT_ID` (or Base RPC)
- **Chain ID:** `11155111` (or Base Sepolia chain ID)
- **Contract:** `TBD` (To be deployed)

### Example .env

```
PRIVATE_KEY=0x...
RPC_URL=https://sepolia.infura.io/v3/<YOUR_PROJECT_ID>
ETHERSCAN_API_KEY=<YOUR_KEY>
```

## 🚀 Deployment

### Deploy to Base Sepolia

```bash
cd smart-contracts
npm run deploy:sepolia
```

### Deploy to Mainnet

```bash
cd smart-contracts
npm run deploy:mainnet
```

### Deploy with Verification

```bash
# Configure .env with PRIVATE_KEY, RPC_URL, ETHERSCAN_API_KEY
npm run deploy:sepolia
npm run verify:sepolia
```

## 🧪 Testing

The smart contract includes comprehensive tests covering:
- ✅ Game creation and joining
- ✅ Turn-based gameplay
- ✅ Move validation (bounds, occupied spots)
- ✅ Winner detection for both players
- ✅ Error handling for invalid operations
- ✅ Timeout and forfeit mechanisms

**Testing Details:**
- Core flow: create → join → play → win (X and O)
- Validation failures: out-of-bounds, occupied, wrong turn/move
- Timeout scenarios and forfeit edge cases
- Security tests: reentrancy, bad inputs, invariant checks

**Run tests:**
```bash
cd smart-contracts
npm test
```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Getting Started

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

### Development Guidelines

- Follow Solidity style guide
- Write comprehensive tests
- Update documentation
- Follow conventional commit messages
- Ensure all tests pass

### Reporting Issues

- Use the GitHub issue tracker
- Provide detailed reproduction steps
- Include environment information
- Add screenshots if applicable

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Built on the [Ethereum blockchain](https://ethereum.org/)
- Uses [Hardhat](https://hardhat.org/) for smart contract development
- Wallet integration via [MetaMask](https://metamask.io/)

## 🐛 Known Issues & Roadmap

### 🔥 High Priority Issues

#### Smart Contract Issues

- [ ] **Issue #1:** Core Smart Contract Implementation
  - [ ] Create `TicTacToe.sol` with basic game structure
  - [ ] Implement `createGame(uint256 betAmount, uint8 moveIndex)` function
  - [ ] Implement `joinGame(uint256 gameId, uint8 moveIndex)` function
  - [ ] Implement `play(uint256 gameId, uint8 moveIndex)` function
  - [ ] Add game data struct with player addresses, bet amount, board state
  - [ ] Implement winner detection logic (3-in-a-row validation)
  - [ ] Add move validation (bounds checking, empty cell validation)
  - [ ] Implement ETH transfer logic for betting and payouts
  - [ ] Add event emissions for game state changes
  - [ ] Create read-only functions `getGame()` and `getLatestGameId()`

- [ ] **Issue #2:** Timeout/Forfeit Mechanism Implementation
  - [ ] Add `lastMoveTimestamp` field to game struct
  - [ ] Implement 24-hour timeout constant and validation
  - [ ] Create `forfeitGame(uint256 gameId)` function
  - [ ] Add timeout checking logic in existing functions
  - [ ] Implement automatic forfeit detection
  - [ ] Add events for timeout and forfeit actions
  - [ ] Create `getTimeRemaining(uint256 gameId)` view function
  - [ ] Add modifier for timeout validation

- [ ] **Issue #3:** Security & Error Handling
  - [ ] Implement reentrancy protection using OpenZeppelin's ReentrancyGuard
  - [ ] Add comprehensive error messages with custom errors
  - [ ] Implement access control for game operations
  - [ ] Add input validation for all public functions
  - [ ] Implement proper state management (game status enum)
  - [ ] Add overflow protection for arithmetic operations
  - [ ] Create emergency pause functionality (if needed)

### 🔶 Medium Priority Issues

#### Smart Contract Issues

- [ ] **Issue #8:** Gas Optimization & Efficiency
  - [ ] Optimize storage layout to reduce gas costs
  - [ ] Implement batch operations where possible
  - [ ] Use packed structs to reduce storage slots
  - [ ] Optimize loop operations and array access
  - [ ] Implement efficient winner detection algorithm
  - [ ] Add gas estimation functions
  - [ ] Create gas-efficient deployment scripts
  - [ ] Implement upgradeable contract pattern (if needed)

- [ ] **Issue #9:** Advanced Contract Features
  - [ ] Add game statistics tracking (wins, losses, total games)
  - [ ] Implement player rating system
  - [ ] Create game history and replay functionality
  - [ ] Add tournament mode support
  - [ ] Implement spectator mode for ongoing games
  - [ ] Add game creation fees and platform revenue
  - [ ] Create referral system for new players
  - [ ] Implement multi-token support (ERC20 tokens)

### 🔵 Low Priority Issues

#### Smart Contract Issues

- [ ] **Issue #12:** Advanced Game Mechanics
  - [ ] Implement different game modes (timed, untimed, custom rules)
  - [ ] Add game difficulty levels
  - [ ] Create custom board sizes (4x4, 5x5)
  - [ ] Implement power-ups and special moves
  - [ ] Add team-based gameplay
  - [ ] Create seasonal events and limited-time modes
  - [ ] Implement game replay and analysis
  - [ ] Add AI opponent integration

- [ ] **Issue #13:** Governance & Decentralization
  - [ ] Implement DAO governance for game parameters
  - [ ] Create voting system for rule changes
  - [ ] Add community-driven feature requests
  - [ ] Implement decentralized dispute resolution
  - [ ] Create token-based governance system
  - [ ] Add community moderation tools
  - [ ] Implement reputation system for players
  - [ ] Create decentralized tournament management
