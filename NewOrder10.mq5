//+------------------------------------------------------------------+
//|                                                    NewOrder3.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

MqlRates rates[],rates1[];          // To be used to store the prices, volumes and spread of each bar

double diffHigh1,diffHigh2,diffLow1,diffLow2;
string format;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
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
void OnTick()
  {
//---
//   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
//   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
//Print("ASK ",Ask," ",Bid);
/*
     Let's make sure our arrays values for the Rates
     is store serially similar to the timeseries array
*/
//--- the rates arrays
   ArraySetAsSeries(rates,true);
   
//--- Bar level functionality
   if(IsNewBar(_Symbol, _Period))
     {
      //--- get the details of the latest 3 bars
      if(CopyRates(_Symbol,_Period,0,3,rates)<0)
         {
            Alert("Error copying rates/history data - error:",GetLastError(),"!!");
            return;
         }
      format="open = %G, high = %G, low = %G, close = %G, volume = %d"; 
      string out="";
      int copied=CopyRates(_Symbol,_Period,0,5,rates1);
      int size=fmin(copied,99999);
      for(int i=copied-3;i>=2;i--)
        { 
         out=i+":"+TimeToString(rates1[i].time); 
         out=out+" "+StringFormat(format, 
                                  rates1[i].open, 
                                  rates1[i].high, 
                                  rates1[i].low, 
                                  rates1[i].close, 
                                  rates1[i].tick_volume); 
Print(out);
         diffHigh1=(rates1[i].high-rates1[i-1].high);
         diffHigh2=(rates1[i-1].high-rates1[i-2].high);
         diffLow1=(rates1[i].low-rates1[i-1].low);
         diffLow2=(rates1[i-1].low-rates1[i-2].low);
         if (diffHigh1<=0 && diffHigh2>=0)
            {
               Print("Sell");
            }
         if (diffLow1>=0 && diffLow2<=0)
            {
               Print("Buy");
            }
            out="";
         }
Print("test");     
     }
     else
     {
      string out="";
      format="open = %G, high = %G, low = %G, close = %G, volume = %d"; 
      int copied=CopyRates(_Symbol,_Period,0,5,rates1);
      int size=fmin(copied,99999);
      for(int i=copied-3;i>=2;i--)
        { 
         out=i+":"+TimeToString(rates1[i].time); 
         out=out+" "+StringFormat(format, 
                                  rates1[i].open, 
                                  rates1[i].high, 
                                  rates1[i].low, 
                                  rates1[i].close, 
                                  rates1[i].tick_volume); 
Print(out);
         diffHigh1=(rates1[i].high-rates1[i-1].high);
         diffHigh2=(rates1[i-1].high-rates1[i-2].high);
         diffLow1=(rates1[i].low-rates1[i-1].low);
         diffLow2=(rates1[i-1].low-rates1[i-2].low);
         if (diffHigh1<=0 && diffHigh2>=0)
            {
               Print("Sell");
            }
         if (diffLow1>=0 && diffLow2<=0)
            {
               Print("Buy");
            }
            out="";
         }
Print("test*******",rates1[4].time," ",rates1[4].high," ",rates1[4].high); 
     }
   
  }
//+------------------------------------------------------------------+
bool IsNewBar(const string symbol, const ENUM_TIMEFRAMES period)
  {
   bool isNewBar = false;
   static datetime priorBarOpenTime = NULL;

//--- SERIES_LASTBAR_DATE == Open time of the last bar of the symbol-period
   const datetime currentBarOpenTime = (datetime) SeriesInfoInteger(symbol, period, SERIES_LASTBAR_DATE);

   if(priorBarOpenTime != currentBarOpenTime)
     {
      //--- Don't want new bar just because EA started
      isNewBar = (priorBarOpenTime == NULL) ? false : true;	// priorBarOpenTime is only NULL once

      //--- Regardless of new bar, update the held bar time
      priorBarOpenTime = currentBarOpenTime;
     }
//Print(currentBarOpenTime," ",priorBarOpenTime);
   return isNewBar;
  }