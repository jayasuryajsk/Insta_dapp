pragma solidity ^0.4.2;

contract owned {
	address public owner;
	

	function owned() {
		owner = msg.sender;
	}


}

contract mortal is owned {
	function kill () {
		if (msg.sender == owner)
			selfdestruct(owner);
	}
}