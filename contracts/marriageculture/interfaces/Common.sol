// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

interface Common {
  error InvalidBankAddress();
  error YouShouldAtLeastHaveARelative();

  enum Status { SINGLE, TAKEN, MARRIED }
  enum Religion { TRADITIONAL, ISLAMIC, CHRISTIANITY }
  enum Nature { DRUNKARD, NONDRUNKER }

  struct Criteria {
    uint age;
    uint minimBankBalance;
    bool isAMale;
    bool shouldOwnAtLeastAProperty;
    address bank;
    address property;
    Religion religion;
    Nature nature;
    Status status;
  }

  struct Profile {
    uint age;
    bool isMale;
    address bank;
    address property;
    Religion religion;
    Nature nature;
    Status status;
  }
  
}