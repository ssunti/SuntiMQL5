void OnStart() 
  { 

   int k = PositionsTotal();
   Print("Order = ",k);
   string file_name= "Combined_Report1.txt";
   int file_handle = -1;
   file_handle=FileOpen(file_name,FILE_READ|FILE_WRITE|FILE_TXT);
   if(file_handle==INVALID_HANDLE)
      Print("Error opening rep-file: "+file_name);
      
   MqlRates rates[]; 
   
   ENUM_TIMEFRAMES tf1[]={PERIOD_M1,PERIOD_H1};
   ArraySetAsSeries(rates,true); 
   int copied=CopyRates(Symbol(),tf1[0],0,10,rates);
   
   Print(Symbol());
   
   
   if(copied>0) 
     { 
      Print("Bars copied: "+ IntegerToString(copied)); 
      string format="open = %G, high = %G, low = %G, close = %G, volume = %d"; 
      string out; 
      int size=fmin(copied,10); 
      for(int i=0;i<size;i++) 
        { 
         out=IntegerToString(i)+":"+TimeToString(rates[i].time); 
         out=out+" "+StringFormat(format, 
                                  rates[i].open, 
                                  rates[i].high, 
                                  rates[i].low, 
                                  rates[i].close, 
                                  rates[i].tick_volume); 
         Print(out); 
         Comment(out);
      FileSeek(file_handle,0,SEEK_END);
      FileWrite(file_handle,out);
      FileFlush(file_handle);         
        } 
     }
      
   else Print("Failed to get history data for the symbol ",Symbol());
   
   FileClose(file_handle); 
  }