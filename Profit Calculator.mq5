//+------------------------------------------------------------------+
//|                                            Profit Calculator.mq5 |
//|                                        Copyright © 2018, Amr Ali |
//|                             https://www.mql5.com/en/users/amrali |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2018, Amr Ali"
#property link      "https://www.mql5.com/en/users/amrali"
#property version   "1.00"
#property description "Calculate the profit or risk money for a trade."
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
   CLabel            m_label8;
   CLabel            m_label9;
   CLabel            m_label10;
   CComboBox         m_combo_box1;                    // the dropdown list object
   CComboBox         m_combo_box2;                    // the dropdown list object
   CEdit             m_edit1;                         // the display field object
   CEdit             m_edit2;                         // the display field object
   CEdit             m_edit3;                         // the display field object
   CEdit             m_edit4;                         // the display field object
   CEdit             m_edit5;                         // the display field object
   CEdit             m_edit6;                         // the display field object
   CEdit             m_edit7;                         // the display field object
   CEdit             m_edit8;                         // the display field object
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
   bool              CreateLabel8(void);
   bool              CreateLabel9(void);
   bool              CreateLabel10(void);
   bool              CreateComboBox1(void);
   bool              CreateComboBox2(void);
   bool              CreateEdit1(void);
   bool              CreateEdit2(void);
   bool              CreateEdit3(void);
   bool              CreateEdit4(void);
   bool              CreateEdit5(void);
   bool              CreateEdit6(void);
   bool              CreateEdit7(void);
   bool              CreateEdit8(void);

   bool              CreateButton1(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnChangeComboBox1(void);
   void              OnChangeComboBox2(void);
   void              OnEditPrice(void);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)
   ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
   ON_EVENT(ON_CHANGE,m_combo_box1,OnChangeComboBox1)
   ON_EVENT(ON_CHANGE,m_combo_box2,OnChangeComboBox2)
   ON_EVENT(ON_END_EDIT,m_edit4,OnEditPrice)
   ON_EVENT(ON_END_EDIT,m_edit5,OnEditPrice)
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
   if(!CreateLabel8())
      return(false);
   if(!CreateLabel9())
      return(false);
   if(!CreateLabel10())
      return(false);
   if(!CreateComboBox1())
      return(false);
   if(!CreateComboBox2())
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
   if(!CreateEdit7())
      return(false);
   if(!CreateEdit8())
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
//| Create the "ComboBox1" element                                   |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_combo_box1.Create(m_chart_id,m_name+"ComboBox1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box1))
      return(false);
//--- fill out with market watch symbols
   int total=SymbolsTotal(true);
   for(int i=0; i<total; i++)
      if(!m_combo_box1.ItemAdd(SymbolName(i,true)))
         return(false);
   if(!m_combo_box1.Select(0))
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
   if(!m_label4.Text("Holding Days:"))
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
   if(!m_edit3.Text("0"))
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
   if(!m_label5.Text("Open Price:"))
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
   string symbol=m_combo_box1.Select();
   double price = SymbolInfoDouble(symbol,SYMBOL_BID);
   int digits = (int)SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   if(!m_edit4.Text(DoubleToString(price,digits)))
      return(false);
   if(!Add(m_edit4))
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
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT*2+EDIT_HEIGHT*2+CONTROLS_GAP_Y*4);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label6.Create(m_chart_id,m_name+"Label6",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label6.Text("Close Price:"))
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
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*2+CONTROLS_GAP_Y*5);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit5.Create(m_chart_id,m_name+"Edit5",m_subwin,x1,y1,x2,y2))
      return(false);
   string symbol=m_combo_box1.Select();
   double price = SymbolInfoDouble(symbol,SYMBOL_BID)+100*SymbolInfoDouble(symbol,SYMBOL_POINT);
   int digits = (int)SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   if(!m_edit5.Text(DoubleToString(price,digits)))
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
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*3+CONTROLS_GAP_Y*6);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label7.Create(m_chart_id,m_name+"Label7",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label7.Text("Order Type:"))
      return(false);
   if(!Add(m_label7))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "ComboBox2" element                                   |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*4+EDIT_HEIGHT*3+CONTROLS_GAP_Y*7);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_combo_box2.Create(m_chart_id,m_name+"ComboBox2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box2))
      return(false);
//--- fill out with order types
   string items[2]={"Buy / Long","Sell / Short"};
   for(int i=0; i<2; i++)
      if(!m_combo_box2.ItemAdd(items[i]))
         return(false);
   if(!m_combo_box2.Select(0))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label8" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel8(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT*3+EDIT_HEIGHT*3+CONTROLS_GAP_Y*6);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label8.Create(m_chart_id,m_name+"Label8",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label8.Text("P/L Points:"))
      return(false);
   if(!Add(m_label8))
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
   int x1=INDENT_LEFT+(EDIT_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(LABEL_HEIGHT*4+EDIT_HEIGHT*3+CONTROLS_GAP_Y*7);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit6.Create(m_chart_id,m_name+"Edit6",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit6.ReadOnly(true))
      return(false);
   if(!m_edit6.Text("100"))
      return(false);
   if(!m_edit6.ColorBackground(clrGainsboro))
      return(false);
   if(!Add(m_edit6))
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
   int y1=INDENT_TOP+(LABEL_HEIGHT*5+EDIT_HEIGHT*4+CONTROLS_GAP_Y*8);
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
//| Create the "Label9" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel9(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*6+EDIT_HEIGHT*4+BUTTON_HEIGHT+CONTROLS_GAP_Y*9);
   int x2=x1+EDIT_HEIGHT;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label9.Create(m_chart_id,m_name+"Label9",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label9.Text("Profit/Loss: ("+AccountInfoString(ACCOUNT_CURRENCY)+")"))
      return(false);
   if(!Add(m_label9))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit6" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit7(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*7+EDIT_HEIGHT*4+BUTTON_HEIGHT+CONTROLS_GAP_Y*10);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit7.Create(m_chart_id,m_name+"Edit7",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit7.ReadOnly(true))
      return(false);
   if(!m_edit7.TextAlign(ALIGN_CENTER))
      return(false);
   if(!m_edit7.Color(clrBlue))
      return(false);
   if(!m_edit7.Font("Arial Bold"))
      return(false);
   int size=m_edit7.FontSize();
   if(!m_edit7.FontSize(size+1))
      return(false);
   if(!Add(m_edit7))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Label10" label                                        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel10(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*8+EDIT_HEIGHT*4+BUTTON_HEIGHT+CONTROLS_GAP_Y*13);
   int x2=x1+EDIT_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_label10.Create(m_chart_id,m_name+"Label10",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label10.Text("Swap: ("+AccountInfoString(ACCOUNT_CURRENCY)+")"))
      return(false);
   if(!Add(m_label10))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit8" edit                                          |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit8(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(LABEL_HEIGHT*9+EDIT_HEIGHT*4+BUTTON_HEIGHT+CONTROLS_GAP_Y*14);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit8.Create(m_chart_id,m_name+"Edit8",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit8.ReadOnly(true))
      return(false);
   if(!m_edit8.TextAlign(ALIGN_CENTER))
      return(false);
   if(!m_edit8.Color(clrRed))
      return(false);
   if(!m_edit8.Font("Arial Bold"))
      return(false);
   int size=m_edit8.FontSize();
   if(!m_edit8.FontSize(size+1))
      return(false);
   if(!Add(m_edit8))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton1(void)
  {
   string symbol=m_combo_box1.Select();
   double volume=StringToDouble(m_edit1.Text());
   int num_days=(int)StringToInteger(m_edit3.Text());
   double open_price=StringToDouble(m_edit4.Text());
   double close_price=StringToDouble(m_edit5.Text());
   long order_type=m_combo_box2.Value();
   //string order_type=m_combo_box2.Select();
//---
   double profit = 0;
   double swap = 0;
   bool result = OrderCalcProfit((ENUM_ORDER_TYPE)order_type,symbol,volume,open_price,close_price,profit);
//---
   if(SymbolInfoInteger(symbol,SYMBOL_SWAP_MODE)==SYMBOL_SWAP_MODE_POINTS)
     {
      double TickSize  = SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_SIZE);
      double TickValue = SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);
      double PointSize = SymbolInfoDouble(symbol,SYMBOL_POINT);
      double PointValue= TickValue * PointSize / TickSize;
      //---
      swap = volume * SymbolInfoDouble(symbol,(order_type==0) ? SYMBOL_SWAP_LONG : SYMBOL_SWAP_SHORT) * PointValue * num_days;
    }
//---
   m_edit7.Text(DoubleToString(profit,2));
   m_edit8.Text(DoubleToString(swap,2));
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox1(void)
  {
   string symbol=m_combo_box1.Select();
//--- set open price
   double price = SymbolInfoDouble(symbol,SYMBOL_BID);
   int digits = (int)SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   m_edit4.Text(DoubleToString(price,digits));
//--- set close price
   price += 100*SymbolInfoDouble(symbol,SYMBOL_POINT);
   m_edit5.Text(DoubleToString(price,digits));
//--- set p/l points
   OnEditPrice();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox2(void)
  {
//--- set p/l points
   OnEditPrice();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnEditPrice(void)
  {
   string symbol=m_combo_box1.Select();
   double open_price=StringToDouble(m_edit4.Text());
   double close_price=StringToDouble(m_edit5.Text());
   long order_type=m_combo_box2.Value();
//--- set p/l points
   double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
   double diff=(ENUM_ORDER_TYPE)order_type==ORDER_TYPE_BUY ? close_price - open_price : open_price - close_price;
   if(point>0)
      m_edit6.Text(DoubleToString(diff/point,0));
   else
      m_edit6.Text("0");
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
   if(!ExtDialog.Create(0,"Profit Calculator",0,100,100,374,550))
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
