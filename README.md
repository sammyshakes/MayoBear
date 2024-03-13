# MultiSig Usage

### Submit a Transaction:

`node encodeFunctionCall.js`

inputs:

- Function Signature
- Function Arguments

Example:

```javascript
node encodeFunctionCall.js "updateBuyFees(uint256,uint256,uint256,uint256,uint256)" 1 1 2 1 1

node encodeFunctionCall.js "updateSellFees(uint256,uint256,uint256,uint256,uint256)" 1 1 2 1 1
```

enableTrading:

```javascript
node encodeFunctionCall.js "enableTrading(uint256)" 3
```

transfer for initial liquidity:

```javascript
node encodeFunctionCall.js  "approve(address,uint256)" 0x4871eAe23ECA5cE33ceff5e0366Ef5d585e13253 1000000000000000000000000000


Encoded Data: 0x095ea7b30000000000000000000000004871eae23eca5ce33ceff5e0366ef5d585e132530000000000000000000000000000000000000000033b2e3c9fd0803ce8000000
```

transfer mayo tokens:

```javascript
node encodeFunctionCall.js "transferFrom(address,address,uint256)" 0x4871eAe23ECA5cE33ceff5e0366Ef5d585e13253 0x391AE0bbFc46E2671E976efbfdB83b01F5701382 90900000000000000000000000
```

```javascript
node encodeFunctionCall.js "addLiquidityETH(address,uint256,uint256,uint256,address,uint256)" 0x3f6c91d57aa4A115346c84aa13e67f33379CD762 90900000000000000000000000 0 0 0x000000000000000000000000000000000000dead 1710512460



Encoded Data: 0xf305d7190000000000000000000000003f6c91d57aa4a115346c84aa13e67f33379cd7620000000000000000000000000000000000000000004b30d2dfbaf72d4480000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dead0000000000000000000000000000000000000000000000000000000065f4594c

node encodeFunctionCall.js "excludeFromFees(address,bool)" 0x391AE0bbFc46E2671E976efbfdB83b01F5701382 true

node encodeFunctionCall.js "returnToNormalTax()"
```
