import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{

    mapping(address => uint) private salary;
    mapping(address => address) private boss;

    function createWorker(string memory _name, uint _age, uint _height, uint _salary, address _myBoss) public{
        require(_age <= 75, "Worker must be 75 or younger!");
        require(_myBoss != msg.sender);
        createPerson(_name, _age, _height);
        salary[msg.sender] = _salary;
        boss[msg.sender] = _myBoss;
    }

    function getBoss() public view returns(address){
        return (boss[msg.sender]);
    }

    function getSalary() public view returns(uint _salary){
      return (salary[msg.sender]);
    }

    function yaFired(address _worker) public {
        require(msg.sender == boss[_worker]);
        owner = boss[_worker]; //doesn't doing this still reduce code duplication and is cheaper on gas than adding another function? Or is this cheating the assignment?
        delete salary[_worker];
        delete boss[_worker];
        deletePerson(_worker);
    }
}
