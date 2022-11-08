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
}
