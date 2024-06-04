// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {

    BasicNft basicNft;
    DeployBasicNft deployer;
    address public USER = makeAddr("USER");
    string  public constant DOG_URI = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory nftName = basicNft.name();
        // assertEq(nftName, "Dogie");
        assert(keccak256(abi.encodePacked(nftName)) == keccak256(abi.encodePacked("Dogie"))); // Same as above but more complicated
    
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(DOG_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assertEq(DOG_URI, basicNft.tokenURI(0));
    }
}

