// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IInlaw.sol";
import "./interfaces/IWifeToBe.sol";
import "./interfaces/IHusband.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Husband is IHusband, Ownable {
  address public inlaw;
  address private wifeToBe;

  bool public isMarried;

  Profile public profile;

  constructor (
    uint age,
    bool isMale,
    address bank,
    address property,
    uint8 _religionSelector,
    uint8 _natureSelector,
    uint8 _statusSelector) {
      if(bank == address(0)) revert InvalidBankAddress();
      require(
        _religionSelector < 3 && 
          _natureSelector < 2 && 
            _statusSelector < 2, 
              "Selector out of bound"
      );

      profile = Profile(
        age, 
        isMale, 
        bank, 
        property, 
        Religion(_religionSelector), 
        Nature(_natureSelector), 
        Status(_statusSelector)
      );
      
  }

  function payDowry(address _wifeToBe, address _inlaw) public onlyOwner {
    require(_wifeToBe != address(0) && _inlaw != address(0), "InvalidWifeOrInlaw") ;
    require(IERC20(_getBank()).approve(_inlaw, _getBridePrice()), "Failed");
    if(IInlaw(_inlaw).getMarriageApproval(_wifeToBe)) {
      isMarried = true;
      wifeToBe = _wifeToBe;
      inlaw = _inlaw;
    }
  }

  function tryPropose() public onlyOwner { 
    require(IWifeToBe(wifeToBe).tryPropose(), "Sorry! She's taken");
  }

  function tryCopulate() public onlyOwner {
    require(IWifeToBe(wifeToBe).tryCopulate(), "Oops! something went wrong");
  }

  function spendMoney(address to, uint amount) public onlyOwner {
    require(IERC20(_getBank()).transfer(to, amount), "Failed");
  }

  function getProfile() external view returns(Profile memory){ 
    return profile;
  }

  function _getBank() internal view returns(address _bank) { _bank = profile.bank; }

  function _getBridePrice() internal view returns(uint _price) { 
    _price = IInlaw(inlaw).getBridePrize(); 
  }
}
