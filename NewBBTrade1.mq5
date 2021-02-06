//+------------------------------------------------------------------+
//|                                                  NewBBTrade1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

#include <Trade\Trade.mqh>

CTrade trade;

struct DataH 
  { 
   double   high;         // The highest price of the period 
   datetime time;         // Period start time 
  };

/*struct MqlRates 
  { 
   datetime time;         // Period start time 
   double   open;         // Open price 
   double   high;         // The highest price of the period 
   double   low;          // The lowest price of the period 
   double   close;        // Close price 
   long     tick_volume;  // Tick volume 
   int      spread;       // Spread 
   long     real_volume;  // Trade volume 
  };
*/

//ENUM_TIMEFRAMES      period[]={PERIOD_MN1,PERIOD_W1,PERIOD_D1,PERIOD_H1,PERIOD_M30,PERIOD_M5};
ENUM_TIMEFRAMES      period[]={PERIOD_M5};
//int                  numCan[]={50,200      ,500      ,1000     ,1000     ,2000     };
int                  numCan[]={4000     };


/*
TimeToStruct(orderDateTime,str1);
#TimeToStruct(orderDateTime,str1); 
TimeToStruct(writeDateTime,str2);
strt=IntegerToString(str2.day,2,'0')+IntegerToString(str2.mon,2,'0')+IntegerToString(str2.year);
strt=strt+IntegerToString(str2.hour,2,'0')+IntegerToString(str2.min,2,'0')+IntegerToString(str2.sec,2,'0');
     
str=_Symbol;

string   file_name1 = "/MACDTrade1/"+str+"Anlysis2Data"+strt+".txt";
string   file_name2 = "/MACDTrade1/"+str+"DownData"+strt+".txt";
int file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
int file_handle2 = FileOpen(file_name2,FILE_READ|FILE_WRITE|FILE_TXT);
*/
string statusComment = EnumToString(_Period);
double oldData = 0.0;
int noTrade = 2,JJ=0;



void OnTick()
  {
   datetime date1=D'2020.11.02 00:00:00'; 
   datetime date2=D'2020.11.03 23:59:00';
   datetime orderDateTime=TimeCurrent();    
   datetime writeDateTime=TimeLocal();
   string output_string,str,strt;
   MqlDateTime str1,str2;
   TimeToStruct(orderDateTime,str1);
   TimeToStruct(writeDateTime,str2);
//Print(str1," ",str2);
Print(date1," ",date2);
      
      
   MqlRates PriceInfo[];
   ArraySetAsSeries(PriceInfo,true);
   int Data=CopyRates(Symbol(),Period(),date1,date2,PriceInfo);
  
//---
   double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   statusComment = EnumToString(_Period);
   
//   SaveToFile(file_handle1,_Symbol);
//   SaveToFile(file_handle2,_Symbol);

   double UpperBandArray[];
   double LowerBandArray[];
   double MiddleBandArray[];
   
   ArraySetAsSeries(UpperBandArray,true);
   ArraySetAsSeries(LowerBandArray,true);
   ArraySetAsSeries(MiddleBandArray,true);
   
   int BollingerBandsDefinition=iBands(_Symbol,_Period,20,0,2,PRICE_CLOSE);
   
   CopyBuffer(BollingerBandsDefinition,1,0,3,UpperBandArray);
   CopyBuffer(BollingerBandsDefinition,2,0,3,LowerBandArray);
   CopyBuffer(BollingerBandsDefinition,0,0,3,MiddleBandArray);
   
   double MyUpperBandValue=UpperBandArray[0];
   double MyLowerBandValue=LowerBandArray[0];
   double MyMiddleBandValue=MiddleBandArray[0];
   double MyUpperBandValue1=UpperBandArray[1];
   double MyLowerBandValue1=LowerBandArray[1];
   double MyMiddleBandValue1=MiddleBandArray[1];

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
   
//      Print(MyMACDValue0," ",MyMACDValue1," ",MyMACDValue2," ",MyMACDValue3);
//      Print(Bid," ",Ask," ",Bid-500*_Point," ",Ask-500*_Point," ",Bid+500*_Point," ",Ask+500*_Point);
Print(ArraySize(PriceInfo));
//         for (int i=(ArraySize(PriceInfo)-10);i<=(ArraySize(PriceInfo))-1;i++)
   for (int i=0;i<=(ArraySize(PriceInfo))-1;i++)
      {
               
//         Print(i+" "+TimeToString(PriceInfo[i].time));
      }
   }
//+------------------------------------------------------------------+
string SaveToFile(int filehandle,string Out2)
   {
   FileSeek(filehandle,0,SEEK_END);
   FileWrite(filehandle,Out2);
   return Out2;
   }
   