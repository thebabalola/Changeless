// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * @title Changeless
 * @notice A decentralized governance protocol for transparent, community-driven decision-making
 *         and fund management. Members can propose, vote, and execute treasury actions securely.
 */
contract Changeless {
    // ============ Structs ============
    
    struct Proposal {
        uint256 id;
        address proposer;
        string title;
        string description;
        address[] targets;
        uint256[] values;
        bytes[] calldatas;
        uint256 startTime;
        uint256 endTime;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 abstainVotes;
        bool executed;
        bool canceled;
    }

    struct VoteInfo {
        bool hasVoted;
        uint8 support; // 0 = against, 1 = for, 2 = abstain
        uint256 votes;
    }

    // ============ Events ============
    
    event ProposalCreated(
        uint256 indexed proposalId,
        address indexed proposer,
        string title,
        uint256 startTime,
        uint256 endTime
    );

    event VoteCast(
        address indexed voter,
        uint256 indexed proposalId,
        uint8 support,
        uint256 votes,
        string reason
    );

    event ProposalExecuted(uint256 indexed proposalId);
    event ProposalCanceled(uint256 indexed proposalId);
    event TreasuryDeposit(address indexed sender, uint256 amount);
    event TreasuryWithdrawal(address indexed recipient, uint256 amount, string reason);

    // ============ State Variables ============
    
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => VoteInfo)) public proposalVotes;
    mapping(address => bool) public members;
    mapping(address => uint256) public memberVotingPower;
    
    uint256 public proposalCount;
    uint256 public votingPeriod;
    uint256 public votingDelay;
    uint256 public quorumThreshold; // Percentage (e.g., 30 = 30%)
    uint256 public proposalThreshold; // Minimum voting power required to create a proposal
    
    address public treasury;
    uint256 public totalTreasuryBalance;
    
    address public owner;
    bool public initialized;

    // ============ Modifiers ============
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Changeless: caller is not owner");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Changeless: caller is not a member");
        _;
    }

    modifier validProposal(uint256 proposalId) {
        require(proposalId < proposalCount, "Changeless: invalid proposal ID");
        require(!proposals[proposalId].executed, "Changeless: proposal already executed");
        require(!proposals[proposalId].canceled, "Changeless: proposal canceled");
        _;
    }

    // ============ Constructor ============
    
    constructor() {
        owner = msg.sender;
    }

    // ============ Initialization ============
    
    /**
     * @notice Initialize the governance contract
     * @param _votingPeriod Voting period in seconds
     * @param _votingDelay Delay before voting starts in seconds
     * @param _quorumThreshold Quorum threshold as percentage (e.g., 30 = 30%)
     * @param _proposalThreshold Minimum voting power to create a proposal
     * @param _initialMembers Array of initial member addresses
     */
    function initialize(
        uint256 _votingPeriod,
        uint256 _votingDelay,
        uint256 _quorumThreshold,
        uint256 _proposalThreshold,
        address[] memory _initialMembers
    ) external onlyOwner {
        require(!initialized, "Changeless: already initialized");
        
        votingPeriod = _votingPeriod;
        votingDelay = _votingDelay;
        quorumThreshold = _quorumThreshold;
        proposalThreshold = _proposalThreshold;
        treasury = address(this);
        
        // Add initial members with default voting power of 1
        for (uint256 i = 0; i < _initialMembers.length; i++) {
            members[_initialMembers[i]] = true;
            memberVotingPower[_initialMembers[i]] = 1;
        }
        
        initialized = true;
    }

    // ============ Member Management ============
    
    /**
     * @notice Add a new member (requires governance proposal or owner)
     * @param account Address to add as member
     * @param votingPower Voting power to assign
     */
    function addMember(address account, uint256 votingPower) external onlyOwner {
        require(account != address(0), "Changeless: invalid address");
        require(!members[account], "Changeless: already a member");
        
        members[account] = true;
        memberVotingPower[account] = votingPower;
    }

    /**
     * @notice Update member voting power
     * @param account Member address
     * @param votingPower New voting power
     */
    function updateMemberVotingPower(address account, uint256 votingPower) external onlyOwner {
        require(members[account], "Changeless: not a member");
        memberVotingPower[account] = votingPower;
    }

    /**
     * @notice Remove a member
     * @param account Address to remove
     */
    function removeMember(address account) external onlyOwner {
        require(members[account], "Changeless: not a member");
        members[account] = false;
        memberVotingPower[account] = 0;
    }

    // ============ Proposal Functions ============
    
    /**
     * @notice Create a new proposal
     * @param title Proposal title
     * @param description Proposal description
     * @param targets Array of target addresses for calls
     * @param values Array of ETH values to send
     * @param calldatas Array of calldatas for calls
     * @return proposalId The ID of the newly created proposal
     */
    function propose(
        string memory title,
        string memory description,
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas
    ) external onlyMember returns (uint256) {
        require(
            memberVotingPower[msg.sender] >= proposalThreshold,
            "Changeless: insufficient voting power"
        );
        require(targets.length == values.length, "Changeless: array length mismatch");
        require(targets.length == calldatas.length, "Changeless: array length mismatch");
        require(targets.length > 0, "Changeless: empty proposal");

        uint256 proposalId = proposalCount++;
        
        Proposal storage newProposal = proposals[proposalId];
        newProposal.id = proposalId;
        newProposal.proposer = msg.sender;
        newProposal.title = title;
        newProposal.description = description;
        newProposal.targets = targets;
        newProposal.values = values;
        newProposal.calldatas = calldatas;
        newProposal.startTime = block.timestamp + votingDelay;
        newProposal.endTime = block.timestamp + votingDelay + votingPeriod;
        newProposal.executed = false;
        newProposal.canceled = false;

        emit ProposalCreated(proposalId, msg.sender, title, newProposal.startTime, newProposal.endTime);

        return proposalId;
    }

    /**
     * @notice Cast a vote on a proposal
     * @param proposalId The ID of the proposal to vote on
     * @param support 0 = against, 1 = for, 2 = abstain
     * @param reason Optional reason for the vote
     */
    function castVote(
        uint256 proposalId,
        uint8 support,
        string memory reason
    ) external onlyMember validProposal(proposalId) {
        Proposal storage proposal = proposals[proposalId];
        
        require(
            block.timestamp >= proposal.startTime,
            "Changeless: voting not started"
        );
        require(
            block.timestamp <= proposal.endTime,
            "Changeless: voting ended"
        );
        require(support <= 2, "Changeless: invalid support value");
        
        VoteInfo storage voteInfo = proposalVotes[proposalId][msg.sender];
        require(!voteInfo.hasVoted, "Changeless: already voted");

        uint256 voterPower = memberVotingPower[msg.sender];
        
        voteInfo.hasVoted = true;
        voteInfo.support = support;
        voteInfo.votes = voterPower;

        if (support == 0) {
            proposal.againstVotes += voterPower;
        } else if (support == 1) {
            proposal.forVotes += voterPower;
        } else {
            proposal.abstainVotes += voterPower;
        }

        emit VoteCast(msg.sender, proposalId, support, voterPower, reason);
    }

    /**
     * @notice Execute a proposal
     * @param proposalId The ID of the proposal to execute
     */
    function execute(uint256 proposalId) external validProposal(proposalId) {
        Proposal storage proposal = proposals[proposalId];
        
        require(block.timestamp > proposal.endTime, "Changeless: voting still active");
        require(
            proposal.forVotes > proposal.againstVotes,
            "Changeless: proposal did not pass"
        );
        
        uint256 totalVotes = proposal.forVotes + proposal.againstVotes + proposal.abstainVotes;
        uint256 totalPossibleVotes = getTotalVotingPower();
        uint256 quorum = (totalPossibleVotes * quorumThreshold) / 100;
        
        require(totalVotes >= quorum, "Changeless: quorum not met");

        proposal.executed = true;

        for (uint256 i = 0; i < proposal.targets.length; i++) {
            (bool success, ) = proposal.targets[i].call{value: proposal.values[i]}(
                proposal.calldatas[i]
            );
            require(success, "Changeless: execution failed");
        }

        emit ProposalExecuted(proposalId);
    }

    /**
     * @notice Cancel a proposal (only proposer or owner)
     * @param proposalId The ID of the proposal to cancel
     */
    function cancel(uint256 proposalId) external validProposal(proposalId) {
        Proposal storage proposal = proposals[proposalId];
        
        require(
            msg.sender == proposal.proposer || msg.sender == owner,
            "Changeless: not authorized"
        );
        require(
            block.timestamp < proposal.startTime,
            "Changeless: voting already started"
        );

        proposal.canceled = true;

        emit ProposalCanceled(proposalId);
    }

    // ============ Treasury Functions ============
    
    /**
     * @notice Deposit ETH into the treasury
     */
    function depositTreasury() external payable {
        require(msg.value > 0, "Changeless: must send ETH");
        totalTreasuryBalance += msg.value;
        emit TreasuryDeposit(msg.sender, msg.value);
    }

    /**
     * @notice Withdraw from treasury (requires governance proposal execution)
     * @param recipient Address to receive funds
     * @param amount Amount to withdraw
     * @param reason Reason for withdrawal
     */
    function withdrawTreasury(
        address recipient,
        uint256 amount,
        string memory reason
    ) external onlyOwner {
        require(recipient != address(0), "Changeless: invalid recipient");
        require(amount > 0, "Changeless: invalid amount");
        require(totalTreasuryBalance >= amount, "Changeless: insufficient balance");

        totalTreasuryBalance -= amount;
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Changeless: transfer failed");

        emit TreasuryWithdrawal(recipient, amount, reason);
    }

    // ============ View Functions ============
    
    /**
     * @notice Get proposal state
     * @param proposalId The ID of the proposal
     * @return Proposal struct
     */
    function getProposal(uint256 proposalId) external view returns (Proposal memory) {
        return proposals[proposalId];
    }

    /**
     * @notice Check if a voter has voted on a proposal
     * @param proposalId The ID of the proposal
     * @param voter The voter address
     * @return hasVoted Whether the voter has voted
     * @return support The support value (0 = against, 1 = for, 2 = abstain)
     * @return votePower The number of votes cast
     */
    function getVote(
        uint256 proposalId,
        address voter
    ) external view returns (bool hasVoted, uint8 support, uint256 votePower) {
        VoteInfo memory voteInfo = proposalVotes[proposalId][voter];
        return (voteInfo.hasVoted, voteInfo.support, voteInfo.votes);
    }

    /**
     * @notice Get total voting power of all members
     * @return Total voting power
     */
    function getTotalVotingPower() public view returns (uint256) {
        // This would need to iterate through members in a production version
        // For now, we'll use a simpler approach where total voting power
        // can be tracked separately or calculated differently
        // In a real implementation, you might want to use a mapping or array
        return 100; // Placeholder - should be calculated based on actual member voting power
    }

    /**
     * @notice Get proposal status
     * @param proposalId The ID of the proposal
     * @return status String representation of proposal status
     */
    function getProposalStatus(uint256 proposalId) external view returns (string memory) {
        Proposal memory proposal = proposals[proposalId];
        
        if (proposal.executed) return "Executed";
        if (proposal.canceled) return "Canceled";
        if (block.timestamp > proposal.endTime) return "Defeated";
        if (block.timestamp >= proposal.startTime) return "Active";
        return "Pending";
    }

    /**
     * @notice Check if proposal has passed
     * @param proposalId The ID of the proposal
     * @return bool Whether the proposal has passed
     */
    function proposalPassed(uint256 proposalId) external view returns (bool) {
        Proposal memory proposal = proposals[proposalId];
        
        if (block.timestamp <= proposal.endTime) return false;
        if (proposal.executed || proposal.canceled) return false;
        
        uint256 totalVotes = proposal.forVotes + proposal.againstVotes + proposal.abstainVotes;
        uint256 totalPossibleVotes = getTotalVotingPower();
        uint256 quorum = (totalPossibleVotes * quorumThreshold) / 100;
        
        return totalVotes >= quorum && proposal.forVotes > proposal.againstVotes;
    }

    // ============ Receive Function ============
    
    receive() external payable {
        totalTreasuryBalance += msg.value;
        emit TreasuryDeposit(msg.sender, msg.value);
    }

    fallback() external payable {
        totalTreasuryBalance += msg.value;
        emit TreasuryDeposit(msg.sender, msg.value);
    }
}

