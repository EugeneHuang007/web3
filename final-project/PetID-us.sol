// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Pet Identity Contract
contract PetIdentity {

    // Pet Ownership Information Data Structure
    struct PetOwnership {
        address owner;  // Ethereum wallet address of the pet owner
        string identity;  // Identity information of the pet owner
    }

    // Pet Information Data Structure
    struct PetInfo {
        uint256 petId;    // ID of the pet
        uint256 dnaHash; // Hash value of the pet's DNA data
        uint256 parent1; // ID of the pet's father
        uint256 parent2; // ID of the pet's mother
        string rfid; // RFID chip number of the pet
        PetOwnership ownership;  // Information of the pet owner
    }

    // Pet Information Mapping Table, with pet ID as key and pet information as value
    mapping (uint256 => PetInfo) petInfos;

    /**
     * Store pet information
     * @param petId The ID of the pet
     * @param dnaHash The hash value of the pet's DNA data
     * @param parent1 The ID of the pet's father
     * @param parent2 The ID of the pet's mother
     * @param owner The Ethereum wallet address of the pet's owner
     * @param identity The identity information of the pet's owner
     * @param rfid The RFID chip number of the pet
    */
    // Store pet information
    function storePetInfo(uint256 petId, uint256 dnaHash, uint256 parent1, uint256 parent2, address owner, string memory identity, string memory rfid) public {
        require(msg.sender == owner, "Only the owner can store pet info");
        require(petInfos[petId].petId == 0, "Pet with the same ID already exists");
        // Create a new pet info struct and store it in the mapping table
        petInfos[petId] = PetInfo(petId, dnaHash, parent1, parent2, rfid, PetOwnership(owner, identity));
    }

    /**
     * Verify pet information
     * @param petId The ID of the pet
     * @return bool The boolean value indicating whether the pet information exists
    */
    // Verify pet information
    function verifyPetInfo(uint256 petId) public view returns (bool) {
        // If the pet information does not exist, return false, otherwise return true
        if (petInfos[petId].petId == 0) {
            return false;
        }
        return true;
    }

    /**
     * Issue pet identity certificate
     * @param petId The ID of the pet
     * @return string memory The identity information of the pet's owner
    */
    // Issue pet identity certificate
    function grantIdentityCertificate(uint256 petId) public view returns (string memory) {
        // Check if the pet information with the specified ID exists, throw an exception if it does not
        require(petInfos[petId].petId != 0, "Pet with the given ID does not exist");
        // Return the identity information of the pet's owner with the specified ID
        return petInfos[petId].ownership.identity;
    }

    /**
     * Grant pedigree certificate function
     * @param petId ID of the pet
     * @return Returns the ID and DNA hash of the pet's parents
    */
    //Grant pedigree certificate function
    function grantPedigreeCertificate(uint256 petId) public view returns (uint256, uint256, uint256) {
        // Check if the pet information exists with the given ID, if not, throw an exception
        require(petInfos[petId].petId != 0, "Pet with the given ID does not exist");
        // Return the parent IDs and DNA hash of the pet with the given ID
        return (petInfos[petId].parent1, petInfos[petId].parent2, petInfos[petId].dnaHash);
    }

    /**
     * Get pet information function
     * @param petId ID of the pet
     * @return Returns the pet's ID, DNA hash, parent IDs, RFID, owner's address, and owner's identity
    */
    function getPetInfo(uint256 petId) public view returns (uint256, uint256, uint256, uint256, string memory, address, string memory) {
        // Check if the pet information exists with the given ID, if not, throw an exception
        require(petInfos[petId].petId != 0, "Pet with the given ID does not exist");
        // Get the pet information structure of the pet with the given ID
        PetInfo storage pet = petInfos[petId];
        // Return all information of the pet
        return (pet.petId, pet.dnaHash, pet.parent1, pet.parent2, pet.rfid, pet.ownership.owner, pet.ownership.identity);
    }

    /**
     * Revoke identity certificate function
     * @param petId ID of the pet
    */
    function revokeIdentityCertificate(uint256 petId) public {
        // Check if the caller is the owner of the pet with the given ID, if not, throw an exception
        require(msg.sender == petInfos[petId].ownership.owner, "Only the owner can revoke identity certificate");
        // Delete the owner's identity information of the pet with the given ID
        delete petInfos[petId].ownership.identity;
    }

    /**
     * Revoke pedigree certificate function
     * @param petId ID of the pet
    */
    function revokePedigreeCertificate(uint256 petId) public {
        // Check if the caller is the owner of the pet with the given ID, if not, throw an exception
        require(msg.sender == petInfos[petId].ownership.owner, "Only the owner can revoke pedigree certificate");
        // Set the parent IDs and DNA hash of the pet with the given ID to 0, effectively revoking the pedigree certificate
        petInfos[petId].parent1 = 0;
        petInfos[petId].parent2 = 0;
        petInfos[petId].dnaHash = 0;
        }
}