/* eslint-disable no-undef */
let Storage = artifacts.require('./Storage.sol');

module.exports = (deployer) => {
  deployer.deploy(Storage);
};
