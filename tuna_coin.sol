// tuna_coins Initial Coin Offering (ICO)

// version of the compiler
pragma solidity ^0.4.11;

// tuna_coin is the name of our contract
contract tuna_coin {
    
    // total no. of tuna_coin available for sale 
    uint public max_no_of_tuna_coins_available = 1000000;
    
    // value of tuna_coin in rupee (conversion rate)
    // i.e is 1 rupee = 100 tuna_coin
    uint public rupee_to_tuna_coin = 100;
    
    // total no. of tuna_coin that have been bought by the investors
    uint public total_no_of_tuna_coins_bought = 0; // 0 because initially no coins will be bought
    
    // mapping from the investor address to its equity in tuna_coin and rupee_to_tuna_coin
    // mapping is like a function in which the data of the mapping is stored in an array
    // it has to two variables in this case where one is mapping of equity in rupee and other one is mapping of equity in tuna_coin
    mapping(address => uint) equity_tuna_coin; // address is of the investor
    mapping(address => uint) equity_rupee;
    
    
    // modifier is something that will check if the investor can buy or sell some tuna_coin
    // he/she can always sell tuna_coin but they cannot buy any tuna_coin if there is no tuna_coin left
    // this modifier will check if there is tuna_coin left to buy and if yes it will tell the investor okay to buy tuna_coin
    // in simple this whole modifier is to check if the investor can buy tuna_coin
    modifier can_buy_tuna_coin(uint rupee_invested) {
        require (rupee_invested * rupee_to_tuna_coin + total_no_of_tuna_coins_bought <= max_no_of_tuna_coins_available); // require is like if condition
        _; // underscore here is just to say that the functions which we will link to this modifier will only be applied if the condition holds good
    }
    
    // getting the equity in tuna_coins of an investor
    // investor will be the input of the function
    // we want this function to give equity of tuna_coins of an investor
    // address is the type of the variable and investor is the name of the variable
    function equity_in_tuna_coin(address investor) external constant returns(uint) {
        return equity_tuna_coin[investor];
    }
    
    // getting the equity in rupee of an investor
    // investor will be the input of the function
     function equity_in_rupee(address investor) external constant returns(uint) {
        return equity_rupee[investor];
    }
    
    // buy tuna_coin
    function buy_tuna_coin(address investor, uint rupee_invested) external 
    can_buy_tuna_coin(rupee_invested) {
        uint tuna_coin_bought = rupee_invested * rupee_to_tuna_coin;
        equity_tuna_coin[investor] += tuna_coin_bought;
        equity_rupee[investor] = equity_tuna_coin[investor] / 100;
        total_no_of_tuna_coins_bought += tuna_coin_bought;
    }
    
    // sell tuna_coin
    function sell_tuna_coin(address investor, uint no_of_tuna_coin_to_be_sold) external {
        equity_tuna_coin[investor] -= no_of_tuna_coin_to_be_sold;
        equity_rupee[investor] = equity_tuna_coin[investor] / 100;
        total_no_of_tuna_coins_bought -= no_of_tuna_coin_to_be_sold;
    }
}
