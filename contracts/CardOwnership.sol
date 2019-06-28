pragma solidity ^0.5.8;

import "./CardHelper.sol";
import "./ERC721.sol";

contract CardOwnership is CardHelper, ERC721 {

  mapping (uint => address) cardApprovals;

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerCardCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return cardToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerCardCount[_to]++;
    ownerCardCount[_from]--;
    cardToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (cardToOwner[_tokenId] == msg.sender || cardApprovals[_tokenId] == msg.sender, 'wrong sender');
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    cardApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }
}
