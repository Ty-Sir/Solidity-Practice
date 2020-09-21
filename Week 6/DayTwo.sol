pragma solidity 0.5.12;

contract HelloWorld{

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

    address public owner;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() public{
        owner = msg.sender;
    }

    bool exists = people[msg.sender].exists;//im at a loss

    mapping(address => Person) private people;
    address[] private creators;

    function createPerson(string memory name, uint age, uint height) public{
        require(age < 150, "Age needs to be below 150");
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        string memory prevName = people[msg.sender].name;
        uint prevAge = people[msg.sender].age;
        uint prevHeight = people[msg.sender].height;
        bool prevSenior = people[msg.sender].senior;


        if (age >= 65){
            newPerson.senior = true;
        } else {
            newPerson.senior = false;
        }

        insertPerson(newPerson);
        creators.push(msg.sender);

        assert(
                keccak256(
                    abi.encodePacked(
                        people[msg.sender].name,
                        people[msg.sender].age,
                        people[msg.sender].height,
                        people[msg.sender].senior
                    )
                )
        ==
            keccak256(
                abi.encodePacked(
                    newPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                )
            )
        );

        if (exists) {
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
        assert(people[creator].age == 0);
        emit personDeleted(name, senior, msg.sender);
    }

    function getCreator(uint index) public view onlyOwner returns(address){
        return creators[index];
    }

}
