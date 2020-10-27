pragma solidity 0.5.12;

import "./Ownable.sol";
import "./Safemath.sol";

contract ERC20 is Ownable{

  using SafeMath for uint256;

  string private _name;
  string private _symbol;
  uint8 private _decimals;

  uint256 private _totalSupply;

  mapping(address => uint256) private _balances;

  constructor(string memory name, string memory symbol, uint8 decimals) public{
    _name = name;
    _symbol = symbol;
    _decimals = decimals;
  }

  function name() public view returns (string memory) {
   return _name;
  }

  function symbol() public view returns (string memory) {
    return _symbol;
  }

  function decimals() public view returns (uint8) {
    return _decimals;
  }

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address account) public view onlyOwner returns (uint256) {
   return _balances[account];
  }

  function mint(address account, uint256 amount) public onlyOwner{
    require(account != address(0), "You cannot mint to the zero address.");
    _balances[account] = _balances[account].add(amount);
    _totalSupply = _totalSupply.add(amount);
  }

  function transfer(address recipient, uint256 amount) public returns (bool) {
    require(_balances[msg.sender] > 0, "Insufficient balance.");
    require(amount <= _balances[msg.sender], "You don't have that much.");
    require(msg.sender != recipient, "You cannot send money to yourself.");
    require(recipient != address(0), "You cannot send to the zero address.");
    _balances[msg.sender] = _balances[msg.sender].sub(amount);
    _balances[recipient] = _balances[recipient].add(amount);

    return true;
  }
}
