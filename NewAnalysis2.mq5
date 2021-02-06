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
string   file_name1 = "/Analysis1/"+str+"Anlysis2Data"+strt+".txt";
string   file_name2 = "/Analysis1/"+str+"DownData"+strt+".txt";
int file_handle1 = FileOpen(file_name1,FILE_READ|FILE_WRITE|FILE_TXT);
int file_handle2 = FileOpen(file_name2,FILE_READ|FILE_WRITE|FILE_TXT);
   
   SaveToFile(file_handle1,_Symbol);
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
   
   double         FractalUpBuffer[]; 
   double         FractalDownBuffer[];
    
   for (int xx=0;xx<=0;xx++)
      {
   
         int Fractals=iFractals(_Symbol,period[xx]);
   
         CopyBuffer(Fractals,0,0,numCan[xx],FractalUpBuffer);
         CopyBuffer(Fractals,1,0,numCan[xx],FractalDownBuffer);

         double A1,A2;
   int x;
   int y=1;
   for(x=0;x<=(numCan[xx]-1);x++)
      {
          
           A1 = FractalUpBuffer[x];
           A2 = FractalDownBuffer[x];
       
   if (A1!=EMPTY_VALUE) 
      {
//         Print("A1 ["+IntegerToString(x)+"] = " + DoubleToString(A1));
//        output_string=IntegerToString(x)+";"+DoubleToString(A1)+";"+EnumToString(period[xx]);
         output_string=IntegerToString(y)+";"+IntegerToString(x)+";"+DoubleToString(A1)+";H";
         SaveToFile(file_handle1,output_string);
         y=y+1;
         output_string="";
      }
   if (A2!=EMPTY_VALUE) 
      {
//         Print("A2 ["+IntegerToString(x)+"] = " + DoubleToString(A2));
//         output_string=IntegerToString(x)+";"+DoubleToString(A2)+";"+EnumToString(period[xx]);
         output_string=IntegerToString(y)+";"+IntegerToString(x)+";"+DoubleToString(A2)+";L";
         SaveToFile(file_handle1,output_string);
         y=y+1;
         output_string="";
         
      }

      }
      }
                  
  }
string SaveToFile(int filehandle,string Out2)
   {
   FileSeek(filehandle,0,SEEK_END);
   FileWrite(filehandle,Out2);
   return Out2;
   }
   