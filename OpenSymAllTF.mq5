//+------------------------------------------------------------------+
//|                                                 OpenSymAllTF.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int num_sym=0;
string name_sym="";

void OnStart()
  {
//---
   num_sym = SymbolsTotal(true);
Print(num_sym);   
   for (int j=0; j < num_sym; j++)
      {
       name_sym = SymbolName(j,true);
Print(IntegerToString(j+1)+" "+name_sym);   
    
      }
  }
