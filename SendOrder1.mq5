//+------------------------------------------------------------------+
//|                                                   SendOrder1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                   TradeOrder.mq5 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include<Trade/Trade.mqh>

CTrade trade;


string file_name1= "",strt;
datetime orderDateTime=TimeCurrent();    
datetime writeDateTime=TimeLocal();
ENUM_ORDER_TYPE_TIME      e[]={ORDER_TIME_GTC};

double a,b,d,f,h;
string c,g;
void OnStart()
  {
//---



double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      strt="0.01,Bid-30*_Point,_Symbol,0,Bid-60*_Point,ORDER_TIME_GTC,0";
      a=0.01;
      b=Bid-30*_Point;
      c=_Symbol;
      d=Bid-60*_Point;
      h=0;
      
      f=0;
      g="SellStop";   
//      trade.SellStop(strt,"SellStop");
//      trade.SellStop(0.01,Bid-30*_Point,_Symbol,0,Bid-60*_Point,ORDER_TIME_GTC,0,"SellStop");
//      trade.SellLimit(volume,price,symbol,sl,tp,type_time,expir,comment)
      trade.SellStop(a,b,c,h,d,e[0],f,g);      
      
  }
void ReadFileToAlertCSV2(string FileName){
   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_CSV,";");
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }   
   Alert("=== Start ===");   
   while(!FileIsEnding(h)){
      string str=FileReadString(h);
      Alert(str);
      if(FileIsLineEnding(h)){
         Alert("---");
      }
   }
   FileClose(h);
}  