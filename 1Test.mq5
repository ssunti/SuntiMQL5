string allsyms[];
string Currency[] =  {  "EUR", "GBP", "AUD", "NZD", "USD", "CAD", "CHF", "JPY" };
int Sym = ArrayRange(Currency, 0);
string TradePair[];
string file_name1= "InputFile1.txt";
string file_name2= "OutputFile1.txt";
int filehandle;
int file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
int file_handle2 = FileOpen(file_name2,FILE_READ|FILE_WRITE|FILE_TXT);
string str,Out1="", OutT="";
int str_size,str_find=0;

ENUM_TIMEFRAMES      period[]={PERIOD_D1};
double myPriceArray[];

int OnStart()
  {
   if(file_handle1==INVALID_HANDLE)
      {
      Print("Error opening rep-file: "+file_name1);
      }
  CreateSymbolList();
  TradePair[27]="XAUUSD.m";
  filehandle=file_handle1;
  SaveToFile(filehandle,TradePair[27]);
  FileClose(filehandle);
  
  file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
  while (!FileIsEnding(file_handle1))
   {
      str_size=FileReadInteger(file_handle1,INT_VALUE); 
      str=FileReadString(file_handle1,str_size);
      str_size=StringLen(str);
      
      double Ask=NormalizeDouble(SymbolInfoDouble(str,SYMBOL_ASK),_Digits);
      double Bid=NormalizeDouble(SymbolInfoDouble(str,SYMBOL_BID),_Digits);

      ArrayFree(myPriceArray);
      
      int ATRDefinition=iATR(str,period[0],1);
      ArraySetAsSeries(myPriceArray,true);
      CopyBuffer(ATRDefinition,0,0,3,myPriceArray);
      Out1="";
      double ATRValue=NormalizeDouble(myPriceArray[0],5);
      double ATRValue1=NormalizeDouble(myPriceArray[1],5);
      double ATRValue2=NormalizeDouble(myPriceArray[2],5);
      
      MqlRates rates[];
      ArraySetAsSeries(rates,true); 
      int copied=CopyRates(str,period[0],0,10,rates);

      double LowCurrent=rates[0].low;
      double HighCurrent=rates[0].high;
      double ATRCurrent=(HighCurrent-LowCurrent);
      double PercentATR=((ATRValue1-ATRCurrent)/ATRValue1)*100;
      filehandle=file_handle2;
      Out1=str+" "+Ask+" "+Bid+" "+ATRValue+" "+LowCurrent+" "+HighCurrent+" "+ATRCurrent+" "+PercentATR+" "+ATRValue1;      
      SaveToFile(filehandle,Out1);
       
Print(str," ",Ask," ",Bid," ",ATRValue," ",LowCurrent," ",HighCurrent," ",ATRCurrent," ",PercentATR," ",ATRValue1);





   }
  

   return(INIT_SUCCEEDED);
  }
string CreateSymbolList()
   {
   string TempSymbol;
   int SymbolCount=0;
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
   return TempSymbol ;
   }
string SaveToFile(int filehandle,string Out1)
   {
   FileSeek(filehandle,0,SEEK_END);
   FileWrite(filehandle,Out1);
   return(true);
   }
string WriteToFile(string wrt1)
   {
//   
   return Out1;
   }
   