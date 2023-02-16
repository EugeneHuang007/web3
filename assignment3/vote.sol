pragma solidity >=0.5.1 <0.6.0;

contract FlawedVoting {
    // The remaining number of votes, stored for each user in a mapping
    mapping (address => uint256) public remainingVotes;

    // The list of candidates
    uint256[] public candidates;

    // The owner of the contract
    address owner;

    // The flag indicating whether the voting has ended
    bool hasEnded = false;

    // The modifier restricting the function call when voting has not ended
    modifier notEnded() {
        require(!hasEnded);
        _;
    }

    // The constructor initializes the list of candidates
    constructor(uint256 amountOfCandidates) public {
        candidates.length = amountOfCandidates;
        owner = msg.sender;
    }

    // The function for buying votes. At least 1 ETH is required to buy votes
    function buyVotes() public payable notEnded {
        require(msg.value >= 1 ether);
        remainingVotes[msg.sender] += msg.value / 1e18;
        msg.sender.transfer(msg.value % 1e18);
    }

    // The function for voting, specifying the candidate ID and number of votes
    // function vote(uint256 _candidateID, uint256 _amountOfVotes) public notEnded {
    //     require(_candidateID < candidates.length);
    //     require(remainingVotes[msg.sender] - _amountOfVotes >= 0);
    //     remainingVotes[msg.sender] -= _amountOfVotes;
    //     candidates[_candidateID] += _amountOfVotes;
    // }
    function vote(uint256 _candidateID, uint256 _amountOfVotes) public notEnded {
        require(_candidateID < candidates.length);
        require(remainingVotes[msg.sender] >= _amountOfVotes); // check remaining votes
        candidates[_candidateID] += _amountOfVotes;
        remainingVotes[msg.sender] -= _amountOfVotes;
}

    // The function for payout votes, specifying the number of votes to be paid out
    // function payoutVotes(uint256 _amount) public notEnded {
    //     require(remainingVotes[msg.sender] >= _amount);
    //     msg.sender.transfer(_amount * 1e18);
    //     remainingVotes[msg.sender] -= _amount;
    // }
    function payoutVotes(uint256 _amount) public notEnded {
        require(remainingVotes[msg.sender] >= _amount); // check remaining votes
        remainingVotes[msg.sender] -= _amount;
        msg.sender.transfer(_amount * 1e18);
}

    // The function for ending the voting process, which can only be called by the owner of the contract
    function endVoting() public notEnded {
        require(msg.sender == owner);
        hasEnded = true;
        msg.sender.transfer(address(this).balance);
    }

    // The function for checking the balance, returning the balance in Ether
    function displayBalanceInEther() public view returns(uint256 balance) {
        uint balanceInEther = address(this).balance / 1e18;
        return balanceInEther;
    }
}
