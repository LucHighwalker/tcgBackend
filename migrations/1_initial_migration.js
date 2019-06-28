// eslint-disable-next-line no-undef
let Migrations = artifacts.require('./Migrations.sol');

module.exports = (deployer) => {
  deployer.deploy(Migrations);
};
