import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{

    struct Worker{
        string name;
        uint age;
        uint height;
        uint salary;
        bool senior;
        address myBoss;
    }

    //mapping(address => uint) private Salary;
    mapping(address => Worker) private workers;

    function createWorker(string memory name, uint age, uint height, uint salary, address myBoss) public{
        require(age <= 75, "Worker must be 75 or younger!");
        require(myBoss != msg.sender);
        Worker memory newWorker;
        newWorker.name = name;
        newWorker.age = age;
        newWorker.height = height;
        newWorker.salary = salary;
        newWorker.myBoss = myBoss;

         if (age >= 65){
            newWorker.senior = true;
        } else {
            newWorker.senior = false;
        }

        insertWorker(newWorker);

        return createPerson(name, age, height);
    }

    function insertWorker(Worker memory newWorker) private{
        workers[msg.sender] = newWorker;
    }

    function getBoss() public view returns(address){
        return (workers[msg.sender].myBoss);
    }

    function getSalary() public view returns(uint salary){
       return (workers[msg.sender].salary);
    }

    function yaFired(address worker) public{
        require(msg.sender == workers[worker].myBoss);
        delete workers[worker];
        return deletePerson(worker);
    }
}
