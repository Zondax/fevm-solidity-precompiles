// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.15;

library FilecoinTypes{

    struct SectorDeals {
        int64 sector_type;
        int64 sector_expiry;
        uint64 [] deal_ids;
    }

    struct Addr{
        int network;
        bytes payload;
    }

    struct Signature {
        int8 sig_type;
        bytes data;
    }

    struct DealProposal {
        CID piece_cid;
        uint64 piece_size;
        bool verified_deal;
        Addr client;
        Addr provider;
        string label;
        int64 start_epoch;
        int64 end_epoch;
        int storage_price_per_epoch;
        int provider_collateral;
        int client_collateral;
    }

    struct ClientDealProposal {
        DealProposal proposal;
        Signature client_signature;
    }

    struct SectorDealData {
        CID commd;
    }

    struct CID {
        uint8 version;
        uint64 codec;
        Multihash hash;
    }

    struct Multihash{
        uint64 code;
        uint8 size;
        bytes digest;
    }

    struct VerifiedDealInfo {
        uint64 client;
        uint64 allocation_id;
        CID data;
        uint64 size;
    }

    struct SectorDataSpec {
        uint64[] deal_ids;
        int64 sector_type;
    }

    // Params and return for methods
    struct AddBalanceParams {
        Addr provider_or_client;
    }

    struct WithdrawBalanceParams {
        Addr provider_or_client;
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

    struct VerifyDealsForActivationParams {
        SectorDeals[] sectors;
    }

    struct VerifyDealsForActivationReturn {
        SectorDealData[] sectors;
    }

    struct ActivateDealsParams {
        uint64[] deal_ids;
        int64 sector_expiry;
    }

    struct ActivateDealsResult {
        int nonverified_deal_space;
        VerifiedDealInfo[] verified_infos;
    }

    struct OnMinerSectorsTerminateParams {
        uint64 epoch;
        uint64[] deal_ids;
    }

    struct ComputeDataCommitmentParams {
        SectorDataSpec[] inputs;
    }

    struct ComputeDataCommitmentReturn {
        CID[] commds;
    }

    struct GetDealActivationParams {
        uint64 id;
    }

    struct GetDealActivationReturn {
        int64 activated;
        int64 terminated;
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

    function verify_deals_for_activation(FilecoinTypes.VerifyDealsForActivationParams memory params) internal returns (FilecoinTypes.VerifyDealsForActivationReturn memory) {
        FilecoinTypes.SectorDealData[] memory sectors;

        return FilecoinTypes.VerifyDealsForActivationReturn(sectors);
    }

    function activate_deals(FilecoinTypes.ActivateDealsParams memory params) internal returns (FilecoinTypes.ActivateDealsResult memory) {
        FilecoinTypes.VerifiedDealInfo[] memory verified_infos;

        return FilecoinTypes.ActivateDealsResult(1, verified_infos);
    }

    function on_miner_sectors_terminate(FilecoinTypes.OnMinerSectorsTerminateParams memory params) internal {
    }

    function compute_data_commitment(FilecoinTypes.ComputeDataCommitmentParams memory params) internal returns (FilecoinTypes.ComputeDataCommitmentReturn memory) {
        FilecoinTypes.CID[] memory cids;

        return FilecoinTypes.ComputeDataCommitmentReturn(cids);
    }

    function cron_tick() internal {
    }

    function get_deal_activation(FilecoinTypes.GetDealActivationParams memory params) internal returns (FilecoinTypes.GetDealActivationReturn memory) {
        return FilecoinTypes.GetDealActivationReturn(1, 1);
    }
}
