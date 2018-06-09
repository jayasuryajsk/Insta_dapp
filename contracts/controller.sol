pragma solidity ^0.4.2;

import './i.sol';
import './userlist.sol';
import './imagelist.sol';

contract Controller is owned {
	ImageList public imagelist;
	UserList public userlist;
	votingList public votinglist;

	function Controller(ImageList _imagelist, UserList _userlist){
		imagelist = _imagelist;
		userlist = _userlist;
		votingList = _votinglist;
		
	}


	function addImage(string _hash, string _caption){
		var k = imagelist.addImage(msg.sender, _hash, _caption);
		userlist.addImageToUser(msg.sender, k);
		userlist.addReward(msg.sender, 10);
	}


	function deleteImage(uint index) {
		if (imagelist.deleteImage(msg.sender, index))
			userlist.addReward(msg.sender, -10);
	}


	function upvoteImage(uint index){
		if (imagelist.ifImageExists(index) && !(imagelist.getImageOwner(index)==msg.sender))
			if (votinglist.upvoteImage(msg.sender, index, false)){
				imagelist.upvoteImage(index);
				userlist.addReward(imagelist.getImageOwner(index), 2);
			}
}