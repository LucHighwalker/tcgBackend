/* eslint-disable no-undef */
let CardFactory = artifacts.require('./CardFactory.sol');
let Storage = artifacts.require('./Storage.sol');

module.exports = function(deployer) {
  deployer.deploy(CardFactory, Storage.address);
};
