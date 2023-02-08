require("hardhat-deploy")
require("hardhat-deploy-ethers")

const { networkConfig } = require("../helper-hardhat-config")


const private_key = network.config.accounts[0]
const wallet = new ethers.Wallet(private_key, ethers.provider)

module.exports = async ({ deployments }) => {
  console.log("Wallet Ethereum Address:", wallet.address)
  // const chainId = network.config.chainId
  // const tokensToBeMinted = networkConfig[chainId]["tokensToBeMinted"]

  //deploy FlowShieldDao
  const FlowShieldDao = await ethers.getContractFactory('StcImDao', wallet);
  console.log('Deploying StcImDao...');
  const certificate = await FlowShieldDao.deploy();
  await certificate.deployed()
  console.log('StcImDao deployed to:', certificate.address);
}