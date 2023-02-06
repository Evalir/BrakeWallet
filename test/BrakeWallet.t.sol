// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "../src/BrakeWallet.sol";

contract BrakeWalletTest is Test {
    BrakeWallet public wallet;

    function setUp() public {
        wallet = new BrakeWallet(1 ether);
    }

    function testDeposit() public {
        vm.deal(msg.sender, 1 ether);

        wallet.deposit{value: 1 ether}();

        assert(address(wallet).balance == 1 ether);
        assert(wallet.balanceOf(address(this)) > 0);
    }

    function testWithdraw() public {
        vm.deal(msg.sender, 1 ether);

        wallet.deposit{value: 1 ether}();

        assert(wallet.balanceOf(address(this)) == 1 ether);
        assert(address(wallet).balance == 1 ether);

        wallet.withdraw(1 ether);

        assert(address(wallet).balance == 0);
        assert(wallet.balanceOf(address(this)) == 0);
    }

    receive() external payable {}
}
