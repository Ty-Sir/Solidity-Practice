pragma solidity 0.5.12;

contract HelloWorld{

    struct Person{
        uint id;
        string name;
        uint age;
        uint height;
        address creator;
    }

    Person[] private people;

    mapping(address => uint) private personAddress;


    function createPerson(uint id, string memory name, uint age, uint height, address creator) public {
        creator = msg.sender;
        people.push(Person(id, name, age, height, creator));
    }

    function peopleCount() view public returns(uint) {
        return people.length;
    }

    function getPerson(uint index) public view returns(uint id, string memory name, uint age, uint height, address creator){
        return (people[index].id, people[index].name, people[index].age, people[index].height, people[index].creator);
    }

}
