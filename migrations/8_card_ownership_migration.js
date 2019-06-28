/* eslint-disable no-undef */
let CardOwnership = artifacts.require('./CardOwnership.sol');
let Storage = artifacts.require('./Storage.sol');

module.exports = (deployer) => {
  deployer.deploy(CardOwnership, Storage.address);
};
