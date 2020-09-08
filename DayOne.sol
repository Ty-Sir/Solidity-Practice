pragma solidity 0.5.12;

contract HelloWorld{
    Person[] public people;

    uint256 public peopleCount = 0;

    struct Person{
        uint id;
        string name;
        uint age;
        uint height;
    }

    address Creator;

    modifier onlyCreator(){
       require(msg.sender ==Creator) ;
       _;
    }


    constructor() public {
        Creator = msg.sender;
    }


    function createPerson(
        uint id,
        string memory name,
        uint age,
        uint height
    )
        public
        onlyCreator
    {
        incrementCount();
        people.push(Person(id, name, age, height));
    }


    function incrementCount() internal {
        peopleCount += 1;
    }

}
