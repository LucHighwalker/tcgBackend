// Allows us to use ES6 in our migrations and tests.
require('babel-register');
require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1', // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      network_id: '*',
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(
          process.env.ROPSTEN_MNEMONIC,
          `https://ropsten.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
          0
        );
      },
      gas: 4612388,
      gasPrice: 1,
      network_id: 3,
    },
  },

  compilers: {
    solc: {
      version: '^0.5.8',
    },
  },

  mocha: {
    useColors: true,
    reporter: 'mocha-multi-reporters',
    reporterOptions: {
      configFile: './mocha-smart-contracts-config.json',
    },
  },
};
