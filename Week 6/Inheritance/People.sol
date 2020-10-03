import "./Destroyable.sol";
pragma solidity 0.5.12;

contract People is Destroyable{

    struct Person{
        string name;
        uint age;
        uint height;
        bool senior;
        bool exists;
    }

    event personCreated(string name, uint age, uint height, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);
    event personUpdated(string name, uint age, uint height, bool senior, string prevName, uint prevAge, uint prevHeight, bool prevSenior);

    uint public balance;

    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }

    mapping(address => Person) private people;
    address[] private creators;

    function createPerson(string memory name, uint age, uint height) internal{
        require(age < 150, "Age needs to be below 150");

        balance += msg.value;
        Person memory newPerson; //people.push(Person(people.length, name, age, height));
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        newPerson.exists = true;

        if (age >= 65){
            newPerson.senior = true;
        } else {
            newPerson.senior = false;
        }

        string memory prevName = people[msg.sender].name;
        uint prevAge = people[msg.sender].age;
        uint prevHeight = people[msg.sender].height;
        bool prevSenior = people[msg.sender].senior;
        bool prevExists = people[msg.sender].exists;

        insertPerson(newPerson);
        creators.push(msg.sender);

        //people[msg.sender] == newPerson--below
        assert(keccak256(abi.encodePacked(people[msg.sender].name, people[msg.sender].age, people[msg.sender].height, people[msg.sender].senior)) == keccak256(abi.encodePacked(newPerson.name, newPerson.age, newPerson.height, newPerson.senior)));

          if (prevExists){
            emit personUpdated(newPerson.name, newPerson.age, newPerson.height, newPerson.senior, prevName, prevAge, prevHeight, prevSenior);
        } else {
            emit personCreated(newPerson.name, newPerson.age, newPerson.height, newPerson.senior);
        }
    }

    function insertPerson(Person memory newPerson) private{
        address creator = msg.sender;
        people[creator] = newPerson;
    }

    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
       address creator = msg.sender;
       return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }

    function deletePerson(address creator) public onlyOwner {
        string memory name = people[creator].name;
        bool senior = people[creator].senior;

        delete people[creator];
        assert(people[creator].age == 0);//invariant
        emit personDeleted(name, senior, owner);
    }

    function getCreator(uint index) public view onlyOwner returns(address){
        return creators[index];
    }

    // function getBalance() public view returns(uint){
    //     return address(this).balance;
    // }

    function withdrawAll() public onlyOwner returns(uint){
        uint toTransfer = balance;
        balance = 0;
        msg.sender.transfer(toTransfer);
        return toTransfer;
    }

    /*SAME AS ABOVE JUST DONE DIFFERENTLY--custom error handling

    function withdrawAll() public onlyOwner returns(uint){
        uint toTransfer = balance;
        balance = 0;
        if(msg.sender.send(toTransfer)){
            return toTransfer;
        } else{
            balance = toTransfer;
            return 0;
        }
    } */
}
