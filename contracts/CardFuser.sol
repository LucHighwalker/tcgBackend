pragma solidity ^0.5.8;

import "./CardFactory.sol";

contract CardFuser is CardFactory {

  modifier onlyOwnerOf(uint _cardId) {
    require(msg.sender == cardToOwner[_cardId], 'not the owner');
    _;
  }
}
