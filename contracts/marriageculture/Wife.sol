// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./interfaces/IWifeToBe.sol";
import "./interfaces/IHusband.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract WifeToBe is Context, IWifeToBe  {

  address public parent;

  address public husband;

  bool private isReady;

  bytes32 public pregnacy;

  Criteria public criteria;

  Status public status;

  modifier validateStatus(Status _status, string memory errorMessage) {
    require(status == _status, errorMessage);
    _;
    if(uint8(_status) < uint8(Status.MARRIED)) status = Status(uint8(_status) + 1);
  }

  modifier validateCaller(address expected, string memory errorMessage) {
    require(_msgSender() == expected, errorMessage);
    _;
  }

  constructor (
    address _parent,
    uint8 _age,
    bool _isMale,
    bool _shouldOwnAtLeastAProperty,
    address _bank,
    address _property,
    uint8 _religionSelector,
    uint8 _natureSelector,
    uint8 _statusSelector,
    uint _minimBankBalance
    ) 
  {
    if(_parent == address(0)) revert YouShouldAtLeastHaveARelative();
    require(
      _religionSelector < 3 && 
        _natureSelector < 2 && 
          _statusSelector < 2, 
            "Selector out of bound"
    );
    parent = _parent; 
    criteria = Criteria(
      _age,
      _minimBankBalance,
      _isMale,
      _shouldOwnAtLeastAProperty,
      _bank, 
      _property, 
      Religion(_religionSelector), 
      Nature(_natureSelector), 
      Status(_statusSelector)
    );
  }

  function tryPropose() 
    external
    validateStatus(Status.SINGLE, "Taken")
    returns(bool _proposalAccepted) 
  {
    Profile memory _p = IHusband(_msgSender()).getProfile();
    if(_p.age < criteria.age) revert AgeTooLow();
    if(!_p.isMale) revert OnlyMalePlease();
    if(IERC20(_p.bank).balanceOf(_msgSender()) > criteria.minimBankBalance) revert PleaseWorkHarder();
    if(criteria.shouldOwnAtLeastAProperty) {
      if(IERC721(_p.property).balanceOf(_msgSender()) < 1) revert YouShouldAtLeastOwnAProperty();
    }
    require(
      _p.religion == criteria.religion &&
        _p.nature == criteria.nature &&
          _p.status == criteria.status,
            "Sorry! Not my type of man"
    );

    _proposalAccepted = true;

    emit Proposal(address(this), _msgSender());

  }

  function setMarriageStatus(address _husband) 
    external 
    validateCaller(parent, "Only parent can confirm status")
    validateStatus(Status.TAKEN, "Taken")
    returns(bool)
    
  {
    require(_husband != address(0), "Invalid husband ref");
    husband = _husband;

    emit Marriage(_husband, address(this));
    return true;
  }

  function checkStatus() external view returns(string memory _status) {
    if(status == Status.SINGLE) {
      _status = "Single";
    } else if(status == Status(1)) {
      _status = "Taken";
    } else {
      _status = "Married";
    }
  }

  function tryCopulate() external
    validateCaller(husband, "Taarr! no trespassing")
    validateStatus(Status.MARRIED, "Fail") returns(bool)
  {
    pregnacy = bytes32(abi.encodePacked(_msgSender(), address(this)));
    emit Pregnancy(pregnacy, _msgSender());

    return true;
  }

}