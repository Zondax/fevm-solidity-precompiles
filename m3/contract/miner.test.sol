// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <= 0.8.15;

import { MinerTypes, MinerAPI, CommonTypes } from "./filecoin.mock.sol";


contract FilecoinMinerMockTest {
    address minerApiAddress;

    constructor(address _minerApiAddress) {
        minerApiAddress = _minerApiAddress;
    }

    function get_owner() public  view{
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);
        MinerTypes.GetOwnerReturn memory response = minerApiInstance.get_owner();
    }

    function is_controlling_address() public view {
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);

        MinerTypes.IsControllingAddressParam memory params;
        MinerTypes.IsControllingAddressReturn memory response = minerApiInstance.is_controlling_address(params);
    }

    function get_sector_size() public view {
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);

        MinerTypes.GetSectorSizeReturn memory response = minerApiInstance.get_sector_size();
    }

    function get_available_balance() public view returns (int256){
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);

        MinerTypes.GetAvailableBalanceReturn memory response = minerApiInstance.get_available_balance();
        return response.available_balance;
    }


    function get_vesting_funds() public view {
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);

        MinerTypes.GetVestingFundsReturn memory response = minerApiInstance.get_vesting_funds();
    }

    function change_beneficiary() public {
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);

        MinerTypes.ChangeBeneficiaryParams memory params;
        minerApiInstance.change_beneficiary(params);
    }

    function get_beneficiary() public view {
        MinerAPI minerApiInstance = MinerAPI(minerApiAddress);

        MinerTypes.GetBeneficiaryReturn memory response = minerApiInstance.get_beneficiary();
    }
}
