const ERC20 = artifacts.require("ERC20");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(ERC20, "TyCoin", "TYC", 1).then(function(instance){
    instance.mint(accounts[0], 100).then(function(){
      console.log(" Successfully minted 100 coins to " + accounts[0]);//balances will be hexadecimal in terminal
    }).catch(function(err){
      console.log(" Error from Mint: " + err);
    })
  }).catch(function(err){
    console.log(" Deploy failed " + err);
  })
};
