//+------------------------------------------------------------------+
//|                                                  MyAppDialog.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property description "The CMyAppDialog class derived from CAppDialog"
#property description "Added methods for setting the background and caption colors"
#include <Controls\Dialog.mqh>
//+------------------------------------------------------------------+
//| Class CLivePanelTwoButtons                                       |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CMyAppDialog : public CAppDialog
  {
public:
   void              ColorBackground(const color clr);
   color             ColorCaption(void);
   void              ColorCaption(const color clr);
//--- Constructor and destructor   
public:
                     CMyAppDialog(void){};
                    ~CMyAppDialog(void){};
  };
//+------------------------------------------------------------------+
//| Sets background color                                            |
//+------------------------------------------------------------------+
void CMyAppDialog::ColorBackground(const color clr)
  {
   string prefix=Name();
   int total=ControlsTotal();
   for(int i=0;i<total;i++)
     {
      CWnd*obj=Control(i);
      string name=obj.Name();
      //---
      if(name==prefix+"Client")
        {
         CWndClient *wndclient=(CWndClient*) obj;
         wndclient.ColorBackground(clr);
         ChartRedraw();
         return;
        }
     }
//---     
  } 
//+------------------------------------------------------------------+
//| Sets caption color                                               |
//+------------------------------------------------------------------+
void CMyAppDialog::ColorCaption(const color clr)
  {
   string prefix=Name();
   int total=ControlsTotal();
   for(int i=0;i<total;i++)
     {
      CWnd*obj=Control(i);
      string name=obj.Name();
      //---
      if(name==prefix+"Caption")
        {
         CEdit *edit=(CEdit*) obj;
         edit.ColorBackground(clr);
         ChartRedraw();
         return;
        }
     }
//---     
  }  
//+------------------------------------------------------------------+
//| Gets the caption color                                           |
//+------------------------------------------------------------------+
color CMyAppDialog::ColorCaption(void)
  {
   string prefix=Name();
   int total=ControlsTotal();
   color clr=clrNONE;
   for(int i=0;i<total;i++)
     {
      CWnd*obj=Control(i);
      string name=obj.Name();
      //---
      if(name==prefix+"Caption")
        {
         CEdit *edit=(CEdit*) obj;
         clr=edit.ColorBackground(clr);
         return clr;
        }
     }
//--- Return the color
   return clr;     
  }  
//+------------------------------------------------------------------+