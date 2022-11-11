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
}
