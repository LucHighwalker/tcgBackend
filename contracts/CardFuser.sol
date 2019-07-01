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

  function fuseCards(uint _card1, uint _card2, uint32 _card1GeneStrength) public onlyOwnerOfMultiple([_card1, _card2]) {
    Card memory card1 = cards[_card1];
    Card memory card2 = cards[_card2];

    uint newDna = card1.dna.add(card2.dna);
    uint32 newAttack = _addPercentiles(card1.attack, card2.attack, _card1GeneStrength);
    uint32 newDefense = _addPercentiles(card1.defense, card2.defense, _card1GeneStrength);
    uint32 newHealth = _addPercentiles(card1.health, card2.health, _card1GeneStrength);

    Card memory card = Card(card1.name, newDna, newAttack, newDefense, newHealth, [uint32(0), 0, 0, 0, 0]);
    uint id = cards.push(card) - 1;
    cardToOwner[id] = msg.sender;
    ownerCardCount[msg.sender] = ownerCardCount[msg.sender].add(1);
    emit FusedCard(id, card.name, card.dna, card.attack, card.defense, card.health);
  }

  function _addPercentiles(uint32 _val1, uint32 _val2, uint32 _perc1) private pure returns (uint32) {
    uint32 _perc2 = uint32(100).sub(_perc1);
    uint32 val1 = _val1.mul(100).mul(_perc1);
    uint32 val2 = _val2.mul(100).mul(_perc2);
    uint32 result = val1.add(val2);
    return result.div(100);
  }
}
