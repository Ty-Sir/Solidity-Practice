import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{
    address private boss;

    modifier onlyBoss(){
        require(msg.sender == boss);
        _;
    }

    struct Worker{
        string name;
        uint age;
        uint height;
        uint salary;
        bool senior;
    }

    mapping(address => uint) private Salary;
    mapping(address => Worker) private workers;

    function createWorker(string memory name, uint age, uint height, uint salary) public{
        require(age <= 75, "Worker must be 75 or younger!");
        Worker memory newWorker;
        newWorker.name = name;
        newWorker.age = age;
        newWorker.height = height;
        newWorker.salary = salary;

         if (age >= 65){
            newWorker.senior = true;
        } else {
            newWorker.senior = false;
        }

        insertWorker(newWorker);

        Salary[msg.sender] = salary;
        return createPerson(name, age, height);
    }

    function insertWorker(Worker memory newWorker) private{
        workers[msg.sender] = newWorker;
    }

    function getSalary() public view returns(uint salary){
       return (workers[msg.sender].salary);
    }

    function yaFired(address worker) public onlyBoss{ //anyone but the creator of the worker is the boss and can fire them
        delete workers[worker];
        return deletePerson(worker);
    }
}
