const ethers = require('ethers');

function encodeFunctionCall(functionSignature, parameters) {
  const iface = new ethers.Interface([`function ${functionSignature}`]);
  const functionName = functionSignature.split('(')[0];
  return iface.encodeFunctionData(functionName, parameters);
}

// Check if the script is run with enough arguments
if (process.argv.length < 4) {
  console.error(
    "Usage: node encodeFunctionCall.js '<functionSignature>' [arg1, arg2, ...]"
  );
  process.exit(1);
}

const functionSignature = process.argv[2];
const parameters = process.argv.slice(3).map((arg) => {
  // Attempt to parse JSON (for arrays, objects), fallback to original string for everything else
  try {
    return JSON.parse(arg);
  } catch (e) {
    return arg;
  }
});

const encodedData = encodeFunctionCall(functionSignature, parameters);

console.log('Encoded Data:', encodedData);
