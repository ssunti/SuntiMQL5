void OnStart() 
  { 
//--- variables for returning values from order properties 
   ulong    ticket; 
   double   open_price; 
   double   initial_volume; 
   datetime time_setup; 
   string   symbol; 
   string   type; 
   long     order_magic; 
   long     positionID; 
//--- number of current pending orders 
   uint     total=OrdersTotal();
   Print(total); 
//--- go through orders in a loop 
   for(uint i=0;i<total;i++) 
     { 
      //--- return order ticket by its position in the list 
      if((ticket=OrderGetTicket(i))>0) 
        { 
         //--- return order properties 
         open_price    =OrderGetDouble(ORDER_PRICE_OPEN); 
         time_setup    =(datetime)OrderGetInteger(ORDER_TIME_SETUP); 
         symbol        =OrderGetString(ORDER_SYMBOL); 
         order_magic   =OrderGetInteger(ORDER_MAGIC); 
         positionID    =OrderGetInteger(ORDER_POSITION_ID); 
         initial_volume=OrderGetDouble(ORDER_VOLUME_INITIAL); 
         type          =EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE))); 
         //--- prepare and show information about the order 
         printf("#ticket %d %s %G %s at %G was set up at %s", 
                ticket,                 // order ticket 
                type,                   // type 
                initial_volume,         // placed volume 
                symbol,                 // symbol 
                open_price,             // specified open price 
                TimeToString(time_setup)// time of order placing 
                ); 
        } 
     } 
//--- 
  }