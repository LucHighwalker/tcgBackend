pragma solidity ^0.5.8;

import "./CardFactory.sol";
import "./SafeMath.sol";

contract CardFuser is CardFactory {

  using SafeMath for uint256;
  using SafeMath32 for uint32;

  modifier onlyOwnerOf(uint _cardId) {
    require(msg.sender == cardToOwner[_cardId], 'not the owner');
    _;
  }

  modifier onlyOwnerOfMultiple(uint[2] memory _cardIds) {
    for (uint i = 0; i < _cardIds.length; i++) {
      require(msg.sender == cardToOwner[_cardIds[i]], 'not the owner');
    }
    _;
  }

  function fuseCards(uint _card1, uint _card2) public onlyOwnerOfMultiple([_card1, _card2]) {
    Card memory card1 = cards[_card1];
    Card memory card2 = cards[_card2];

    uint newDna = card1.dna.add(card2.dna);
    uint32 newAttack = (card1.attack * uint32(0.75)).add(card2.attack * uint32(0.25));
    uint32 newDefense = (card1.defense * uint32(0.75)).add(card2.defense * uint32(0.25));
    uint32 newHealth = (card1.health * uint32(0.75)).add(card2.health * uint32(0.25));

    Card memory card = Card(card1.name, newDna, newAttack, newDefense, newHealth, [uint32(0), 0, 0, 0, 0]);
    uint id = cards.push(card) - 1;
    cardToOwner[id] = msg.sender;
    ownerCardCount[msg.sender] = ownerCardCount[msg.sender].add(1);
    emit NewCard(id, card.name, card.dna);
  }
}
