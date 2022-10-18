// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./Common.sol";

interface IInlaw is Common{
  error InsufficientBridePrice();
  error UnresolvedPayment();

  struct Daughter {
    bool isMarried;
    bool isOurDaughter;
    uint bridePrice;
    address marriedTo;
  }

  function getMarriageApproval(address _daughter) external returns(bool);
  function getBridePrize() external view returns(uint);
}