// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {IStrategy} from "./IStrategy.sol";
import {IERC20} from "../IERC20.sol";

interface IStrategyManager {
    function stakerStrategyShares(
        address user,
        address strategy
    ) external view returns (uint256 shares);

    function getDeposits(
        address staker
    ) external view returns (IStrategy[] memory, uint256[] memory);

    function depositIntoStrategy(
        IStrategy strategy,
        IERC20 token,
        uint256 amount
    ) external returns (uint256 shares);

    // function depositIntoStrategy(
    //     address strategy,
    //     address token,
    //     uint256 amount
    // ) external returns (uint256 shares);
}
