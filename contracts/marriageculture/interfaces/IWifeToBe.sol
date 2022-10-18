// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./Common.sol";

interface IWifeToBe is Common {
  error AgeTooLow();
  error OnlyMalePlease();
  error PleaseWorkHarder();
  error YouShouldAtLeastOwnAProperty();
  error OurCultureDemandsYouPayDowryFirst();

  event Proposal(address indexed who, address indexed engagedTo);
  event Marriage(address indexed _husband, address indexed _wife);
  event Pregnancy(bytes32 pregnacy, address indexed _husband);
  
  function checkStatus() external view returns(string memory);
  function tryCopulate() external returns(bool);
  function tryPropose() external returns(bool);
  function setMarriageStatus(address _husband) external returns(bool);
}