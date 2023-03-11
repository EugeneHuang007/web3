// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 宠物身份合约
contract PetIdentity {
    
    // 宠物拥有者信息数据结构
    struct PetOwnership {
        address owner;  // 宠物拥有者的以太坊钱包地址
        string identity;  // 宠物拥有者的身份信息
    }

    // 宠物信息数据结构
    struct PetInfo {
        uint256 petId;    // 宠物的ID
        uint256 dnaHash; // 宠物DNA数据的哈希值
        uint256 parent1; // 宠物父亲的ID
        uint256 parent2; // 宠物母亲的ID
        string rfid; // 宠物的RFID芯片号码
        PetOwnership ownership;  // 宠物拥有者的信息
    }

    // 宠物信息映射表，以宠物ID为键，宠物信息为值
    mapping (uint256 => PetInfo) petInfos;

    /**
     * 存储宠物信息
     * @param petId 宠物的ID
     * @param dnaHash 宠物DNA数据的哈希值
     * @param parent1 宠物父亲的ID
     * @param parent2 宠物母亲的ID
     * @param owner 宠物拥有者的以太坊钱包地址
     * @param identity 宠物拥有者的身份信息
     * @param rfid 宠物的RFID芯片号码
    */
    // 存储宠物信息
    function storePetInfo(uint256 petId, uint256 dnaHash, uint256 parent1, uint256 parent2, address owner, string memory identity, string memory rfid) public {
        //“只有宠物拥有者可以存储宠物信息”
        require(msg.sender == owner, "Only the owner can store pet info");
        //“相同ID的宠物已经存在”
        require(petInfos[petId].petId == 0, "Pet with the same ID already exists");
        // 创建一个新的宠物信息结构体并存储到映射表中
        petInfos[petId] = PetInfo(petId, dnaHash, parent1, parent2, rfid, PetOwnership(owner, identity));
    }

    /**
     * 验证宠物信息
     * @param petId 宠物的ID
     * @return bool 返回宠物信息是否存在的布尔值
    */
    // 验证宠物信息
    function verifyPetInfo(uint256 petId) public view returns (bool) {
        // 如果宠物信息不存在，则返回false，否则返回true
        if (petInfos[petId].petId == 0) {
            return false;
        }
        return true;
    }

    // 颁发宠物身份证明
    function grantIdentityCertificate(uint256 petId) public view returns (string memory) {
        // 检查指定ID的宠物信息是否存在，如果不存在则抛出异常，“指定ID的宠物不存在”
        require(petInfos[petId].petId != 0, "Pet with the given ID does not exist");
        // 返回指定ID的宠物拥有者的身份信息
        return petInfos[petId].ownership.identity;
    }

    // 颁发宠物血统证明
    function grantPedigreeCertificate(uint256 petId) public view returns (uint256, uint256, uint256) {
        // 检查指定ID的宠物信息是否存在，如果不存在则抛出异常
        require(petInfos[petId].petId != 0, "Pet with the given ID does not exist");
        // 返回指定ID的宠物父母的ID和DNA哈希值
        return (petInfos[petId].parent1, petInfos[petId].parent2, petInfos[petId].dnaHash);
    }

    // 查询宠物信息
    function getPetInfo(uint256 petId) public view returns (uint256, uint256, uint256, uint256, string memory, address, string memory) {
        // 检查指定ID的宠物信息是否存在，如果不存在则抛出异常
        require(petInfos[petId].petId != 0, "Pet with the given ID does not exist");
        // 获取指定ID的宠物信息结构体
        PetInfo storage pet = petInfos[petId];
        // 返回宠物的各项信息
        return (pet.petId, pet.dnaHash, pet.parent1, pet.parent2, pet.rfid, pet.ownership.owner, pet.ownership.identity);
    }

    // 撤销宠物身份证明
    function revokeIdentityCertificate(uint256 petId) public {
        // 检查调用者是否是指定ID的宠物拥有者，如果不是则抛出异常
        require(msg.sender == petInfos[petId].ownership.owner, "Only the owner can revoke identity certificate");
        // 删除指定ID的宠物拥有者的身份信息
        delete petInfos[petId].ownership.identity;
    }

    // 撤销宠物血统证明
    function revokePedigreeCertificate(uint256 petId) public {
        // 检查调用者是否是指定ID的宠物拥有者，如果不是则抛出异常
        require(msg.sender == petInfos[petId].ownership.owner, "Only the owner can revoke pedigree certificate");
        // 将指定ID的宠物父母ID和DNA哈希值设为0，相当于将血统证明撤销
        petInfos[petId].parent1 = 0;
        petInfos[petId].parent2 = 0;
        petInfos[petId].dnaHash = 0;
    }
}

