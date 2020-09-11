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

    mapping(address => uint) public creatorCount;

    mapping(address => uint[]) private idArray;

    function createPerson(uint id, string memory name, uint age, uint height) public {
        address creator = msg.sender;  //could remove this and just use "msg.sender" in lines 21,22,&23 directly;
        people.push(Person(id, name, age, height, creator));
        creatorCount[creator] ++;
        idArray[creator].push(id);
    }

    function getPerson(uint index) public view returns(uint id, string memory name, uint age, uint height, address creator){
        return (people[index].id, people[index].name, people[index].age, people[index].height, people[index].creator);
    }

   function getIDArray() public view returns(uint[] memory){
       return (idArray[msg.sender]);
   }
}
