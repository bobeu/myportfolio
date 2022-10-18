// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CashInBank is ERC20 {

  constructor () ERC20("Shares", "SHARE") {
    _mint(_msgSender(), 100_000_000 * decimals());
  }
}