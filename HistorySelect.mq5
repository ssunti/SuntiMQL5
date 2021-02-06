void OnStart() 
  { 
   color BuyColor =clrBlue; 
   color SellColor=clrRed; 
//--- request trade history 
   HistorySelect(0,TimeCurrent()); 
//--- create objects 
   string   name; 
   uint     total=HistoryDealsTotal(); 
   ulong    ticket=0; 
   double   price; 
   double   profit; 
   datetime time; 
   string   symbol; 
   long     type; 
   long     entry; 
//--- for all deals 
Print(total);
   for(uint i=0;i<total;i++) 
     { 
      //--- try to get deals ticket 
      if((ticket=HistoryDealGetTicket(i))>0) 
        { 
         //--- get deals properties 
         price =HistoryDealGetDouble(ticket,DEAL_PRICE); 
         time  =(datetime)HistoryDealGetInteger(ticket,DEAL_TIME); 
         symbol=HistoryDealGetString(ticket,DEAL_SYMBOL); 
         type  =HistoryDealGetInteger(ticket,DEAL_TYPE); 
         entry =HistoryDealGetInteger(ticket,DEAL_ENTRY); 
         profit=HistoryDealGetDouble(ticket,DEAL_PROFIT);
         Print(symbol+" "+DoubleToString(type)+" "+TimeToString(time)+" "+DoubleToString(price)+" "+ DoubleToString(entry)+" "+DoubleToString(profit));
         //--- only for current symbol 
         if(price && time && symbol==Symbol()) 
           { 
            //--- create price object 
            name="TradeHistory_Deal_"+string(ticket); 
            if(entry) ObjectCreate(0,name,OBJ_ARROW_RIGHT_PRICE,0,time,price,0,0); 
            else      ObjectCreate(0,name,OBJ_ARROW_LEFT_PRICE,0,time,price,0,0); 
            //--- set object properties 
            ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
            ObjectSetInteger(0,name,OBJPROP_BACK,0); 
            ObjectSetInteger(0,name,OBJPROP_COLOR,type?BuyColor:SellColor); 
            if(profit!=0) ObjectSetString(0,name,OBJPROP_TEXT,"Profit: "+string(profit)); 
           } 
        } 
     } 
//--- apply on chart 
   ChartRedraw(); 
  }