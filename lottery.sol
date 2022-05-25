// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery{
    address public manager;
address payable[] public  participant;
uint lotteryNumber;
 mapping(uint => address) details;


constructor(){
    manager = msg.sender;
}

function participate() public payable {
   require(msg.sender != manager, "Manager can not participate");
    require(msg.value == 100, "Ticket Price is 100 wei");
    payable(address(this)).transfer;
    participant.push(payable(msg.sender));
  
}

function getBalance() public view returns (uint){
    return address(this).balance;
}

function random() public view returns(uint){
    require(msg.sender==manager);
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participant.length)));
}

function declareWinner() public returns(address) {
    require (msg.sender == manager);
    require (participant.length >=5);
    uint r = random()% participant.length;
    address payable winner;
   winner = participant[r];
winner.transfer(getBalance() - 10000);         //10000 wei is the commission fee
participant =new address payable[](0);     // This resets participants
return winner;     
}

}
