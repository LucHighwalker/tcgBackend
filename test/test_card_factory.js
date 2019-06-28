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
        },
        'The event is emitted'
      );
    });
  });
});
