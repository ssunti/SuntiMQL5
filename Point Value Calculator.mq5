//+------------------------------------------------------------------+
//|                                       Point Value Calculator.mq5 |
//|                                        Copyright © 2018, Amr Ali |
//|                             https://www.mql5.com/en/users/amrali |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2018, Amr Ali"
#property link      "https://www.mql5.com/en/users/amrali"
#property version   "1.00"
#property description "Calculate the money value of one point change for a trade."
//+------------------------------------------------------------------+
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\Label.mqh>
#include <Controls\ComboBox.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define CONTROLS_GAP_X                      (20)      // gap by X coordinate
#define CONTROLS_GAP_Y                      (10)      // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (240)     // size by X coordinate
#define BUTTON_HEIGHT                       (27)      // size by Y coordinate
//--- for the indication area
#define EDIT_WIDTH                          (110)     // size by X coordinate
#define EDIT_HEIGHT                         (27)      // size by Y coordinate
#define LABEL_HEIGHT                        (10)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
private:
   CLabel            m_label1;
   CLabel            m_label2;
   CLabel            m_label3;
   CLabel            m_label4;
   CLabel            m_label5;
   CComboBox         m_combo_box;                     // the dropdown list object
   CEdit             m_edit1;                         // the display field object
   CEdit             m_edit2;                         // the display field object
   CEdit             m_edit3;                         // the display field object
   CEdit             m_edit4;                         // the display field object
   CButton           m_button1;                       // the button object

public:
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateLabel1(void);
   bool              CreateLabel2(void);
   bool              CreateLabel3(void);
   bool              CreateLabel4(void);
   bool              CreateLabel5(void);
   bool              CreateComboBox(void);
   bool              CreateEdit1(void);
   bool              CreateEdit2(void);
   bool              CreateEdit3(void);
   bool              CreateEdit4(void);
   bool              CreateButton1(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnChangeComboBox(void);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)
   ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
   ON_EVENT(ON_CHANGE,m_combo_box,OnChangeComboBox)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateLabel1())
      return(false);
   if(!CreateLabel2())
      return(false);
   if(!CreateLabel3())
      return(false);
   if(!CreateLabel4())
      return(false);
   if(!CreateLabel5())
      return(false);
   if(!CreateComboBox())
      return(false);
   if(!CreateEdit1())
      return(false);
   if(!CreateEdit2())
      return(false);
   if(!CreateEdit3())
      return(false);
   if(!CreateEdit4())
      return(false);
   if(!CreateButton1())
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label1" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP;
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label1.Create(m_chart_id,m_name+"Label1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label1.Text("Currency Pair:"))
      return(false);
   if(!Add(m_label1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "ComboBox" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_combo_box.Create(m_chart_id,m_name+"ComboBox",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box))
      return(false);
//--- fill out with market watch symbols
   int total=SymbolsTotal(true);
   for(int i=0; i<total; i++)
      if(!m_combo_box.ItemAdd(SymbolName(i,true)))
         return(false);
   if(!m_combo_box.Select(0))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label2" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP;
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label2.Create(m_chart_id,m_name+"Label2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label2.Text("Trade Size (in lots):"))
      return(false);
   if(!Add(m_label2))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit1" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit1.Create(m_chart_id,m_name+"Edit1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit1.Text("1.00"))
      return(false);
   if(!Add(m_edit1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label3" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel3(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT+EDIT_HEIGHT+CONTROLS_GAP_Y*2);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label3.Create(m_chart_id,m_name+"Label3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label3.Text("Account Currency:"))
      return(false);
   if(!Add(m_label3))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit2" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*2+EDIT_HEIGHT+CONTROLS_GAP_Y*3);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit2.Create(m_chart_id,m_name+"Edit2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit2.ReadOnly(true))
      return(false);
   if(!m_edit2.Text(AccountInfoString(ACCOUNT_CURRENCY)))
      return(false);
   if(!m_edit2.ColorBackground(clrGainsboro))
      return(false);
   if(!Add(m_edit2))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label4" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel4(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT+EDIT_HEIGHT+CONTROLS_GAP_Y*2);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label4.Create(m_chart_id,m_name+"Label4",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label4.Text("Point Size:"))
      return(false);
   if(!Add(m_label4))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit3" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit3(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT*2+EDIT_HEIGHT+CONTROLS_GAP_Y*3);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit3.Create(m_chart_id,m_name+"Edit3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit3.ReadOnly(true))
      return(false);
   string symbol=m_combo_box.Select();
   double point = SymbolInfoDouble(symbol,SYMBOL_POINT);
   int digits = (int)SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   if(!m_edit3.Text(DoubleToString(point,digits)))
      return(false);
   if(!m_edit3.ColorBackground(clrGainsboro))
      return(false);
   if(!Add(m_edit3))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Calculate" button                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*2+CONTROLS_GAP_Y*5);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button1.Create(m_chart_id,m_name+"Button1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button1.Text("Calculate"))
      return(false);
   if(!Add(m_button1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label5" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel5(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*2+BUTTON_HEIGHT+CONTROLS_GAP_Y*7);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label5.Create(m_chart_id,m_name+"Label5",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label5.Text("Point Value: ("+AccountInfoString(ACCOUNT_CURRENCY)+")"))
      return(false);
   if(!Add(m_label5))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit4" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit4(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*4+EDIT_HEIGHT*2+BUTTON_HEIGHT+CONTROLS_GAP_Y*8);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit4.Create(m_chart_id,m_name+"Edit4",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit4.ReadOnly(true))
      return(false);
   if(!m_edit4.TextAlign(ALIGN_CENTER))
      return(false);
   if(!m_edit4.Color(clrRed))
      return(false);
   if(!m_edit4.Font("Arial Bold"))
      return(false);
   int size=m_edit4.FontSize();
   if(!m_edit4.FontSize(size+1))
      return(false);
   if(!Add(m_edit4))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton1(void)
  {
   string symbol=m_combo_box.Select();
   double volume=StringToDouble(m_edit1.Text());
//---
   double TickSize  = SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_SIZE);
   double TickValue = SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);
   double PointSize = SymbolInfoDouble(symbol,SYMBOL_POINT);
   double PointValue= TickValue * PointSize / TickSize;
   double PointValueLots = PointValue * volume;
//---
   m_edit4.Text(DoubleToString(PointValueLots,5));
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox(void)
  {
   string symbol=m_combo_box.Select();
//---
   double point = SymbolInfoDouble(symbol,SYMBOL_POINT);
   int digits = (int)SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   m_edit3.Text(DoubleToString(point,digits));
  }
//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
CControlsDialog ExtDialog;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create application dialog
   if(!ExtDialog.Create(0,"Point Value Calculator",0,100,100,374,385))
      return(INIT_FAILED);
//--- run application
   ExtDialog.Run();
//--- succeed
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy dialog
   ExtDialog.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert chart event function                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam) // event parameter of the string type
  {
   ExtDialog.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+

// https://www.forexpeacearmy.com/tools/forex-calculator
// https://www.fxpro.com/trading-tools/calculators/all-in-one
