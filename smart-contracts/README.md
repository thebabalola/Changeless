# Changeless Smart Contracts 🛡️

Smart contracts for **Changeless** - a decentralized governance protocol designed to ensure transparent, community-driven decision-making and fund management.

## 📋 Overview

Changeless empowers community members to propose, vote, and execute treasury actions securely—removing the need for centralized control. Built with Solidity, it provides a trustless governance system where all decisions are transparent and executed on-chain.

## ✨ Features

- **📝 Proposal Creation**: Members can create proposals with executable on-chain actions
- **🗳️ Voting System**: Support for For, Against, and Abstain votes
- **⚡ Proposal Execution**: Approved proposals automatically execute on-chain actions
- **💰 Treasury Management**: Secure deposit and withdrawal of funds with governance controls
- **👥 Member Management**: Add/remove members and manage voting power
- **🔒 Security**: Quorum thresholds, voting periods, and access controls

## 🧰 Tech Stack

- **Language**: Solidity ^0.8.28
- **Framework**: Hardhat
- **Test Framework**: Hardhat Network (EDR)
- **Networks Supported**: 
  - Sepolia Testnet (default)
  - Mainnet
  - Arbitrum
  - Optimism
  - Polygon
  - Base
  - And more...

## 📦 Installation

1. Install dependencies:

```bash
npm install
```

2. Create a `.env` file:

```env
ACCOUNT_PRIVATE_KEY=your_private_key_here
ALCHEMY_API_KEY=your_alchemy_api_key
ETHERSCAN_V2_API_KEY=your_etherscan_api_key
```

## 🚀 Usage

### Compile Contracts

```bash
npx hardhat compile
```

### Run Tests

```bash
npx hardhat test
```

### Deploy to Network

```bash
npx hardhat run scripts/deploy.ts --network sepolia
```

## 📄 Contract Overview

### Changeless.sol

The main governance contract with the following features:

#### Core Functions

- `initialize()` - Initialize the governance contract with parameters
- `propose()` - Create a new proposal with executable actions
- `castVote()` - Vote on a proposal (For/Against/Abstain)
- `execute()` - Execute an approved proposal
- `cancel()` - Cancel a proposal (proposer or owner)

#### Member Management

- `addMember()` - Add a new member with voting power
- `updateMemberVotingPower()` - Update member's voting power
- `removeMember()` - Remove a member

#### Treasury Management

- `depositTreasury()` - Deposit ETH into the treasury
- `withdrawTreasury()` - Withdraw from treasury (owner only, typically via governance)

#### View Functions

- `getProposal()` - Get full proposal details
- `getVote()` - Check voter's vote status
- `getProposalStatus()` - Get human-readable proposal status
- `proposalPassed()` - Check if proposal passed voting

## 🎯 Governance Flow

1. **Proposal Creation**: Member creates a proposal with:
   - Title and description
   - Target addresses for execution
   - Values (ETH amounts)
   - Calldata for function calls

2. **Voting Period**: After a delay, voting opens for a specified period
   - Members vote For (1), Against (0), or Abstain (2)
   - Votes are weighted by member voting power

3. **Execution**: If proposal passes:
   - Meets quorum threshold
   - More For votes than Against votes
   - Voting period has ended
   - Proposal can be executed, performing the on-chain actions

## 🔐 Security Features

- **Access Controls**: Only members can create proposals and vote
- **Voting Periods**: Enforced voting delays and periods
- **Quorum Checking**: Minimum participation required
- **Proposal Threshold**: Minimum voting power to create proposals
- **Safe Execution**: Reverts on failed transactions

## 📊 Proposal States

- **Pending**: Created but voting not started
- **Active**: Voting is open
- **Defeated**: Voting ended but didn't pass
- **Executed**: Proposal was executed successfully
- **Canceled**: Proposal was canceled before voting

## 🧪 Testing

Run the test suite:

```bash
npx hardhat test
```

With coverage:

```bash
npx hardhat coverage
```

## 📝 Configuration

Edit `hardhat.config.ts` to:
- Add new networks
- Configure compiler settings
- Set up API keys

## 🚀 Deployment

### Local Network

```bash
npx hardhat node
```

### Test Network

```bash
npx hardhat run scripts/deploy.ts --network sepolia
```

### Mainnet

```bash
npx hardhat run scripts/deploy.ts --network mainnet
```

## 📚 Contract Structure

```
contracts/
└── Changeless.sol       # Main governance contract

scripts/
└── deploy.ts           # Deployment script

test/
└── Changeless.test.ts # Test suite
```

## 🔗 Links

- [Hardhat Documentation](https://hardhat.org/docs)
- [Solidity Documentation](https://docs.soliditylang.org)
- [Ethereum.org](https://ethereum.org)

## 📄 License

MIT
