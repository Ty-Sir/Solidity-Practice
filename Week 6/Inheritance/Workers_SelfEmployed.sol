import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{

    mapping(address => uint) public Salary;

    function createWorker(string memory name, uint age, uint height, uint salary) public{
        require(age <= 75, "Worker must be 75 or younger!");

        Salary[msg.sender] = salary;
        return createPerson(name, age, height);
    }

    function yaFired(address worker) public {
        delete Salary[worker];
        return deletePerson(worker);
    }
}
