//+------------------------------------------------------------------+
//|                                                  ForexToFile.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
string allsyms[];
string Currency[] =  {  "EUR", "GBP", "AUD", "NZD", "USD", "CAD", "CHF", "JPY" };
string Currency1[] =  {  "EUR", "GBP", "AUD", "NZD", "USD", "CAD", "CHF", "JPY" };
int Sym = ArrayRange(Currency, 0);
int Sym1 = ArrayRange(Currency1, 0);
string TradePair[];
string file_name1= "InputFile1.txt";
string file_name2= "Combined_Report.txt";
int file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
int file_handle2 = FileOpen(file_name2,FILE_READ|FILE_WRITE|FILE_TXT);

string Out1="", OutT="";
int str_find=0;

ENUM_TIMEFRAMES      period[]={PERIOD_W1,PERIOD_D1,PERIOD_H4,PERIOD_H1,PERIOD_M15,PERIOD_M5};
double myPriceArray[];

int OnStart()
  {
   if(file_handle1==INVALID_HANDLE)
      {
      Print("Error opening rep-file: "+file_name1);
      }
  CreateSymbolList();

for (int j=0; j < 6; j++)
{

Out1="";
Print(EnumToString(period[j]));
datetime compilation_time=TimeLocal();
Out1=TimeToString(compilation_time)+" "+EnumToString(period[j])+" ATR(1)";
SaveToFile(file_handle2,Out1);


  for (int i = 0; i < (ArraySize(TradePair)); i++) 
      {
      ArrayFree(myPriceArray);
      
      int ATRDefinition=iATR(TradePair[i],period[j],1);
      ArraySetAsSeries(myPriceArray,true);
      CopyBuffer(ATRDefinition,0,0,3,myPriceArray);
      Out1="";
      double ATRValue=NormalizeDouble(myPriceArray[0],5);
      double ATRValue1=NormalizeDouble(myPriceArray[1],5);
      double ATRValue2=NormalizeDouble(myPriceArray[2],5);
      
      str_find=StringFind(TradePair[i],"JPY",0);
      if (str_find==-1)
      {
      ATRValue=ATRValue*100000;
      ATRValue1=ATRValue1*100000;
      ATRValue2=ATRValue2*100000;
      Print("===="+str_find+"=====");
      }
      else
      {
      ATRValue=ATRValue*1000;
      ATRValue1=ATRValue1*1000;
      ATRValue2=ATRValue2*1000;
      }
      if (TradePair[i]=="XAUUSD.m")
      {
      ATRValue=ATRValue/100000;
      ATRValue1=ATRValue1/100000;
      ATRValue2=ATRValue2/100000;
      }
      str_find=0;
      
      OutT=StringFormat("%d\t %s\t %f\t %f\t %f\t %s",i,TradePair[i],ATRValue,ATRValue1,
                        ATRValue2,EnumToString(period[j]));
      Out1=Out1+OutT;                  
      SaveToFile(file_handle2,Out1);
      
      Print(i+" "+TradePair[i]);
      }
}
   return(INIT_SUCCEEDED);
  }
string CreateSymbolList()
   {
   string TempSymbol;
   int SymbolCount=0;
//Money Pair Name for Broker Robo Forex use ".m"
//   string suffix=".m";
//Money Pair Name for Broker XM use "#"
   string suffix="";

   for (int i = 0; i < Sym+1; i++) 
      {
      for (int a = i+1; a < Sym; a++) 
         {
         TempSymbol = Currency[i] + Currency[a] + suffix;
         ArrayResize(TradePair, SymbolCount + 1);
         if (Currency[i]!=Currency[a])
            {
            TradePair[SymbolCount] = TempSymbol;
            SaveToFile(file_handle1,TempSymbol);
            SymbolCount++;
            }
         }
      }
      ArrayResize(TradePair, ArraySize(TradePair) + 1);
      TradePair[(ArraySize(TradePair)-1)]="GOLD";
      SaveToFile(file_handle1,TradePair[(ArraySize(TradePair)-1)]);
         
     
   return TempSymbol ;
   }
string SaveToFile(int filehandle,string Out2)
   {
   FileSeek(filehandle,0,SEEK_END);
   FileWrite(filehandle,Out2);
   return Out2;
   }
