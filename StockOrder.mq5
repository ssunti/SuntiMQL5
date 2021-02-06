//+------------------------------------------------------------------+
//|                                                   StockOrder.mq5 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

string file_name1= "",strt;
datetime orderDateTime=TimeCurrent();    
datetime writeDateTime=TimeLocal();
int OnStart()
  {
//---
      MqlDateTime str1,str2; 
      TimeToStruct(orderDateTime,str1); 
      TimeToStruct(writeDateTime,str2); 
      printf("%02d.%02d.%4d %02d:%02d:%02d, day of year = %d, day of week = %d",str1.day,str1.mon, 
          str1.year,str1.hour,str1.min,str1.sec,str1.day_of_year,str1.day_of_week); 
      printf("%02d.%02d.%4d, day of year = %d",str2.day,str2.mon, 
          str2.year,str2.day_of_year); 
      Print(orderDateTime," ",writeDateTime);
      strt=IntegerToString(str2.day,2,'0')+IntegerToString(str2.mon,2,'0')+IntegerToString(str2.year);
      strt=strt+IntegerToString(str2.hour,2,'0')+IntegerToString(str2.min,2,'0')+IntegerToString(str2.sec,2,'0');
      file_name1 = "/HeadQuater/StockOrder"+strt+".txt";
      Print(file_name1);
      int file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
      
   int   cb=0,cs=0;
   string orderStr="";
   for(int i=PositionsTotal()-1;i>=0;i--)
      {
      string symbol = PositionGetSymbol(i);
      ulong PositionTicket=PositionGetInteger(POSITION_TICKET);
      datetime PositionTime=PositionGetInteger(POSITION_TIME);
      double CurrentPrice=PositionGetDouble(POSITION_PRICE_OPEN);
      double CurrentStopLoss=PositionGetDouble(POSITION_SL);
      double CurrentTraget=PositionGetDouble(POSITION_TP);
      double CurrentVolume=PositionGetDouble(POSITION_VOLUME);
      double CurrentPriceCurent=PositionGetDouble(POSITION_PRICE_CURRENT);
      double CurrentSwap=PositionGetDouble(POSITION_SWAP);
      double CurrentProfit=PositionGetDouble(POSITION_PROFIT);
      string CurrentComent=PositionGetString(POSITION_COMMENT);
      string Ticket=EnumToString(ENUM_POSITION_TYPE(PositionGetInteger(POSITION_TICKET)));
      string PositionType=EnumToString(ENUM_POSITION_TYPE(PositionGetInteger(POSITION_TYPE)));
      
      orderStr=symbol+","+PositionTicket+","+PositionTime;
      orderStr=orderStr+","+StringSubstr(PositionType,14)+","+DoubleToString(CurrentVolume,2);
      orderStr=orderStr+","+DoubleToString(CurrentPrice,3)+","+DoubleToString(CurrentStopLoss,3);
      orderStr=orderStr+","+DoubleToString(CurrentTraget,3)+","+DoubleToString(CurrentPriceCurent,3);
      orderStr=orderStr+","+DoubleToString(CurrentSwap,3)+","+DoubleToString(CurrentProfit,3)+","+CurrentComent;
      if (StringSubstr(PositionType,14)=="SELL")
         {
         cs=cs+1;
         }
      if (StringSubstr(PositionType,14)=="BUY")
         {
         cb=cb+1;
         }
         
      SaveToFile(file_handle1,orderStr);
         
      }      
      return(INIT_SUCCEEDED);
  }
string SaveToFile(int filehandle,string Out2)
   {
   FileSeek(filehandle,0,SEEK_END);
   FileWrite(filehandle,Out2);
   return Out2;
   }