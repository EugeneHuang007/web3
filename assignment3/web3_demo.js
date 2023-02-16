// Import the Web3.js module
const Web3 = require('web3');

// Ethereum node HTTP URL provided by Infura
const infuraEndpoint = 'https://mainnet.infura.io/v3/your-project-id';

// Create a Web3 instance with the HTTP URL as provider
const web3 = new Web3(infuraEndpoint);

// Define a function to find the block number that contains the first contract creation transaction
async function findFirstContractCreationBlock() {
  // Get the latest block number of Ethereum
  const latestBlockNumber = await web3.eth.getBlockNumber();

  // Loop backwards from the latest block
  for (let i = latestBlockNumber; i >= 0; i--) {
    // Get the transaction list of the current block
    const block = await web3.eth.getBlock(i, true);

    // Loop through the transaction list
    for (let j = 0; j < block.transactions.length; j++) {
      const tx = block.transactions[j];
      // If the recipient of the transaction is null, it's a contract creation transaction
      if (tx.to === null) {
        return i; // Return the block number
      }
    }
  }

  return -1; // Return -1 if not found
}

// Call the function and print the result
findFirstContractCreationBlock().then((blockNumber) => {
  console.log('The first contract-creation transaction is in block', blockNumber);
}).catch((error) => {
  console.error('Error occurred:', error);
});
