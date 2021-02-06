//+------------------------------------------------------------------+
//|                                              ModifyPosition1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

struct Data1 
  { 
   datetime time;         // Period start time 
   double   price;        // Price 
   string   type;         // The type of price 
   string   ctype;         // The change of price
  };

int OnInit()
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
//--- number of current positions and pending orders 
   uint     total=OrdersTotal();
   uint     total1=PositionsTotal();
   Print("Positions "+total1+" Pending order "+total); 
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
      Print(total1);
   for(uint i=0;i<total1;i++) 
     { 
      //--- return order ticket by its position in the list 
      if((ticket=PositionGetTicket(i))>0) 
        { 
         //--- return order properties 
         open_price    =PositionGetDouble(POSITION_PRICE_OPEN); 
         time_setup    =(datetime)PositionGetInteger(POSITION_TIME); 
         symbol        =PositionGetString(POSITION_SYMBOL); 
         order_magic   =PositionGetInteger(POSITION_MAGIC); 
         positionID    =PositionGetInteger(POSITION_IDENTIFIER); 
         initial_volume=PositionGetDouble(POSITION_VOLUME); 
         type          =EnumToString(ENUM_POSITION_TYPE(PositionGetInteger(POSITION_TYPE))); 
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
   

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
