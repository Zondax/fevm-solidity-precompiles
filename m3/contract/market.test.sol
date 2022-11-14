pragma solidity >=0.4.25 <= 0.8.15;

import { MarketTypes, MarketAPI, CommonTypes } from "./filecoin.mock.sol";

contract FilecoinMarketMockTest {
    function market_withdraw_balance_test() public{
        CommonTypes.Addr memory addr = CommonTypes.Addr(1, bytes("0x1111"));
        MarketTypes.WithdrawBalanceParams memory params = MarketTypes.WithdrawBalanceParams(addr, 1);

        MarketTypes.WithdrawBalanceReturn memory response = MarketAPI.withdraw_balance(params);
    }

    function market_add_balance_test() public{
        CommonTypes.Addr memory addr = CommonTypes.Addr(1, bytes("0x1111"));
        MarketTypes.AddBalanceParams memory params = MarketTypes.AddBalanceParams(addr);

        MarketAPI.add_balance(params);
    }

    function get_balance_test() public{
        CommonTypes.Addr memory params = CommonTypes.Addr(1, bytes("0x1111"));

        MarketTypes.GetBalanceReturn memory response = MarketAPI.get_balance(params);
    }

    function get_deal_data_commitment_test() public{
        MarketTypes.GetDealDataCommitmentParams memory params = MarketTypes.GetDealDataCommitmentParams(1);

        MarketTypes.GetDealDataCommitmentReturn memory response = MarketAPI.get_deal_data_commitment(params);
    }

    function get_deal_client_test() public{
        MarketTypes.GetDealClientParams memory params = MarketTypes.GetDealClientParams(1);

        MarketTypes.GetDealClientReturn memory response = MarketAPI.get_deal_client(params);
    }

    function get_deal_provider_test() public{
        MarketTypes.GetDealProviderParams memory params = MarketTypes.GetDealProviderParams(1);

        MarketTypes.GetDealProviderReturn memory response = MarketAPI.get_deal_provider(params);
    }

    function get_deal_label_test() public{
        MarketTypes.GetDealLabelParams memory params = MarketTypes.GetDealLabelParams(1);

        MarketTypes.GetDealLabelReturn memory response = MarketAPI.get_deal_label(params);
    }

    function get_deal_term_test() public{
        MarketTypes.GetDealTermParams memory params = MarketTypes.GetDealTermParams(1);

        MarketTypes.GetDealTermReturn memory response = MarketAPI.get_deal_term(params);
    }

    function get_deal_epoch_price_test() public{
        MarketTypes.GetDealEpochPriceParams memory params = MarketTypes.GetDealEpochPriceParams(1);

        MarketTypes.GetDealEpochPriceReturn memory response = MarketAPI.get_deal_epoch_price(params);
    }

    function get_deal_client_collateral_test() public{
        MarketTypes.GetDealClientCollateralParams memory params = MarketTypes.GetDealClientCollateralParams(1);

        MarketTypes.GetDealClientCollateralReturn memory response = MarketAPI.get_deal_client_collateral(params);
    }

    function get_deal_provider_collateral_test() public{
        MarketTypes.GetDealProviderCollateralParams memory params = MarketTypes.GetDealProviderCollateralParams(1);

        MarketTypes.GetDealProviderCollateralReturn memory response = MarketAPI.get_deal_provider_collateral(params);
    }

    function get_deal_verified_test() public{
        MarketTypes.GetDealVerifiedParams memory params = MarketTypes.GetDealVerifiedParams(1);

        MarketTypes.GetDealVerifiedReturn memory response = MarketAPI.get_deal_verified(params);
    }

    function get_deal_activation_test() public{
        uint64 id;
        MarketTypes.GetDealActivationParams memory params = MarketTypes.GetDealActivationParams(id);

        MarketTypes.GetDealActivationReturn memory response = MarketAPI.get_deal_activation(params);
    }
}
