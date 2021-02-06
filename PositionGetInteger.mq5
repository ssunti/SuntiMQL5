//+------------------------------------------------------------------+ 
//| Trade function                                                   | 
//+------------------------------------------------------------------+ 
void OnTrade() 
  { 
//--- check if a position is present and display the time of its changing 
   if(PositionSelect(_Symbol)) 
     {      
//--- receive position ID for further work 
      ulong position_ID=PositionGetInteger(POSITION_IDENTIFIER); 
      Print(_Symbol," position #",position_ID); 
//--- receive the time of position forming in milliseconds since 01.01.1970 
      long create_time_msc=PositionGetInteger(POSITION_TIME_MSC); 
      PrintFormat("Position #%d  POSITION_TIME_MSC = %i64 milliseconds => %s",position_ID, 
                  create_time_msc,TimeToString(create_time_msc/1000)); 
//--- receive the time of the position's last change in seconds since 01.01.1970 
      long update_time_sec=PositionGetInteger(POSITION_TIME_UPDATE); 
      PrintFormat("Position #%d  POSITION_TIME_UPDATE = %i64 seconds => %s", 
                  position_ID,update_time_sec,TimeToString(update_time_sec)); 
//--- receive the time of the position's last change in milliseconds since 01.01.1970 
      long update_time_msc=PositionGetInteger(POSITION_TIME_UPDATE_MSC); 
      PrintFormat("Position #%d  POSITION_TIME_UPDATE_MSC = %i64 milliseconds => %s", 
                  position_ID,update_time_msc,TimeToString(update_time_msc/1000)); 
     } 
//--- 
  }