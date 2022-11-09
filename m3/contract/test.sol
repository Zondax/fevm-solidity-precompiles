pragma solidity >=0.4.25 <= 0.8.15;

import { FilecoinTypes, MarketAPI } from "./filecoin.mock.sol";

contract FilecoinMockTest {
    function market_withdraw_balance_test() public{
        FilecoinTypes.Addr memory addr = FilecoinTypes.Addr(1, bytes("0x1111"));
        FilecoinTypes.WithdrawBalanceParams memory params = FilecoinTypes.WithdrawBalanceParams(addr, 1);

        FilecoinTypes.WithdrawBalanceReturn memory response = MarketAPI.withdraw_balance(params);
    }

    function market_add_balance_test() public{
        FilecoinTypes.Addr memory addr = FilecoinTypes.Addr(1, bytes("0x1111"));
        FilecoinTypes.AddBalanceParams memory params = FilecoinTypes.AddBalanceParams(addr);

        MarketAPI.add_balance(params);
    }

    function publish_storage_deals_test() public{
        FilecoinTypes.ClientDealProposal[] memory deals;
        FilecoinTypes.PublishStorageDealsParams memory params = FilecoinTypes.PublishStorageDealsParams(deals);

        FilecoinTypes.PublishStorageDealsReturn memory response = MarketAPI.publish_storage_deals(params);
    }

    function verify_deals_for_activation_test() public{
        FilecoinTypes.SectorDeals[] memory sectors;
        FilecoinTypes.VerifyDealsForActivationParams memory params = FilecoinTypes.VerifyDealsForActivationParams(sectors);

        FilecoinTypes.VerifyDealsForActivationReturn memory response = MarketAPI.verify_deals_for_activation(params);
    }

    function activate_deals_test() public{
        uint64[] memory deal_ids;
        int64 sector_expiry;
        FilecoinTypes.ActivateDealsParams memory params = FilecoinTypes.ActivateDealsParams(deal_ids, sector_expiry);

        FilecoinTypes.ActivateDealsResult memory response = MarketAPI.activate_deals(params);
    }

    function on_miner_sectors_terminate_test() public{
        uint64 epoch;
        uint64[] memory deal_ids;
        FilecoinTypes.OnMinerSectorsTerminateParams memory params = FilecoinTypes.OnMinerSectorsTerminateParams(epoch, deal_ids);

        MarketAPI.on_miner_sectors_terminate(params);
    }

    function compute_data_commitment_test() public{
        FilecoinTypes.SectorDataSpec[] memory inputs;
        FilecoinTypes.ComputeDataCommitmentParams memory params = FilecoinTypes.ComputeDataCommitmentParams(inputs);

        FilecoinTypes.ComputeDataCommitmentReturn memory response = MarketAPI.compute_data_commitment(params);
    }

    function cron_tick_test() public{
        MarketAPI.cron_tick();
    }

    function get_deal_activation_test() public{
        uint64 id;
        FilecoinTypes.GetDealActivationParams memory params = FilecoinTypes.GetDealActivationParams(id);

        FilecoinTypes.GetDealActivationReturn memory response = MarketAPI.get_deal_activation(params);
    }
}
