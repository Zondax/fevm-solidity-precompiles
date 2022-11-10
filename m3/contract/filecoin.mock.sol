// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.15;

library CommonTypes{
    enum RegisteredSealProof {
        StackedDRG2KiBV1,
        StackedDRG512MiBV1,
        StackedDRG8MiBV1,
        StackedDRG32GiBV1,
        StackedDRG64GiBV1,

        StackedDRG2KiBV1P1,
        StackedDRG512MiBV1P1,
        StackedDRG8MiBV1P1,
        StackedDRG32GiBV1P1,
        StackedDRG64GiBV1P1,
        Invalid
    }

    enum RegisteredPoStProof {
        StackedDRGWinning2KiBV1,
        StackedDRGWinning8MiBV1,
        StackedDRGWinning512MiBV1,
        StackedDRGWinning32GiBV1,
        StackedDRGWinning64GiBV1,
        StackedDRGWindow2KiBV1,
        StackedDRGWindow8MiBV1,
        StackedDRGWindow512MiBV1,
        StackedDRGWindow32GiBV1,
        StackedDRGWindow64GiBV1,
        Invalid
    }

    enum RegisteredUpdateProof {
        StackedDRG2KiBV1,
        StackedDRG8MiBV1,
        StackedDRG512MiBV1,
        StackedDRG32GiBV1,
        StackedDRG64GiBV1,
        Invalid
    }

    struct SectorPreCommitInfo {
        RegisteredSealProof seal_proof;
        uint64 sector_number;
        CID sealed_cid;
        int64 seal_rand_epoch;
        uint64[] deal_ids;
        int64 expiration;
        CID unsealed_cid;
    }
    struct ReplicaUpdateInner {
        uint64 sector_number;
        uint64 deadline;
        uint64 partition;
        CID new_sealed_cid;
        CID new_unsealed_cid;
        uint64[] deals;
        RegisteredUpdateProof update_proof_type;
        bytes replica_proof;
    }

    struct ReplicaUpdate {
        uint64 sector_number;
        uint64 deadline;
        uint64 partition;
        CID new_sealed_cid;
        uint64 deals;
        RegisteredUpdateProof update_proof_type;
        bytes replica_proof;
    }

    struct ReplicaUpdate2 {
        uint64 sector_number;
        uint64 deadline;
        uint64 partition;
        CID new_sealed_cid;
        CID new_unsealed_cid;
        uint64 deals;
        RegisteredUpdateProof update_proof_type;
        bytes replica_proof;
    }

    struct PoStPartition {
        uint64 index;
        int8 skipped;
    }

    struct PoStProof {
        RegisteredPoStProof post_proof;
        bytes proof_bytes;
    }

    struct VestingFunds{
        int64 epoch;
        int256 amount;
    }
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
}


library MarketTypes{

    // Params and return for methods
    struct AddBalanceParams {
        CommonTypes.Addr provider_or_client;
    }

    struct WithdrawBalanceParams {
        CommonTypes.Addr provider_or_client;
        int tokenAmount;
    }

    struct WithdrawBalanceReturn {
        int amount_withdrawn;
    }

    struct PublishStorageDealsParams {
        CommonTypes.ClientDealProposal[] deals;
    }

    struct PublishStorageDealsReturn {
        int[] ids;
        int[] valid_deals;
    }

    struct VerifyDealsForActivationParams {
        CommonTypes.SectorDeals[] sectors;
    }

    struct VerifyDealsForActivationReturn {
        CommonTypes.SectorDealData[] sectors;
    }

    struct ActivateDealsParams {
        uint64[] deal_ids;
        int64 sector_expiry;
    }

    struct ActivateDealsResult {
        int nonverified_deal_space;
        CommonTypes.VerifiedDealInfo[] verified_infos;
    }

    struct OnMinerSectorsTerminateParams {
        uint64 epoch;
        uint64[] deal_ids;
    }

    struct ComputeDataCommitmentParams {
        CommonTypes.SectorDataSpec[] inputs;
    }

    struct ComputeDataCommitmentReturn {
        CommonTypes.CID[] commds;
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

    function add_balance(MarketTypes.AddBalanceParams memory params) internal {
    }

    function withdraw_balance(MarketTypes.WithdrawBalanceParams memory params) internal returns (MarketTypes.WithdrawBalanceReturn memory) {
        return MarketTypes.WithdrawBalanceReturn(1);
    }

    function publish_storage_deals(MarketTypes.PublishStorageDealsParams memory params) internal returns (MarketTypes.PublishStorageDealsReturn memory) {
        int[] memory ids;
        int[] memory valid_deals;

        return MarketTypes.PublishStorageDealsReturn(ids,valid_deals);
    }

    function verify_deals_for_activation(MarketTypes.VerifyDealsForActivationParams memory params) internal returns (MarketTypes.VerifyDealsForActivationReturn memory) {
        CommonTypes.SectorDealData[] memory sectors;

        return MarketTypes.VerifyDealsForActivationReturn(sectors);
    }

    function activate_deals(MarketTypes.ActivateDealsParams memory params) internal returns (MarketTypes.ActivateDealsResult memory) {
        CommonTypes.VerifiedDealInfo[] memory verified_infos;

        return MarketTypes.ActivateDealsResult(1, verified_infos);
    }

    function on_miner_sectors_terminate(MarketTypes.OnMinerSectorsTerminateParams memory params) internal {
    }

    function compute_data_commitment(MarketTypes.ComputeDataCommitmentParams memory params) internal returns (MarketTypes.ComputeDataCommitmentReturn memory) {
        CommonTypes.CID[] memory cids;

        return MarketTypes.ComputeDataCommitmentReturn(cids);
    }

    function cron_tick() internal {
    }

    function get_deal_activation(MarketTypes.GetDealActivationParams memory params) internal returns (MarketTypes.GetDealActivationReturn memory) {
        return MarketTypes.GetDealActivationReturn(1, 1);
    }
}

library MinerTypes{
    struct GetControlAddressesReturn {
        CommonTypes.Addr owner;
        CommonTypes.Addr worker;
        CommonTypes.Addr[] control_addresses;
    }
    struct GetOwnerReturn {
        CommonTypes.Addr owner;
    }
    struct IsControllingAddressParam {
        CommonTypes.Addr addr;
    }
    struct IsControllingAddressReturn {
        bool is_controlling;
    }
    struct GetSectorSizeReturn {
        uint64 sector_size;
    }
    struct GetAvailableBalanceReturn {
        int256 available_balance;
    }
    struct GetVestingFundsReturn {
        CommonTypes.VestingFunds[] vesting_funds;
    }
    struct ChangeWorkerAddressParams {
        CommonTypes.Addr new_worker;
        CommonTypes.Addr[] new_control_addresses;
    }
    struct ChangePeerIDParams {
        bytes new_id;
    }
    struct ChangeMultiaddrsParams {
        bytes new_multi_addrs;
    }
    struct SubmitWindowedPoStParams {
        uint64 deadline;
        CommonTypes.PoStPartition[] partitions;
        CommonTypes.PoStProof[] proofs;
        int64 chain_commit_epoch;
        bytes chain_commit_rand;
    }
    struct ProveCommitAggregateParams {
        uint8 sector_numbers;
        bytes aggregate_proof;
    }
    struct ProveReplicaUpdatesParams {
        CommonTypes.ReplicaUpdate[] updates;
    }
    struct ProveReplicaUpdatesParams2 {
        CommonTypes.ReplicaUpdate2 updates;
    }
    struct DisputeWindowedPoStParams {
        uint64 deadline;
        uint64 post_index;
    }
    struct PreCommitSectorParams {
        CommonTypes.RegisteredSealProof seal_proof;
        uint64 sector_number;
        CommonTypes.CID sealed_cid;
        int64 seal_rand_epoch;
        uint64[] deal_ids;
        int64 expiration;
        bool replace_capacity;
        uint64 replace_sector_deadline;
        uint64 replace_sector_partition;
        uint64 replace_sector_number;
    }

    struct PreCommitSectorBatchParams {
        PreCommitSectorParams[] sectors;
    }

    struct PreCommitSectorBatchParams2 {
        CommonTypes.SectorPreCommitInfo[] sectors;
    }
}

library MinerAPI{

}
