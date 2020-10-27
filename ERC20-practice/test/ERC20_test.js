const ERC20 = artifacts.require("ERC20");

contract("ERC20 test", async accounts => {
  it("100 ERC20 in the first account", async () => {
    let instance = await ERC20.deployed();
    let balance = await instance.balanceOf(accounts[0]);
    assert.equal(balance.valueOf(), 100, "Initial balance after mint not equal to 100.");
  });
});
