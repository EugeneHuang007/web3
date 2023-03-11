// 引入Web3.js库
const Web3 = require('web3');

// 定义智能合约ABI
const abi = [
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "rfid",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "dnaHash",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "parent1",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "parent2",
                "type": "uint256"
            },
            {
                "internalType": "address",
                "name": "owner",
                "type": "address"
            },
            {
                "internalType": "string",
                "name": "identity",
                "type": "string"
            }
        ],
        "name": "storePetInfo",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "rfid",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "dnaHash",
                "type": "uint256"
            }
        ],
        "name": "verifyPetInfo",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "rfid",
                "type": "uint256"
            }
        ],
        "name": "grantCertificate",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "rfid",
                "type": "uint256"
            }
        ],
        "name": "petInfos",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "uint256",
                        "name": "rfid",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "dnaHash",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "parent1",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "parent2",
                        "type": "uint256"
                    },
                    {
                        "components": [
                            {
                                "internalType": "address",
                                "name": "owner",
                                "type": "address"
                            },
                            {
                                "internalType": "string",
                                "name": "identity",
                                "type": "string"
                            }
                        ],
                        "internalType": "struct PetIdentity.PetOwnership",
                        "name": "ownership",
                        "type": "tuple"
                    }
                ],
                "internalType": "struct PetIdentity.PetInfo",
                "name": "",
                "type": "tuple"
            }