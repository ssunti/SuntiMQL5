//+------------------------------------------------------------------+
//|                                                NewMACDTrade1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>

CTrade trade;

datetime orderDateTime=TimeCurrent();    
datetime writeDateTime=TimeLocal();

//ENUM_TIMEFRAMES      period[]={PERIOD_MN1,PERIOD_W1,PERIOD_D1,PERIOD_H1,PERIOD_M30,PERIOD_M5};
ENUM_TIMEFRAMES      period[]={PERIOD_M5};
//int                  numCan[]={50,200      ,500      ,1000     ,1000     ,2000     };
int                  numCan[]={4000     };


void OnStart()
  {

      string output_string,str,strt;

      MqlDateTime str1,str2;
      TimeToStruct(orderDateTime,str1); 
      TimeToStruct(writeDateTime,str2);        
      strt=IntegerToString(str2.day,2,'0')+IntegerToString(str2.mon,2,'0')+IntegerToString(str2.year);
      strt=strt+IntegerToString(str2.hour,2,'0')+IntegerToString(str2.min,2,'0')+IntegerToString(str2.sec,2,'0');
      
      str=_Symbol;
      string statusComment = EnumToString(_Period);
string   file_name1 = "/MACDTrade1/"+str+"Anlysis2Data"+strt+".txt";
string   file_name2 = "/MACDTrade1/"+str+"DownData"+strt+".txt";
int file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
int file_handle2 = FileOpen(file_name2,FILE_READ|FILE_WRITE|FILE_TXT);

double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   
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
   
   double         MACDBuffer[]; 
   double         SignalBuffer[];
   
   
   ArraySetAsSeries(MACDBuffer,true);
   ArraySetAsSeries(SignalBuffer,true);
   
    
   int MACDdefinition = iMACD(_Symbol,_Period,8,17,9,PRICE_CLOSE);
   
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
   
   Print(MyMACDValue0," ",MyMACDValue1," ",MyMACDValue2," ",MyMACDValue3);
   Print(Bid," ",Ask," ",Bid-500*_Point," ",Ask-500*_Point," ",Bid+500*_Point," ",Ask+500*_Point);
   
   if (MyMACDValue1 < MySignalValue2)
      {
         Print("----"," ",MyMACDValue1," ",MyMACDValue2);
         if (MyMACDValue2 > MyMACDValue3)
            {
               Print("----<<<<sell"," ",MyMACDValue2," ",MyMACDValue3);
               Print("----<<<<sell"," ",EnumToString(_Period));
               statusComment = "sell "+statusComment;
               //trade.Sell(0.1,_Symbol,0,0,0,statusComment);
               trade.Sell(0.1,_Symbol,0,0,Bid-500*_Point,statusComment);
            }
        
      }
   else
      {
         Print("++++"," ",MyMACDValue1," ",MyMACDValue2);
         if (MyMACDValue2 < MyMACDValue3)
            {
               Print("++++>>>>buy"," ",MyMACDValue2," ",MyMACDValue3);
               Print("++++>>>>buy"," ",EnumToString(_Period));
               statusComment = "buy "+statusComment;
               //trade.Buy(0.1,_Symbol,0,0,0,statusComment);
               trade.Buy(0.1,_Symbol,0,0,Ask+500*_Point,statusComment);
            }
      }
   
   
   
   
  }
string SaveToFile(int filehandle,string Out2)
   {
   FileSeek(filehandle,0,SEEK_END);
   FileWrite(filehandle,Out2);
   return Out2;
   }
   