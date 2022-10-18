// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./Common.sol";

interface IHusband is Common{
  error InvalidWifeOrInlawAddress();

  function getProfile() external view returns(Profile memory);
}