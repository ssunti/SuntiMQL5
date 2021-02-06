//+------------------------------------------------------------------+
//|                                                    NewOrder1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>

#define NUM_RATES 3

//--- globals
CTrade			g_trade;					// trade object
double			g_pointSize = 0.;		// initialize to ludicrous value
//--- handles
int				g_handleAtr = 0;
//--- arrays
MqlRates			g_rates[];
double			g_atr[];

//--- input parameters
input double	SL_ATR_FACTOR = 1.75;			// ATR Factor to determine distance to place SL
input int		AR_FIXED_TRAILING_PTS = 2700;	// Max points to keep SL from prices while trailing
input int		InpAtrPeriod = 14;				// ATR Period

//--- constants
const long		MAGIC_NUMBER = 5678900;
const double	TRADE_VOLUME = 0.10;				// For strategy development, fixed lot size of 0.10 is good
const int		CHART_ID = 0;						// Current chart
const int		SUB_WINDOW = 0;					// Main Window

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

void OnStart()
  {
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
Print("ASK ",Ask," ",Bid);
   
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
      
      double UpperBandArray[];
      double LowerBandArray[];
      double MiddleBandArray[];
   
      ArraySetAsSeries(UpperBandArray,true);
      ArraySetAsSeries(LowerBandArray,true);
      ArraySetAsSeries(MiddleBandArray,true);
   
      int BollingerBandsDefinition=iBands(_Symbol,_Period,100,0,2,PRICE_CLOSE);
        
      CopyBuffer(BollingerBandsDefinition,1,0,100,UpperBandArray);
      CopyBuffer(BollingerBandsDefinition,2,0,100,LowerBandArray);
      CopyBuffer(BollingerBandsDefinition,0,0,100,MiddleBandArray);
      
      int BBTotal = ArraySize(UpperBandArray);
Print(BBTotal);         
      double MyUpperBandValue=UpperBandArray[0];
      double MyLowerBandValue=LowerBandArray[0];
      double MyMiddleBandValue=MiddleBandArray[0];
Print("BB ",(UpperBandArray[0]-LowerBandArray[0])/2," ",(UpperBandArray[0]-MiddleBandArray[0])," ",MiddleBandArray[0]);      

      datetime date1=D'2020.11.15 00:00:00'; 
      datetime date2=D'2020.11.28 23:59:00';
      MqlRates PriceInfo[];
      ArraySetAsSeries(PriceInfo,true);
      int Data=CopyRates(Symbol(),Period(),date1,date2,PriceInfo);
      
Print("ATR{0} ",(PriceInfo[1].high-PriceInfo[1].low),4);

      double         ATRBuffer[]; 
   
      ArraySetAsSeries(ATRBuffer,true);
    
      int ATRdefinition = iATR(_Symbol,_Period,14);
   
      CopyBuffer(ATRdefinition,0,0,4,ATRBuffer);
   
      double   MyATRValue0 = ATRBuffer[0]; 
      
   
Print("ATR[14] ",MyATRValue0," ",(PriceInfo[1].high-PriceInfo[1].low)/MyATRValue0*100," ",MyATRValue0/(UpperBandArray[0]-LowerBandArray[0])*100);


      double         MACDBuffer[]; 
      double         SignalBuffer[];
   
   
      ArraySetAsSeries(MACDBuffer,true);
      ArraySetAsSeries(SignalBuffer,true);
   
    
      int MACDdefinition = iMACD(_Symbol,_Period,6,11,9,PRICE_CLOSE);
   
      CopyBuffer(MACDdefinition,0,0,4,MACDBuffer);
      CopyBuffer(MACDdefinition,1,0,4,SignalBuffer);
   
      double   MyMACDValue0 = MACDBuffer[0]; 
      double   MySignalValue0 = SignalBuffer[0];
      double   MyMACDValue1 = MACDBuffer[1]; 
      double   MySignalValue1 = SignalBuffer[1];
      double   MyMACDValue2 = MACDBuffer[2]; 
      double   MySignalValue2 = SignalBuffer[2];
      double   MyMACDValue3 = MACDBuffer[3]; 
      double   MySignalValue3 = SignalBuffer[3];
   
Print("MACD ",MyMACDValue0);
      

  }
int OnInit()
  {
//---
//   g_trade.SetExpertMagicNumber(MAGIC_NUMBER);

   g_pointSize = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   PrintFormat("g_pointSize is [%.5f]", g_pointSize);

//--- ATR
   g_handleAtr = iATR(_Symbol,			// symbol
                      _Period,			// period
                      InpAtrPeriod);	// atr_period
   if(g_handleAtr == INVALID_HANDLE)
     {
      PrintFormat("%s(): Error creating iATR indicator handle for [%s] [%d]", _Symbol, _Period);
      return INIT_FAILED;
     }

   ArrayResize(g_rates, NUM_RATES);
   ArraySetAsSeries(g_rates, true);
   ArrayResize(g_atr, NUM_RATES);
   ArraySetAsSeries(g_atr, true);

//--- ok
   Print("INIT_SUCCEEDED for EA!");
//---
   return(INIT_SUCCEEDED);
  }
void OnTick()
  {
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
Print("ASK ",Ask," ",Bid);
//--- Bar level functionality
   if(IsNewBar(_Symbol, _Period))
     {
      //--- Need data or we've got nothing
      if(! RefreshData())
        {
         Print("Couldn't refresh data");
         return;
        }

      //--- See if a position is already open
      if(SelectPosition(_Symbol, MAGIC_NUMBER))
        {
         // Position is open, so adjust risk as necessary
         FixedTrailingStop();
        }
      else
        {
         //--- No position open, so look for signal
//         CheckForOpenSignal();
        }

      //--- Draw every Doji whether we place a trade or not
//      if(IsDoji(g_rates[1]))
        {
//         DrawArrow(g_rates[1].time, g_rates[1].low - .333 * g_atr[1], ARROW_UP, Yellow, "Doji");
        }
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

   return isNewBar;
  }
bool RefreshData(void)
  {
//--- go trading only for first ticks of new bar
   if(CopyRates(_Symbol, _Period, 0, NUM_RATES, g_rates) != NUM_RATES)
     {
      Print("CopyRates of ", _Symbol, " failed, no history");
      return false;
     }

//--- get current ATR
   if(g_handleAtr != INVALID_HANDLE)
     {
      if(CopyBuffer(g_handleAtr, 0, 0, NUM_RATES, g_atr) != NUM_RATES)
        {
         Print("CopyBuffer from iATR failed, no data");
         return false;
        }
     }

   return true;
  }

bool SelectPosition(const string symbol, const ulong magicNumber)
  {
//--- Do we have an open position?
   if(!PositionSelect(symbol))
     {
      //--- No position is open for this symbol
      return false;
     }
   else
     {
      //--- We found a position for this symbol, but is it one of ours?
      return(PositionGetInteger(POSITION_MAGIC) == magicNumber);
     }

   return false;
  }

bool FixedTrailingStop(void)
  {
   CPositionInfo	g_positionInfo;			// MQL standard library for positions
   double			slDPts = 0.;			// SL distance points
   double			plDPts = 0.;			// Profit/Loss distance points

//--- Get the step amount.
//--- This sort of assumes that the original SL was set at N*ATR in the first place;
//--- otherwise, you will get a big jump the first time, or it won't move at all.
   const double fixedDPts = AR_FIXED_TRAILING_PTS * g_pointSize;

   double price = 0.;							// Current price (ASK or BID)
   const double open = g_positionInfo.PriceOpen();
   const double sl = g_positionInfo.StopLoss();
   const ENUM_POSITION_TYPE positionType = g_positionInfo.PositionType();

   switch(positionType)
     {
      case POSITION_TYPE_BUY:
         price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
         slDPts = price - sl;
         plDPts = price - open;		// Profit Loss is determined from the open
         break;
      case POSITION_TYPE_SELL:
         price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
         slDPts = sl - price;
         plDPts = open - price;
         break;
      default:
         PrintFormat("Unknown position type [%s]", EnumToString(positionType));
         ExpertRemove();
     }

//--- Is the distance from slDPts (price to SL) greater than the trailing ATR distance?
   if(slDPts > fixedDPts)
     {
      //--- Never move SL when unprofitable, e.g. lower volatility.
      const double spread = (double) SymbolInfoInteger(_Symbol, SYMBOL_SPREAD) * g_pointSize;
      if(plDPts < spread)
        {
         // not profitable
         return false;
        }

      double newSL = -1.;		// Start with ridiculous value
      switch(positionType)
        {
         case POSITION_TYPE_BUY:
            newSL = g_rates[1].close - fixedDPts;
            break;
         case POSITION_TYPE_SELL:
            newSL = g_rates[1].close + fixedDPts;
            break;
         default:
            PrintFormat("Unknown position type [%s]", EnumToString(positionType));
            ExpertRemove();
        }

      //--- Don't request a move if the new SL is essentially the same as the old one.
      if(MathAbs(newSL - sl) < g_pointSize)
        {
         return false;
        }

      //--- Move SL absolute
      bool modified = PositionModify(g_trade, g_positionInfo, _Symbol, newSL, NULL);
      if(modified)
        {
//         DrawLine(newSL, Red);
Print("");
        }
      return modified;
     }
   return false;
  }

bool PositionModify(CTrade& trade,
                    CPositionInfo& position,
                    const string symbol,
                    const double sl,
                    double tp = NULL)
  {

//--- additional checking
   if(! TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
     {
      PrintFormat("%s(%s): Error [TERMINAL_TRADE_ALLOWED]", __FUNCTION__, symbol);
      return false;
     }

   const ENUM_POSITION_TYPE positionType = position.PositionType();
   const double price = position.PriceOpen();
   if(tp == NULL)
     {
      tp = position.TakeProfit();
     }

//--- Ensure TP and SL meet minimum server levels.
   const ENUM_ORDER_TYPE orderType = (positionType == POSITION_TYPE_BUY) ? ORDER_TYPE_BUY : ORDER_TYPE_SELL;
//   if(! CheckStopsLevel(orderType, symbol, price, sl))
     {
      return false;
     }

//--- Do a broker modify
   bool modified = trade.PositionModify(symbol, sl, tp);
   if(!modified)
     {
      PrintFormat("%s(%s) Error: Retcode [%d] : '%s'", __FUNCTION__, symbol, trade.ResultRetcode(), trade.ResultComment());
      return false;
     }

   return true;
  }