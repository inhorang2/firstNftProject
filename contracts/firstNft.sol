// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//ERC721을 상속받고, 생성자함수(nft가 배포되었을때 최초로 한번만 실행되는 함수)에서 10개의 nft를 contract를 생성한 msg.sender에게 민팅
contract firstNft is ERC721, Ownable {
    uint256 MAX_SUPPLY = 100;
    bool isSaleActive; //default false
    uint256 totalSupply; //default 0

    constructor() ERC721("firstNft", "LECTURE") {
        // for (uint  i = 0; i < 10; i++) {
        //     _safeMint(msg.sender, i + 1);
        // }
    }

    function _baseURI() internal view override returns (string memory) {
        return "ipfs://QmQSV5VwvffJqFGoHFPGRYNG1dhNAmUoAyN5yi67KmhSEK";
    }

    //Ownable.sol의 modefier "onlyOwner"를 넣어서 owner만 이 함수를 호출 할 수 있도록 함
    function setSale(bool active) external onlyOwner{
        isSaleActive = active;
    }

    function mintPlanet(uint256 count) external payable { //트랜잭션으로 이더를 전송하기 위해서는 "payable"이 붙어야함
        require(isSaleActive, "not on sale"); //isSaleActive일 때만 민팅
        require(msg.value >= 1000000000000000 * count);
        require(count <= 10, "mint maximum 10 nfts at once");

        for (uint i = 0; i < count; i++) {
            require(totalSupply < MAX_SUPPLY, "max supply exceeded");
            _safeMint(msg.sender, totalSupply++);
        }
    }
}