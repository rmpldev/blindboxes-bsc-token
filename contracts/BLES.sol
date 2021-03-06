// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./LGEWhitelisted.sol";

// This token is owned by Timelock.
contract BLES is ERC20("Blind Boxes Token", "BLES"), LGEWhitelisted {

    constructor() public {
        _mint(_msgSender(), 1e26);  // 100 million, 18 decimals
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override virtual {
        LGEWhitelisted._applyLGEWhitelist(sender, recipient, amount);
        ERC20._transfer(sender, recipient, amount);
    }

    function burn(uint256 _amount) external {
        _burn(_msgSender(), _amount);
    }

    function burnFrom(address account, uint256 amount) external {
        uint256 currentAllowance = allowance(account, _msgSender());
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        _approve(account, _msgSender(), currentAllowance - amount);
        _burn(account, amount);
    }
}
