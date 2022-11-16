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
    enum ExtensionKind {
        ExtendCommittmentLegacy,
        ExtendCommittment
    }

    // FIXME this is actually an int64 on rust
    enum SectorSize {
        _2KiB,
        _8MiB,
        _512MiB,
        _32GiB,
        _64GiB
    }

    struct ValidatedExpirationExtension {
        uint64 deadline;
        uint64 partition;
        uint8 sectors;
        int64 new_expiration;
    }

    struct ExtendExpirationsInner {
        ValidatedExpirationExtension[] extensions;
        bytes claims; // FIXME this is a BTreeMap<SectorNumber, (u64, u64)> on rust
    }

    struct PendingBeneficiaryChange {
        bytes new_beneficiary;
        int256 new_quota;
        uint64 new_expiration;
        bool approved_by_beneficiary;
        bool approved_by_nominee;
    }

    struct BeneficiaryTerm {
        int256 quota;
        int256 used_quota;
        uint64 expiration;
    }

    struct ActiveBeneficiary {
        bytes beneficiary;
        BeneficiaryTerm term;
    }

    struct RecoveryDeclaration {
        uint64 deadline;
        uint64 partition;
        uint8 sectors;
    }

    struct FaultDeclaration {
        uint64 deadline;
        uint64 partition;
        uint8 sectors;
    }

    struct TerminationDeclaration {
        uint64 deadline;
        uint64 partition;
        uint8 sectors;
    }

    struct SectorClaim {
        uint64 sector_number;
        uint64[] maintain_claims;
        uint64[] drop_claims;
    }

    struct ExpirationExtension2 {
        uint64 deadline;
        uint64 partition;
        uint8 sectors;
        SectorClaim[] sectors_with_claims;
        int64 new_expiration;
    }

    struct ExpirationExtension {
        uint64 deadline;
        uint64 partition;
        uint8 sectors;
        int64 new_expiration;
    }

    struct FilterEstimate {
        int256 position;
        int256 velocity;
    }

    struct SectorPreCommitInfoInner {
        RegisteredSealProof seal_proof;
        uint64 sector_number;
        bytes sealed_cid;
        int64 seal_rand_epoch;
        uint64[] deal_ids;
        int64 expiration;
        bytes unsealed_cid;
    }

    struct SectorPreCommitInfo {
        RegisteredSealProof seal_proof;
        uint64 sector_number;
        bytes sealed_cid;
        int64 seal_rand_epoch;
        uint64[] deal_ids;
        int64 expiration;
        bytes unsealed_cid;
    }
    struct ReplicaUpdateInner {
        uint64 sector_number;
        uint64 deadline;
        uint64 partition;
        bytes new_sealed_cid;
        bytes new_unsealed_cid;
        uint64[] deals;
        RegisteredUpdateProof update_proof_type;
        bytes replica_proof;
    }

    struct ReplicaUpdate {
        uint64 sector_number;
        uint64 deadline;
        uint64 partition;
        bytes new_sealed_cid;
        uint64 deals;
        RegisteredUpdateProof update_proof_type;
        bytes replica_proof;
    }

    struct ReplicaUpdate2 {
        uint64 sector_number;
        uint64 deadline;
        uint64 partition;
        bytes new_sealed_cid;
        bytes new_unsealed_cid;
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

    struct Signature {
        int8 sig_type;
        bytes data;
    }

    struct DealProposal {
        bytes piece_cid;
        uint64 piece_size;
        bool verified_deal;
        bytes client;
        bytes provider;
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
        bytes commd;
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
        bytes data;
        uint64 size;
    }

    struct SectorDataSpec {
        uint64[] deal_ids;
        int64 sector_type;
    }
}


library MarketTypes{
    struct AddBalanceParams {
        bytes provider_or_client;
    }

    struct WithdrawBalanceParams {
        bytes provider_or_client;
        uint256 tokenAmount;
    }

    struct WithdrawBalanceReturn {
        uint256 amount_withdrawn;
    }

    struct GetBalanceReturn {
        uint256 balance;
        uint256 locked;
    }

    struct GetDealDataCommitmentParams {
        uint64 id;
    }

    struct GetDealDataCommitmentReturn {
        bytes data;
        uint64 size;
    }

    struct GetDealClientParams {
        uint64 id;
    }

    struct GetDealClientReturn {
        uint64 client;
    }

    struct GetDealProviderParams {
        uint64 id;
    }

    struct GetDealProviderReturn {
        uint64 provider;
    }

    struct GetDealLabelParams {
        uint64 id;
    }

    struct GetDealLabelReturn {
        bytes label;
    }

    struct GetDealTermParams {
        uint64 id;
    }

    struct GetDealTermReturn {
        int64 start;
        int64 end;
    }

    struct GetDealEpochPriceParams {
        int64 id;
    }

    struct GetDealEpochPriceReturn {
        uint256 price_per_epoch;
    }

    struct GetDealClientCollateralParams {
        uint64 id;
    }

    struct GetDealClientCollateralReturn {
        uint256 collateral;
    }

    struct GetDealProviderCollateralParams {
        uint64 id;
    }

    struct GetDealProviderCollateralReturn {
        uint256 collateral;
    }

    struct GetDealVerifiedParams {
        uint64 id;
    }

    struct GetDealVerifiedReturn {
        bool verified;
    }

    struct GetDealActivationParams {
        uint64 id;
    }

    struct GetDealActivationReturn {
        int64 activated;
        int64 terminated;
    }
}

contract MarketAPI{
    mapping(bytes => uint256) balances;

    function add_balance(MarketTypes.AddBalanceParams memory params) public payable {
        balances[params.provider_or_client] += msg.value;
    }

    function withdraw_balance(MarketTypes.WithdrawBalanceParams memory params) public returns (MarketTypes.WithdrawBalanceReturn memory) {
        return MarketTypes.WithdrawBalanceReturn(1);
    }

    function get_balance(bytes memory addr) public returns (MarketTypes.GetBalanceReturn memory) {
        uint256 actualBalance = balances[addr];

        return MarketTypes.GetBalanceReturn(actualBalance, 0);
    }

    function get_deal_data_commitment(MarketTypes.GetDealDataCommitmentParams memory params) public returns (MarketTypes.GetDealDataCommitmentReturn memory) {
        return MarketTypes.GetDealDataCommitmentReturn(bytes("0x111111"), 10000);
    }

    function get_deal_client(MarketTypes.GetDealClientParams memory params) public returns (MarketTypes.GetDealClientReturn memory) {
        return MarketTypes.GetDealClientReturn(1);
    }

    function get_deal_provider(MarketTypes.GetDealProviderParams memory params) public returns (MarketTypes.GetDealProviderReturn memory) {
        return MarketTypes.GetDealProviderReturn(1);
    }

    function get_deal_label(MarketTypes.GetDealLabelParams memory params) public returns (MarketTypes.GetDealLabelReturn memory) {
        return MarketTypes.GetDealLabelReturn(bytes("0x111111"));
    }

    function get_deal_term(MarketTypes.GetDealTermParams memory params) public returns (MarketTypes.GetDealTermReturn memory) {
        return MarketTypes.GetDealTermReturn(1668428301, 1699964301);
    }

    function get_deal_epoch_price(MarketTypes.GetDealEpochPriceParams memory params) public returns (MarketTypes.GetDealEpochPriceReturn memory) {
        return MarketTypes.GetDealEpochPriceReturn(1);
    }

    function get_deal_client_collateral(MarketTypes.GetDealClientCollateralParams memory params) public returns (MarketTypes.GetDealClientCollateralReturn memory) {
        return MarketTypes.GetDealClientCollateralReturn(1);
    }

    function get_deal_provider_collateral(MarketTypes.GetDealProviderCollateralParams memory params) public returns (MarketTypes.GetDealProviderCollateralReturn memory) {
        return MarketTypes.GetDealProviderCollateralReturn(1);
    }

    function get_deal_verified(MarketTypes.GetDealVerifiedParams memory params) public returns (MarketTypes.GetDealVerifiedReturn memory) {
        return MarketTypes.GetDealVerifiedReturn(true);
    }

    function get_deal_activation(MarketTypes.GetDealActivationParams memory params) public returns (MarketTypes.GetDealActivationReturn memory) {
        return MarketTypes.GetDealActivationReturn(1, 1);
    }

    function publish_deal(bytes memory raw_auth_params, address callee) public {
        // calls standard filecoin receiver on message authentication api method number
        (bool success, bytes memory _ret) = callee.call(abi.encodeWithSignature("handle_filecoin_method(uint64,uint64,bytes)", 0, 2643134072, raw_auth_params));
        require(success, "client contract failed to authorize deal publish");
    }
    
}

library MinerTypes{
    struct GetOwnerReturn {
        bytes owner;
    }
    struct IsControllingAddressParam {
        bytes addr;
    }
    struct IsControllingAddressReturn {
        bool is_controlling;
    }
    struct GetSectorSizeReturn {
        CommonTypes.SectorSize sector_size;
    }
    struct GetAvailableBalanceReturn {
        int256 available_balance;
    }
    struct GetVestingFundsReturn {
        CommonTypes.VestingFunds[] vesting_funds;
    }

    struct ChangeBeneficiaryParams {
        bytes new_beneficiary;
        int256 new_quota;
        uint64 new_expiration;
    }

    struct GetBeneficiaryReturn {
        CommonTypes.ActiveBeneficiary active;
        CommonTypes.PendingBeneficiaryChange proposed;
    }
}

contract MinerAPI{
    bytes owner;
    CommonTypes.ActiveBeneficiary activeBeneficiary;
    bool isBeneficiarySet = false;

    function get_owner() public returns (MinerTypes.GetOwnerReturn memory)  {
        require(owner.length != 0);

        return MinerTypes.GetOwnerReturn(owner);
    }

    function is_controlling_address( MinerTypes.IsControllingAddressParam memory params ) public returns (MinerTypes.IsControllingAddressReturn memory) {
        return MinerTypes.IsControllingAddressReturn(false);
    }

    function get_sector_size() public returns (MinerTypes.GetSectorSizeReturn memory params ) {
        return MinerTypes.GetSectorSizeReturn(CommonTypes.SectorSize._8MiB);
    }

    function get_available_balance( ) public returns (MinerTypes.GetAvailableBalanceReturn memory params ) {
        return MinerTypes.GetAvailableBalanceReturn(10000000000000000000000);
    }

    function get_vesting_funds() public returns (MinerTypes.GetVestingFundsReturn memory params ) {
        CommonTypes.VestingFunds[] memory vesting_funds = new CommonTypes.VestingFunds[](1);
        vesting_funds[0] = CommonTypes.VestingFunds(1668514825, 2000000000000000000000);

        return MinerTypes.GetVestingFundsReturn(vesting_funds);
    }

    function change_beneficiary(MinerTypes.ChangeBeneficiaryParams memory params) public {
        if(!isBeneficiarySet){
            CommonTypes.BeneficiaryTerm memory term = CommonTypes.BeneficiaryTerm(params.new_quota, 0, params.new_expiration);
            activeBeneficiary = CommonTypes.ActiveBeneficiary(params.new_beneficiary, term);
            isBeneficiarySet = true;
        } else {
            activeBeneficiary.beneficiary = params.new_beneficiary;
            activeBeneficiary.term.quota = params.new_quota;
            activeBeneficiary.term.expiration = params.new_expiration;
        }
    }

    function get_beneficiary() public returns (MinerTypes.GetBeneficiaryReturn memory) {
        require(isBeneficiarySet);

        CommonTypes.PendingBeneficiaryChange memory proposed;
        return MinerTypes.GetBeneficiaryReturn(activeBeneficiary, proposed);
    }

}
