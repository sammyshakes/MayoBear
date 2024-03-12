# MultiSig Usage

### Submit a Transaction:

`node encodeFunctionCall.js`

inputs:

- Function Signature
- Function Arguments

Example:

```javascript
node encodeFunctionCall.js "updateBuyFees(uint256,uint256,uint256,uint256,uint256)" 1 1 2 2 1
```

enableTrading:

```javascript
node encodeFunctionCall.js "enableTrading(uint256)" 3
```
