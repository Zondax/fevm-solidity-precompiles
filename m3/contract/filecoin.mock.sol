// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.15;

library FilecoinTypes{

    struct Addr{
        int network;
        bytes payload;
    }

    struct Signature {
        int sig_type;
        bytes data;
    }

    struct DealProposal {
        int piece_cid;
        int piece_size;
        bool verified_deal;
        Addr client;
        Addr provider;
        string label;
        int start_epoch;
        int end_epoch;
        int storage_price_per_epoch;
        int provider_collateral;
        int client_collateral;
    }

    struct ClientDealProposal {
        DealProposal proposal;
        Signature client_signature;
    }

    struct AddBalanceParams {
        Addr provider_or_client;
    }

    struct WithdrawBalanceParams {
        Addr addr;
        int tokenAmount;
    }

    struct WithdrawBalanceReturn {
        int amount_withdrawn;
    }

    struct PublishStorageDealsParams {
        ClientDealProposal[] deals;
    }

    struct PublishStorageDealsReturn {
        int[] ids;
        int[] valid_deals;
    }
}

library MarketAPI{

    function add_balance(FilecoinTypes.AddBalanceParams memory params) internal {
    }

    function withdraw_balance(FilecoinTypes.WithdrawBalanceParams memory params) internal returns (FilecoinTypes.WithdrawBalanceReturn memory) {
        return FilecoinTypes.WithdrawBalanceReturn(1);
    }

    function publish_storage_deals(FilecoinTypes.PublishStorageDealsParams memory params) internal returns (FilecoinTypes.PublishStorageDealsReturn memory) {
        int[] memory ids;
        int[] memory valid_deals;

        return FilecoinTypes.PublishStorageDealsReturn(ids,valid_deals);
    }
}
