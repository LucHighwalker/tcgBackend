/* eslint-disable no-undef */
let Ownable = artifacts.require('./Ownable.sol');
let Storage = artifacts.require('./Storage.sol');

module.exports = (deployer) => {
  deployer.deploy(Ownable, Storage.address);
};
