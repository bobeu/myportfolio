// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./interfaces/IWifeToBe.sol";
import "./interfaces/IInlaw.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "./Context.sol";

contract Inlaw is IInlaw, Ownable{
  address public bank;

  uint private bridePrice;

  mapping (address=>Daughter) public daughters;

  modifier onlyDaughter(address who) {
    require(daughters[who].isOurDaughter, "Not related");
    _;
  }

  constructor (IWifeToBe[] memory _daughters, address _bank, uint _brideprice) {
    bridePrice = _brideprice;
    if(_bank == address(0)) revert InvalidBankAddress();
    for(uint i = 0; i < _daughters.length; i++) {
      address newDaughter = address(_daughters[i]);
      require(newDaughter != address(0), "InvalidDaughter referenced");
      daughters[newDaughter] = Daughter(false, true, 0, address(0));
    }
  }

  function getMarriageApproval(address _daughter) external onlyDaughter(_daughter) returns(bool _return) {
    uint _brideprice = IERC20(_getBank()).allowance(_msgSender(), address(this));
    if(_brideprice < bridePrice) revert InsufficientBridePrice();
    if(IERC20(_getBank()).transferFrom(_msgSender(), address(this), _brideprice)) {
      daughters[_daughter].isMarried = true;
      daughters[_daughter].bridePrice = _brideprice;
      daughters[_daughter].marriedTo = _msgSender();

      require(IWifeToBe(_daughter).setMarriageStatus(_msgSender()), "Failed");
      _return = true;
    }

    return _return;
  }

  function getBridePrize() external view returns(uint) {
    return _getBridePrice();
  }

  function spendMoney(address to, uint amount) public onlyOwner {
    require(IERC20(_getBank()).transfer(to, amount), "Failed");
  }

  function _getBank() internal view returns(address _bank) { _bank = bank; }
  function _getBridePrice() internal view returns(uint _price) { _price = bridePrice; }
}