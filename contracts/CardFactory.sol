pragma solidity ^0.5.8;

import "./Ownable.sol";
import "./SafeMath.sol";

contract CardFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewCard(uint cardId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Card {
        string name;
        uint dna;
        uint attack;
        uint defense;
        uint health;
    }

    Card[] public cards;

    mapping (uint => address) public cardToOwner;
    mapping (address => uint) ownerCardCount;

    function _createCard(string memory _name, uint _dna) private {
        Card memory card = Card(_name, _dna, 100, 100, 100);
        uint id = cards.push(card) - 1;
        cardToOwner[id] = msg.sender;
        ownerCardCount[msg.sender] = ownerCardCount[msg.sender].add(1);
        emit NewCard(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomCard(string memory _name) public {
        require(ownerCardCount[msg.sender] == 0, 'Owner card count not zero.');
        uint randDna = _generateRandomDna(_name);
        _createCard(_name, randDna);
    }

}