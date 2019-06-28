/* eslint-disable no-undef */
let CardHelper = artifacts.require('./CardHelper.sol');
let Storage = artifacts.require('./Storage.sol');

module.exports = (deployer) => {
  deployer.deploy(CardHelper, Storage.address);
};
