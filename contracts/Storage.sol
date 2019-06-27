pragma solidity ^0.5.8;


contract Storage {

    bytes32 public something;

    function storeSomethingForMe(bytes32 _something) public {
        something = _something;
    }

}

