//+------------------------------------------------------------------+
//|                                               PipCalculator1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\SymbolInfo.mqh>

double point;
double pipvalue;
double Lotsize=1;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
      point = Point();
      MqlTick last_tick; 
      Print(AccountInfoString(ACCOUNT_CURRENCY));
      Print(DoubleToString(Lotsize,2));
      Print(last_tick.last*point);
      Print(last_tick.volume);
//    Print(last_tick.volume_real);
//---
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
