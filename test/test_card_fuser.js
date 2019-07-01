/* eslint-disable no-undef */

require('truffle-test-utils').init();

const CardFactory = artifacts.require('../contracts/CardFactory.sol');
const CardFuser = artifacts.require('../CardFuser.sol');

contract('CardFuser', accounts => {
  it('fuses 2 cards into a new card and emmit event', () => {
    return CardFactory.deployed().then(async factory => {
      await factory.createRandomCard('something');
      await factory.createRandomCard('somethingelse');

      CardFuser.deployed().then(async fuser => {
        const result = await fuser.fuseCards(0, 1, 75);

        assert.web3Event(
          result,
          {
            event: 'FusedCard',
          },
          'The event is emitted'
        );
      });
    });
  });
});
