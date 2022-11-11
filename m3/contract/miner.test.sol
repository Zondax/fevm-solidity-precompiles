pragma solidity >=0.4.25 <= 0.8.15;

import { MinerTypes, MinerAPI, CommonTypes } from "./filecoin.mock.sol";

contract FilecoinMinerMockTest {
    function get_owner() public {
        MinerTypes.GetOwnerReturn memory response = MinerAPI.get_owner();
    }

    function is_controlling_address() public {
        MinerTypes.IsControllingAddressParam memory params;

        MinerTypes.IsControllingAddressReturn memory response = MinerAPI.is_controlling_address(params);
    }

    function get_sector_size() public {
        MinerTypes.GetSectorSizeReturn memory response = MinerAPI.get_sector_size();
    }

    function get_available_balance( ) public {
        MinerTypes.GetAvailableBalanceReturn memory response = MinerAPI.get_available_balance();
    }

    function get_vesting_funds() public {
        MinerTypes.GetVestingFundsReturn memory response = MinerAPI.get_vesting_funds();
    }
    
    function change_beneficiary() public {
        MinerTypes.ChangeBeneficiaryParams memory params;

        MinerAPI.change_beneficiary(params);
    }

    function get_beneficiary() public {
        MinerTypes.GetBeneficiaryReturn memory response = MinerAPI.get_beneficiary();
    }
}
