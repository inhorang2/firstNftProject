import { expect } from 'chai';
import { ethers } from 'hardhat';
import { Signer } from 'ethers';

// Mocha를 사용
// describe는 testCode를 모아둔 집합
describe("firstNft", function(){
    let owner: Signer; //변수의 타입이 Signer

    before(async () => {
        [owner] = await ethers.getSigners(); //test용 지갑 리스트 중 '하나'만 가져올 수 있음
    });

    it("should have 10 nfts", async () => {
        const firstNft = await ethers.getContractFactory("firstNft");
        const contract = await firstNft.deploy(); //contract 작성할때 생성자에 아무런 파라미터 없었기 때문에, deploy도 파라미터 갖지 않음

        await contract.deployed(); //contract가 배포되기까지 기다리셈
        
        //contract가 잘 배포되었는지 확인 (조건문 check로 expect함수 사용)
        expect(await contract.balanceOf(await owner.getAddress())).to.be.equal(9);
    })
})