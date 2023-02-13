// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract StcImDao {

    struct Node{
        string nodeId;
        string nodeInfo;
        bool isUsed;
    }
    // // A mapping is a key/value map. Here we store each staked user.
    // mapping(string => string) _nodeInfo;
    mapping(address=>Node[]) _nodeDeposits;

    function isEqual(string memory strLeft, string memory strRight) internal pure returns(bool) {
        bytes32 hashLeft = keccak256(abi.encode(strLeft));
        bytes32 hashRight = keccak256(abi.encode(strRight));

        return ( hashLeft == hashRight );
    }
    // /**
    //  *
    //  */
    function stake(string memory nodeId , string memory nodeInfo) external {
        // for (uint i = 0; i < _nodeDeposits[msg.sender].length-1; i++){
        //     require(!isEqual(_nodeDeposits[msg.sender][i].nodeId, nodeId), "Node already staked");
        // }
        // require(isEqual(_nodeInfo[nodeId], ""), "Node already staked");
        // _nodeInfo[nodeId] = nodeInfo;
        _nodeDeposits[msg.sender].push(Node(nodeId, nodeInfo, true));

    }

    function isStake(string memory nodeId) external view returns(bool) {
        //循环查询链上节点，查询到则说明质押过
        for (uint i = 0; i < _nodeDeposits[msg.sender].length-1; i++){
            if (isEqual(_nodeDeposits[msg.sender][i].nodeId, nodeId)) {
                return true;
            }
        }
        return false;
    }


    // /**
    //  *
    //  */
    function withdraw(string memory nodeId) external {
        for (uint i = 0; i < _nodeDeposits[msg.sender].length-1; i++){
            if (isEqual(_nodeDeposits[msg.sender][i].nodeId, nodeId)) {
                _nodeDeposits[msg.sender][i].isUsed = false;
            }
        }
    }

    // /**
    //  *
    //  */
    function getNodeList() external view returns (Node[] memory){
        Node[] memory _nodeList = _nodeDeposits[msg.sender];
        return _nodeList;
    }
}