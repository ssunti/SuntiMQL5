void OnStart() 
  { 
   datetime from=0; 
   datetime to=TimeCurrent(); 
//--- request the entire history 
   HistorySelect(from,to); 
//--- variables for returning values from order properties 
   ulong    ticket; 
   double   open_price; 
   double   initial_volume; 
   datetime time_setup; 
   datetime time_done; 
   string   symbol; 
   string   type; 
   long     order_magic; 
   long     positionID; 
//--- number of current pending orders 
   uint     total=HistoryOrdersTotal(); 
//--- go through orders in a loop 
   for(uint i=0;i<total;i++) 
     { 
      //--- return order ticket by its position in the list 
      if((ticket=HistoryOrderGetTicket(i))>0) 
        { 
         //--- return order properties 
         open_price    =HistoryOrderGetDouble(ticket,ORDER_PRICE_OPEN); 
         time_setup    =(datetime)HistoryOrderGetInteger(ticket,ORDER_TIME_SETUP); 
         time_done     =(datetime)HistoryOrderGetInteger(ticket,ORDER_TIME_DONE); 
         symbol        =HistoryOrderGetString(ticket,ORDER_SYMBOL); 
         order_magic   =HistoryOrderGetInteger(ticket,ORDER_MAGIC); 
         positionID    =HistoryOrderGetInteger(ticket,ORDER_POSITION_ID); 
         initial_volume=HistoryOrderGetDouble(ticket,ORDER_VOLUME_INITIAL); 
         type          =GetOrderType(HistoryOrderGetInteger(ticket,ORDER_TYPE)); 
         //--- prepare and show information about the order 
         printf("#ticket %d %s %G %s at %G was set up at %s => done at %s, pos ID=%d", 
                ticket,                  // order ticket 
                type,                    // type 
                initial_volume,          // placed volume 
                symbol,                  // symbol 
                open_price,              // specified open price 
                TimeToString(time_setup),// time of order placing 
                TimeToString(time_done), // time of order execution or deletion 
                positionID               // ID of a position , to which the deal of the order is included 
                ); 
        } 
     } 
//--- 
  } 
//+------------------------------------------------------------------+ 
//| Returns the string name of the order type                        | 
//+------------------------------------------------------------------+ 
string GetOrderType(long type) 
  { 
   string str_type="unknown operation"; 
   switch(type) 
     { 
      case (ORDER_TYPE_BUY):            return("buy"); 
      case (ORDER_TYPE_SELL):           return("sell"); 
      case (ORDER_TYPE_BUY_LIMIT):      return("buy limit"); 
      case (ORDER_TYPE_SELL_LIMIT):     return("sell limit"); 
      case (ORDER_TYPE_BUY_STOP):       return("buy stop"); 
      case (ORDER_TYPE_SELL_STOP):      return("sell stop"); 
      case (ORDER_TYPE_BUY_STOP_LIMIT): return("buy stop limit"); 
      case (ORDER_TYPE_SELL_STOP_LIMIT):return("sell stop limit"); 
     } 
   return(str_type); 
  }