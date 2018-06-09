pragma solidity ^0.4.2;

import './i.sol';

contract ImageList is owned {

	struct Image {

		address owner;
		bool int;
		string image_hash;
		string caption;
		int upvotes;

	}

	Image[] public imagelist;
	uint deleted=0;


	function addImage(address sender, string _hash, string _caption) onlyOwner returns (uint){
		var k = imagelist.length;

		Image memory temp = Image(true, sender, _hash , _caption);
		imagelist.push(temp);
		return k;

	}


	function getImage(uint index)  constant returns (string, string, address){
		if (ifImageExists(index))
			return (imagelist[index].image_hash, imagelist[index].caption, imagelist[index].owner);
	}

	function upvoteImage(uint index) onlyOwner {
		imagelist[index].upvotes ++;
	}
	function getUpvotes(uint index) onlyOwner constant returns (int) {
		return imagelist[index].upvotes;
	}

	function deleteImage(address sender, uint index) onlyOwner onlyImageOwner(sender, index) returns bool {
		deleted++;
		delete imagelist[index];
			return true;
	}
	function getImageCount() constant returns (unit) {
		return imagelist.length-deleted;
	}

	function getImageOwner(uint image_index) constant returns(address) {
		return imagelist[image_index].owner;
	}

}