// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//ERC721을 상속받고, 생성자함수(nft가 배포되었을때 최초로 한번만 실행되는 함수)에서 10개의 nft를 contract를 생성한 msg.sender에게 민팅
contract firstNft is ERC721 {
    constructor() ERC721("firstNft", "LECTURE") {
        for (uint  i = 0; i < 10; i++) {
            _safeMint(msg.sender, i + 1);
        }
    }
}