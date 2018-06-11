pragma solidity ^0.4.2;

import './i.sol';

contract Imagelist is owned {

	struct Image {

		address owner;
		bool int;
		string image_hash;
		string caption;
		int upvotes;

	}

	Image[] public imagelist;
	uint deleted=0;

    /**A function to add image information to the image struct**/
	function addImage(address sender, string _hash, string _caption) onlyOwner returns (uint){
		var k = imagelist.length;

		Image memory temp = Image(true, sender, _hash , _caption);
		imagelist.push(temp);
		return k;

	}

	/**A function to get image parameters**/
	function getImage(uint index)  constant returns (string, string, address){
		if (ifImageExists(index))
			return (imagelist[index].image_hash, imagelist[index].caption, imagelist[index].owner);
	}
	/**A function to upvote the image**/
	function upvoteImage(uint index) onlyOwner {
		imagelist[index].upvotes ++;
	}

	//**A function to get number of upvotes**//
	function getUpvotes(uint index) onlyOwner constant returns (int) {
		return imagelist[index].upvotes;
	}
	/**A function to delete the image passed.Image will only be deleted if the current user is the owner of the image**/
	function deleteImage(address sender, uint index) onlyOwner onlyImageOwner(sender, index) returns bool {
		deleted++;
		delete imagelist[index];
			return true;
	}

	/**A func to get total count of the images**/
	function getImageCount() constant returns (unit) {
		return imagelist.length-deleted;
	}

	/**A function to get address of the image's owner,when the index is passed **/

	function getImageOwner(uint image_index) constant returns(address) {
		return imagelist[image_index].owner;
	}

}