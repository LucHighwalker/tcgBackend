/* eslint-disable no-undef */

require('truffle-test-utils').init();

const CardFactory = artifacts.require('../contracts/CardFactory.sol');

contract('CardFactory', accounts => {
  it('create a new card and emmit event', () => {
    return CardFactory.deployed().then(async contract => {
      const result = await contract.createRandomCard('something');
      // Check event
      assert.web3Event(
        result,
        {
          event: 'NewCard',
          args: {
            0: [BN],
            1: 'something',
            2: [BN],
            __length__: 3,
            cardId: [BN],
            name: 'something',
            dna: [BN],
          },
        },
        'The event is emitted'
      );
    });
  });
});
