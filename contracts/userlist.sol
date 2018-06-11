pragma solidity ^0.4.0;

import './i.sol';

contract UserList is owned {

	/**Event indicating the success/failure of the setUserName function**/

	event setUserNameEvent(bool success);

	/**Struct to store all the user related properties **/

	struct User {
		uint[] userImages;
		int32 reward;
		bytes32 username;

	}

	/**A mapping from user address to userdata(user struct) and another mapping from username to user address.username is stored as a bytes32 type**/

	mapping (address => User) public addressToUserData;
	mapping (bytes32 => address) public usernameToUser;

	//**A function to add the new image to the owner of the image**//
	function addImageToUser(address _user, uint _image) onlyOwner {
		addressToUserData[_user].userImages.push(_image);
	}

	/** A function to add the user name to the current user,the address of the current user is added in the usernametoUser mapping and _uname is added to addressToUserData if the uname is
			mapped to a null address ,an event setUserNameEvent is set to true in this condition ,otherwise the event is set to false.**/
	function setUserName(bytes32 _uname){
		if(usernameToUser[_uname] == address(0x0)){
			usernameToUser[_uname] = msg.sender;
			addressToUserData[msg.sender].username = _uname;
			setUserNameEvent(true);
		}
		else{
			setUserNameEvent(false);
		}
	}

	/**	A function to check if the username is set to the current user.function returns true if the mapping addressToUserData for the current user contains a non empty string ,otherwise it returns false.**/
	
	function isUsernameSet() constant returns (bool){
		if(bytes32(0) == addressToUserData[msg.sender].username){
			return false;
		}
		return true;
	}

	function isUsernameExists(bytes32 _username) constant returns (bool){
		if(address(0) == usernameToUser[_username]){
			return false;
		}
		return true;
	}

	/**A function to get the user information.It returns the data from the User struct for the user address passed.**/

		function getUserInfo(address _user) constant returns (bytes32 username, uint[] images, int32 reward){
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

	/**A function to get the username for the current user**/
	function getUserName() constant returns (bytes32){
		return addressToUserData[msg.sender].username;
	}

	/**A function to get the username for the user address passed**/
	function getUserName(address _user) constant returns (bytes32){
		return addressToUserData[_user].username;
	}



}