pragma solidity ^0.5.8;

import "./CardFuser.sol";

contract CardHelper is CardFuser {

  function changeName(uint _cardId, string calldata _newName) external onlyOwnerOf(_cardId) {
    cards[_cardId].name = _newName;
  }

  function changeDna(uint _cardId, uint _newDna) external onlyOwnerOf(_cardId) {
    cards[_cardId].dna = _newDna;
  }

  function getCardsByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerCardCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < cards.length; i++) {
      if (cardToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
