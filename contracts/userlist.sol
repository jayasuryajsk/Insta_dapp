pragma solidity ^0.4.2;

import './i.sol';

contract UserList is owned {

	event setUserNameEvent(bool success);

	struct User {
		uint[] userImages;
		int32 reward;
		bytes32 username;

	}

	mapping (address => User) public addressToUserData;
	mapping (bytes32 => address) public usernameToUser;

	
	function addImageToUser(address _user, uint _image) onlyOwner {
		addressToUserData[_user].userImages.push(_image);
	}

	function addReward(address _user, int32 _reward) onlyOwner {
		addressToUserData[_user].reward += _reward;
	}

	function getUserInfo(address _user) constant returns (bytes32 username, uint[] images, int32 reward) {
		return (addressToUserData[_user].username, addressToUserData[_user].userImages, addressToUserData[_user].reward);

	}
    /**Function to get user rewards id address is passed**/
	function getReward(address _user) constant returns(int32) {
		return addressToUserData[_user].reward;
	}

	/**function to get rewards for current user**/
	function getReward() constant returns(int32) {
		return addressToUserData[msg.sender].reward;
	}

	/**fucntion to get user images for address passed**/
	fucntion getImages(address _user) constant returns (uint[]) {
		return addressToUserData[_user].userImages;
	}

	/**function to get user images for current user**/
	function getImages() constant returns (uint[]) {
		return addressToUserData[msg.sender].userImages;
	}





}