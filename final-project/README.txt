README for PetIdentity Contract

The PetIdentity contract is a Solidity smart contract that enables the storage and management of pet information on the Ethereum blockchain. This contract is designed to allow pet owners to store and manage their pet's information securely and transparently on the blockchain.The contract is to realize blockchain-based pet identity authentication and lineage traceability, and create a minimum viable product demo of a one-stop pet identity system based on blockchain.

The contract defines two data structures - PetOwnership and PetInfo. PetOwnership represents the ownership information of a pet, including the Ethereum wallet address of the pet owner and their identity information. PetInfo represents the information of a pet, including its ID, DNA hash, parent IDs, RFID, and ownership information.

The contract provides several functions for managing pet information, including:

1. storePetInfo: This function allows pet owners to store their pet's information on the blockchain. The function takes in the pet ID, DNA hash, parent IDs, owner's Ethereum wallet address, owner's identity information, and RFID chip number as input. The function can only be called by the pet owner.

2. verifyPetInfo: This function allows anyone to verify if a pet's information exists on the blockchain. The function takes in the pet ID as input and returns a boolean value indicating whether the pet information exists.

3. grantIdentityCertificate: This function allows anyone to issue an identity certificate for a pet. The function takes in the pet ID as input and returns the identity information of the pet's owner.

4. grantPedigreeCertificate: This function allows anyone to issue a pedigree certificate for a pet. The function takes in the pet ID as input and returns the parent IDs and DNA hash of the pet.

5. getPetInfo: This function allows anyone to retrieve all information about a pet. The function takes in the pet ID as input and returns the pet's ID, DNA hash, parent IDs, RFID, owner's Ethereum wallet address, and owner's identity information.

6. revokeIdentityCertificate: This function allows pet owners to revoke the identity certificate of their pet. The function takes in the pet ID as input and can only be called by the pet owner.

7. revokePedigreeCertificate: This function allows pet owners to revoke the pedigree certificate of their pet. The function takes in the pet ID as input and can only be called by the pet owner.

Note that all functions in the PetIdentity contract are public and can be called by anyone on the Ethereum blockchain. However, some functions have restrictions on who can call them, such as storePetInfo and revokeIdentityCertificate, which can only be called by the pet owner.

The contract also includes a mapping table called petInfos, which stores the pet information using the pet ID as the key. This mapping table ensures that each pet has a unique ID and their information can be easily accessed and managed.

The PetIdentity contract is released under the MIT License, which allows anyone to use, copy, and modify the code for any purpose. However, the license comes with no warranty, and the authors are not liable for any damages or losses that may result from the use of the code.

Overall, the PetIdentity contract provides a secure and transparent way for pet owners to store and manage their pet's information on the Ethereum blockchain.