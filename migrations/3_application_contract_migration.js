/* eslint-disable no-undef */
let Application = artifacts.require('./Application.sol');
let Storage = artifacts.require('./Storage.sol');

module.exports = (deployer) => {
  deployer.deploy(Application, Storage.address);
};
