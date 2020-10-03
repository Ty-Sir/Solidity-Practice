import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{

    mapping(address => uint) public salary;

    function createWorker(string memory name, uint age, uint height, uint _salary) public{
        require(age <= 75, "Worker must be 75 or younger!");

        salary[msg.sender] = _salary;
        return createPerson(name, age, height);
    }

    function yaFired(address worker) public {
        delete salary[worker];
        return deletePerson(worker);
    }
}
