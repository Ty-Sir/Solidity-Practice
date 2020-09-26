import "./Ownable.sol";
pragma solidity 0.5.12;

contract Destroyable is Ownable{
    function deleteContract() public onlyOwner {
        selfdestruct(address(uint160(owner)));


        /* OR THIS WAY TO HAVE IT MORE READABLE
        address payable receiver = msg.sender;
        selfdestruct(receiver);

        OR
        selfdestruct(msg.sender);

        */
    }
}
