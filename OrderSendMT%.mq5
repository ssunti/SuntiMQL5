//--- value for ORDER_MAGIC 
input long order_magic=55555; 
//+------------------------------------------------------------------+ 
//| Script program start function                                    | 
//+------------------------------------------------------------------+ 
void OnStart() 
  { 
//--- make sure that the account is demo 
   if(AccountInfoInteger(ACCOUNT_TRADE_MODE)==ACCOUNT_TRADE_MODE_REAL) 
     { 
      Alert("Script operation is not allowed on a live account!"); 
      return; 
     } 
//--- place or delete order 
   if(GetOrdersTotalByMagic(order_magic)==0)  
     { 
      //--- no current orders - place an order 
      uint res=SendRandomPendingOrder(order_magic); 
      Print("Return code of the trade server ",res); 
     } 
   else // there are orders - delete orders 
     { 
      DeleteAllOrdersByMagic(order_magic); 
     } 
//--- 
  } 
//+------------------------------------------------------------------+ 
//| Receives the current number of orders with specified ORDER_MAGIC | 
//+------------------------------------------------------------------+ 
int GetOrdersTotalByMagic(long const magic_number) 
  { 
   ulong order_ticket; 
   int total=0; 
//--- go through all pending orders 
   for(int i=0;i<OrdersTotal();i++) 
      if((order_ticket=OrderGetTicket(i))>0) 
         if(magic_number==OrderGetInteger(ORDER_MAGIC)) total++; 
//--- 
   return(total); 
  } 
//+------------------------------------------------------------------+ 
//| Deletes all pending orders with specified ORDER_MAGIC            | 
//+------------------------------------------------------------------+ 
void DeleteAllOrdersByMagic(long const magic_number) 
  { 
   ulong order_ticket; 
//--- go through all pending orders 
   for(int i=OrdersTotal()-1;i>=0;i--) 
      if((order_ticket=OrderGetTicket(i))>0) 
         //--- order with appropriate ORDER_MAGIC 
         if(magic_number==OrderGetInteger(ORDER_MAGIC)) 
           { 
            MqlTradeResult result={0}; 
            MqlTradeRequest request={0}; 
            request.order=order_ticket; 
            request.action=TRADE_ACTION_REMOVE; 
            OrderSend(request,result); 
            //--- write the server reply to log 
            Print(__FUNCTION__,": ",result.comment," reply code ",result.retcode); 
           } 
//--- 
  } 
//+------------------------------------------------------------------+ 
//| Sets a pending order in a random way                             | 
//+------------------------------------------------------------------+ 
uint SendRandomPendingOrder(long const magic_number) 
  { 
//--- prepare a request 
   MqlTradeRequest request={0}; 
   request.action=TRADE_ACTION_PENDING;         // setting a pending order 
   request.magic=magic_number;                  // ORDER_MAGIC 
   request.symbol=_Symbol;                      // symbol 
   request.volume=0.1;                          // volume in 0.1 lots 
   request.sl=0;                                // Stop Loss is not specified 
   request.tp=0;                                // Take Profit is not specified      
//--- form the order type 
   request.type=GetRandomType();                // order type 
//--- form the price for the pending order 
   request.price=GetRandomPrice(request.type);  // open price 
//--- send a trade request 
   MqlTradeResult result={0}; 
   OrderSend(request,result); 
//--- write the server reply to log   
   Print(__FUNCTION__,":",result.comment); 
   if(result.retcode==10016) Print(result.bid,result.ask,result.price); 
//--- return code of the trade server reply 
   return result.retcode; 
  } 
//+------------------------------------------------------------------+ 
//| Returns type of a pending order in a random way                  | 
//+------------------------------------------------------------------+ 
ENUM_ORDER_TYPE GetRandomType() 
  { 
   int t=MathRand()%4; 
//---   0<=t<4 
   switch(t) 
     { 
      case(0):return(ORDER_TYPE_BUY_LIMIT); 
      case(1):return(ORDER_TYPE_SELL_LIMIT); 
      case(2):return(ORDER_TYPE_BUY_STOP); 
      case(3):return(ORDER_TYPE_SELL_STOP); 
     } 
//--- incorrect value 
   return(WRONG_VALUE); 
  } 
//+------------------------------------------------------------------+ 
//| Returns price in a random way                                    | 
//+------------------------------------------------------------------+ 
double GetRandomPrice(ENUM_ORDER_TYPE type) 
  { 
   int t=(int)type; 
//--- stop levels for the symbol 
   int distance=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL); 
//--- receive data of the last tick 
   MqlTick last_tick={0}; 
   SymbolInfoTick(_Symbol,last_tick); 
//--- calculate price according to the type 
   double price; 
   if(t==2 || t==5) // ORDER_TYPE_BUY_LIMIT or ORDER_TYPE_SELL_STOP 
     { 
      price=last_tick.bid; // depart from price Bid 
      price=price-(distance+(MathRand()%10)*5)*_Point; 
     } 
   else             // ORDER_TYPE_SELL_LIMIT or ORDER_TYPE_BUY_STOP 
     { 
      price=last_tick.ask; // depart from price Ask 
      price=price+(distance+(MathRand()%10)*5)*_Point; 
     } 
//--- 
   return(price); 
  }