// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract BrakeWallet {
    event Deposit(address indexed from, uint256 amount);
    event Withdrawal(address indexed from, uint256 amount);

    mapping(address => uint256) balances;
    uint256 public withdrawalLimit;

    constructor(uint256 _withdrawalLimit) {
        withdrawalLimit = _withdrawalLimit > 0 ? _withdrawalLimit : type(uint256).max;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        uint256 balance = balances[msg.sender];
        require(balance >= amount, "balance too low");

        balances[msg.sender] -= amount;

        payable(msg.sender).transfer(amount);

        emit Withdrawal(msg.sender, amount);
    }

    function balanceOf(address from) public view returns (uint256) {
        return balances[from];
    }
}
