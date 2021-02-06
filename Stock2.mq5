//+------------------------------------------------------------------+
//|                                                       Stock2.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
struct Data1 
  { 
   datetime time;         // Period start time 
   double   price;        // Price 
   string   type;         // The type of price 
   string   ctype;         // The change of price
  };
int sIze, sIze1, i;
int OnInit()
  {
      double source_array[][3]; 
      double   dest_array[][3];
      Data1 Bb[],Cc[]; 
      MqlRates rates[],Aa[];
      ArraySetAsSeries(rates,true); 
      int copied=CopyRates(NULL,0,0,100,rates); 
      if(copied<=0) 
         Print("Error copying price data ",GetLastError()); 
      else
         {
            Print("Copied ",ArraySize(rates)," bars"); 
            sIze = ArraySize(rates);
         }
//      Print(sIze);
//      ArrayPrint(rates); 
      //Print("Check\n[time]\t[open]\t[high]\t[low]\t[close]\t[tick_volume]\t[spread]\t[real_volume]"); 
      ArrayResize(source_array,sIze);
      ArrayResize(Aa,sIze);
      
//      ArrayResize(Bb,10,0);
      
      ArrayCopy(Aa,rates,0,0,WHOLE_ARRAY);   //rates still data
      double TempT = (double)rates[sIze-1].time;
      double TempH = rates[sIze-1].high;
      double TempL = rates[sIze-1].low;
      string sh1,sl1;
      int k=0,l=0;
      ArrayResize(Bb,1);
      ArrayResize(Cc,1);
      if ((rates[sIze-2].high-rates[sIze-1].high) > 0)
         {
            sh1="UP";
         }
      else
         {
            sh1="DN";
         }
      if ((rates[sIze-2].low-rates[sIze-1].low) > 0)
         {
            sl1="DN";
         }
      else
         {
            sl1="UP";
         }
      for (i=(sIze-3);i>=0;i--)
         {
            if (sh1=="UP")
               {
                  if ((rates[i].high-rates[i+1].high) < 0)
                     {
                        Bb[k].time=(double)rates[i+1].time;
                        Bb[k].price=rates[i+1].high;
                        Bb[k].type="H"; 
                        Bb[k].ctype="HL";
                        k=k+1;
                        sh1="DN";
                        ArrayResize(Bb,k+1);
                     }
               }
            else
               {
                  if ((rates[i].high-rates[i+1].high) > 0)
                     {
                        Bb[k].time=(double)rates[i+1].time;
                        Bb[k].price=rates[i+1].high;
                        Bb[k].type="H"; 
                        Bb[k].ctype="LH";
                        k=k+1;
                        sh1="UP";
                        ArrayResize(Bb,k+1);
                     }
                  
               }      
//            Print("--->["+k+"] "+i);
            if (sl1=="UP")
               {
                  if ((rates[i].low-rates[i+1].low) < 0)
                     {
                        Cc[l].time=(double)rates[i+1].time;
                        Cc[l].price=rates[i+1].low;
                        Cc[l].type="L"; 
                        Cc[l].ctype="HL";
                        l=l+1;
                        sl1="DN";
                        ArrayResize(Cc,l+1);
                     }
               }
            else
               {
                  if ((rates[i].low-rates[i+1].low) > 0)
                     {
                        Print("---->>>"+i+" - "+l);
                        Cc[l].time=(double)rates[i+1].time;
                        Cc[l].price=rates[i+1].low;
                        Cc[l].type="L"; 
                        Cc[l].ctype="LH";
                        l=l+1;
                        sl1="UP";
                        ArrayResize(Cc,l+1);
                     }
                  
               }
            
            
         }
      sIze1 = ArraySize(Bb);
      Print(sIze1);
//      ArrayResize(Bb,sIze1);
//      ArraySwap(source_array,dest_array);  // source_array empty
//      Print("Destination ",ArraySize(Bb)," bars");
      ArrayPrint(Bb); 
      ArrayPrint(Cc); 
//      Print("CheckBb\n[time]\t[price]\t[type]"); 
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
