const ethers = require('ethers');

function encodeFunctionCall(functionSignature, parameters) {
  const iface = new ethers.Interface([`function ${functionSignature}`]);
  const functionName = functionSignature.split('(')[0];
  // Enhanced parameter processing to handle booleans and large numbers
  const treatedParameters = parameters.map((param) => {
    if (param.toLowerCase() === 'true') return true;
    if (param.toLowerCase() === 'false') return false;
    return /^\d+$/.test(param) && param.length > 15 ? param.toString() : param;
  });
  return iface.encodeFunctionData(functionName, treatedParameters);
}

// Parsing command-line arguments
const functionSignature = process.argv[2];
const parameters = process.argv.slice(3);

const encodedData = encodeFunctionCall(functionSignature, parameters);

console.log('Encoded Data:', encodedData);
