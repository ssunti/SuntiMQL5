//+------------------------------------------------------------------+
//|                                     Position Size Calculator.mq5 |
//|                                        Copyright © 2018, Amr Ali |
//|                             https://www.mql5.com/en/users/amrali |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2018, Amr Ali"
#property link      "https://www.mql5.com/en/users/amrali"
#property version   "1.00"
#property description "Calculate the position size for a trade."
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
   CLabel            m_label6;
   CLabel            m_label7;
   CComboBox         m_combo_box;                     // the dropdown list object
   CEdit             m_edit1;                         // the display field object
   CEdit             m_edit2;                         // the display field object
   CEdit             m_edit3;                         // the display field object
   CEdit             m_edit4;                         // the display field object
   CEdit             m_edit5;                         // the display field object
   CEdit             m_edit6;                         // the display field object
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
   bool              CreateLabel6(void);
   bool              CreateLabel7(void);
   bool              CreateComboBox(void);
   bool              CreateEdit1(void);
   bool              CreateEdit2(void);
   bool              CreateEdit3(void);
   bool              CreateEdit4(void);
   bool              CreateEdit5(void);
   bool              CreateEdit6(void);
   bool              CreateButton1(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)
   ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
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
   if(!CreateLabel6())
      return(false);
   if(!CreateLabel7())
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
   if(!CreateEdit5())
      return(false);
   if(!CreateEdit6())
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
   if(!m_label2.Text("Stop Loss (points):"))
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
   if(!m_edit1.Text("100"))
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
   if(!m_label4.Text("Account Balance:"))
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
   if(!m_edit3.Text(DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)))
      return(false);
   if(!m_edit3.ColorBackground(clrGainsboro))
      return(false);
   if(!Add(m_edit3))
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
   int y1=INDENT_TOP+(LABEL_HEIGHT*2+EDIT_HEIGHT*2+CONTROLS_GAP_Y*4);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label5.Create(m_chart_id,m_name+"Label5",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label5.Text("Risk Percent, %:"))
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
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*2+CONTROLS_GAP_Y*5);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit4.Create(m_chart_id,m_name+"Edit4",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit4.Text("2"))
      return(false);
   if(!Add(m_edit4))
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
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*3+CONTROLS_GAP_Y*7);
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
//| Create the "Label6" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel6(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*3+BUTTON_HEIGHT+CONTROLS_GAP_Y*9);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label6.Create(m_chart_id,m_name+"Label6",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label6.Text("Position Size: (Lots)"))
      return(false);
   if(!Add(m_label6))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit5" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit5(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*5+EDIT_HEIGHT*3+BUTTON_HEIGHT+CONTROLS_GAP_Y*9);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit5.Create(m_chart_id,m_name+"Edit5",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit5.ReadOnly(true))
      return(false);
   if(!m_edit5.TextAlign(ALIGN_CENTER))
      return(false);
   if(!m_edit5.Color(clrBlue))
      return(false);
   if(!m_edit5.Font("Arial Bold"))
      return(false);
   int size=m_edit5.FontSize();
   if(!m_edit5.FontSize(size+1))
      return(false);
   if(!Add(m_edit5))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label7" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel7(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*5+EDIT_HEIGHT*4+BUTTON_HEIGHT+CONTROLS_GAP_Y*10);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label7.Create(m_chart_id,m_name+"Label7",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label7.Text("Money to risk: ("+AccountInfoString(ACCOUNT_CURRENCY)+")"))
      return(false);
   if(!Add(m_label7))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit6" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit6(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*6+EDIT_HEIGHT*4+BUTTON_HEIGHT+CONTROLS_GAP_Y*11);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit6.Create(m_chart_id,m_name+"Edit6",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit6.ReadOnly(true))
      return(false);
   if(!m_edit6.TextAlign(ALIGN_CENTER))
      return(false);
   if(!m_edit6.Color(clrRed))
      return(false);
   if(!m_edit6.Font("Arial Bold"))
      return(false);
   int size=m_edit6.FontSize();
   if(!m_edit6.FontSize(size+1))
      return(false);
   if(!Add(m_edit6))
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
   double sl_points=StringToDouble(m_edit1.Text());
   double risk=MathMin(StringToDouble(m_edit4.Text()),100.0);
//---
   double TickSize  = SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_SIZE);
   double TickValue = SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);
   double PointSize = SymbolInfoDouble(symbol,SYMBOL_POINT);
   double PointValue= TickValue * PointSize / TickSize;
//---
   double capital=AccountInfoDouble(ACCOUNT_BALANCE);
   double risk_money=risk/100.0*capital;
   double lots = risk_money/sl_points/PointValue;
   double lotstep = SymbolInfoDouble(symbol,SYMBOL_VOLUME_STEP);
   lots = NormalizeDouble(lots/lotstep,0)*lotstep;
//---
   m_edit5.Text(DoubleToString(lots,2));
   m_edit6.Text(DoubleToString(risk_money,2));
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
   if(!ExtDialog.Create(0,"Position Size Calculator",0,100,100,374,490))
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

// https://www.myfxbook.com/en/forex-calculators/position-size
