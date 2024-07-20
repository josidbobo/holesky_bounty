const { ethers } = require('ethers');
const { parseHexString } = require('./utils.js')

const contractAddress = '0xB233eE56e57f7eB1B1144b28214Abc74b273d3D5';

const rpcEndpoint = 'https://ethereum-holesky-rpc.publicnode.com'
const contractABI = require('./abi/OpenOracleCommonDataFeed.js');

// Example: Get latest data from a price feed
async function getLatestData() {
  const provider = new ethers.providers.JsonRpcProvider(rpcEndpoint);
  const contract = new ethers.Contract(contractAddress, contractABI, provider);

  const taskType = 1
  try {
    // Call the function
    const result = await contract.latestRoundData(taskType);

    console.log("Result:", result);
    if(taskType < 15){
      data = parseInt(result[0]) / 100.0
    }else{
      data = parseHexString(result[0])
    }
    console.log('result:', ethers.utils.formatUnits(result[0], 6))
  } catch (error) {
    console.error('Error calling contract function:', error.message);
  }
}

getLatestData();