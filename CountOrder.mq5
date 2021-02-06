void OnStart()
  {
   int   cb=0,cs=0;
   for(int i=PositionsTotal()-1;i>=0;i--)
      {
      string symbol = PositionGetSymbol(i);
      ulong PositionTicket=PositionGetInteger(POSITION_TICKET);
      double CurrentPrice=PositionGetDouble(POSITION_PRICE_OPEN);
      double CurrentStopLoss=PositionGetDouble(POSITION_SL);
      double CurrentTraget=PositionGetDouble(POSITION_TP);
      string Ticket=EnumToString(ENUM_POSITION_TYPE(PositionGetInteger(POSITION_TICKET)));
      string PositionType=EnumToString(ENUM_POSITION_TYPE(PositionGetInteger(POSITION_TYPE)));
      if (StringSubstr(PositionType,14)=="SELL")
         {
         cs=cs+1;
         }
      if (StringSubstr(PositionType,14)=="BUY")
         {
         cb=cb+1;
         }
      }
Print("Number Order=",PositionsTotal()," Order Buy=",cb," Order Sell=",cs);   
  }