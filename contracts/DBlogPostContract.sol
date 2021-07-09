// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./DBlogContract.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

struct Comment {
    uint exists;
    string content;
    address writer;
}

contract DBlogPostContract is Ownable {
    //bool exists;
    //uint public postNum;
    
    // TODO determine whether to store obj or address
    DBlogContract public blog;
    uint public postNum;
    string public title;
    string public content;
    string[] public tags;
    uint public likeCount;
    mapping(address => bool) likers;
    bool isDeleted;
    
    bool public commentsEnabled;
    uint public commentCount;
    mapping(uint => Comment) comments;
    
    // TODO owner of this is dblogcontract. Make owner the blog contract owner
    constructor(
        address _blogAddress,
        uint _postNum,
        string memory _postTitle,
        string memory _postContent,
        string[] memory _tags,
        bool _commentsEnabled) public {
            
        transferOwnership(_blogAddress);
            
        blog = DBlogContract(_blogAddress);
        postNum = _postNum;
        title = _postTitle;
        content = _postContent;
        tags = _tags;
        likeCount = 0;
        commentCount = 0;
        commentsEnabled = _commentsEnabled;
    }
     
    function likePost() notOwner public {
        require(likers[msg.sender] == false, "Caller address has already liked this post.");
       
        likeCount++;
        likers[msg.sender] = true;
    }
    
    function addComment() public {
        // requre sender to not be owner
    }
    
    function setDeleted(bool _isDeleted) onlyOwner public {
        isDeleted = _isDeleted;
    }
    
    /**
     * @dev Throws if called by the owner.
     */
    modifier notOwner() {
        require(owner() != _msgSender(), "Caller is the owner. Cannot be called by owner");
        _;
    }
}