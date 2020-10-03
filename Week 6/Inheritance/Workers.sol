import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{

    mapping(address => uint) private salary;
    mapping(address => address) private boss;

    function createWorker(string memory name, uint age, uint height, uint _salary, address myBoss) public{
        require(age <= 75, "Worker must be 75 or younger!");
        require(myBoss != msg.sender, "You can not be your own boss.");
        createPerson(name, age, height);
        salary[msg.sender] = _salary;
        boss[msg.sender] = myBoss;
    }

    function getBoss() public view returns(address){
        return boss[msg.sender];
    }

    function getSalary() public view returns(uint){
      return salary[msg.sender];
    }

    function yaFired(address worker) public{
        require(msg.sender == boss[worker], "Must be the boss of the worker to fire.");
        deleteHuman(worker);
        delete salary[worker];
        delete boss[worker];
    }
}
