/* eslint-disable no-undef */
let CardFuser = artifacts.require('./CardFuser.sol');
let Storage = artifacts.require('./Storage.sol');

module.exports = (deployer) => {
  deployer.deploy(CardFuser, Storage.address);
};
