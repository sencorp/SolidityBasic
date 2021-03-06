pragma solidity 0.4.11;

contract CrowdFund {

    address public beneficiary;
    uint public goal;
    uint public deadline;
    
    mapping(address => uint) funder;
    
    address[] totalFundersArr;
    
    event Contribution(uint _amount, uint _amountRemaining);

    function CrowdFund(address _beneficiary, uint _goal, uint _deadline) {
        beneficiary = _beneficiary;
        goal = _goal;
        deadline = now + _deadline;
    }
    
    function currentFunding() constant returns (uint) {
        return this.balance;
    }
    
    function totalFunders() constant returns (uint) {
        return totalFundersArr.length;
    }
    
    function contribute() payable {
        if(funders[msg.sender] == 0) totalFundersArr.push(msg.sender);
        funders[msg.sender] += msg.value;
        Contribution(msg.value, goal - this.balance);
    }
    
    function payout() {
        if(now > deadline && this.balance >= goal)
            beneficiary.transfer(this.balance);
    }
    
    function refund() {
        if(now > deadline && this.balance < goal) {
            msg.sender.transfer(funders[msg.sender]);
            funders[msg.sender] = 0;
        }
    }
    
    function disable() {
        if(this.balance != 0) throw;
        selfdestruct(beneficiary);
    }
}
