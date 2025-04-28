// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import {IERC20} from "../IERC20.sol";

interface IDelegationManager {
    struct SignatureWithExpiry {
        bytes signature;
        uint256 expiry;
    }

    function delegateTo(
        address operator,
        SignatureWithExpiry memory approverSignatureAndExpiry,
        bytes32 approverSalt
    ) external;

    function undelegate(
        address staker
    ) external returns (bytes32[] memory withdrawalRoot);

    struct QueuedWithdrawalParams {
        address[] strategies;
        uint256[] shares;
        address withdrawer;
    }

    function queueWithdrawals(
        QueuedWithdrawalParams[] calldata queuedWithdrawalParams
    ) external returns (bytes32[] memory);

    struct Withdrawal {
        address staker;
        address delegatedTo;
        address withdrawer;
        uint256 nonce;
        uint32 startBlock;
        address[] strategies;
        uint256[] scaledShares;
    }

    // function completeQueuedWithdrawal(
    //     Withdrawal calldata withdrawal,
    //     address[] calldata tokens,
    //     uint256 middlewareTimesIndex,
    //     bool receiveAsTokens
    // ) external;

    function completeQueuedWithdrawal(
        Withdrawal calldata withdrawal,
        IERC20[] calldata tokens,
        bool receiveAsTokens
    ) external;

    // Following Function is not present in DelegationManager.sol
    function getWithdrawalDelay(
        address[] calldata strategies
    ) external view returns (uint256);

    function delegatedTo(address staker) external view returns (address);

    function minWithdrawalDelayBlocks() external view returns (uint256);

    /// @dev Thrown when attempting to withdraw before delay has elapsed.
    error WithdrawalDelayNotElapsed();
}
