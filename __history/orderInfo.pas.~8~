unit orderInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON;

type
  TTOrderInfo = class(TForm)
    eOrderType: TEdit;
    Label1: TLabel;
    btnAddCustomer: TButton;
    eOrderDescroption: TEdit;
    eOrderPrice: TEdit;
    eOrderPhone: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    eOrderAddress: TEdit;
    procedure btnAddCustomerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TOrderInfo: TTOrderInfo;

implementation

{$R *.dfm}
uses operatorEntry, dm;

procedure TTOrderInfo.btnAddCustomerClick(Sender: TObject);
var orderType, orderDesc, orderAddress, postJSON, orderDate, url:string;
     orderPrice:integer;
      orderPhone:int64;
      response1,resp:string;
      main, second, third:TJSONObject;


begin

   orderType:=eOrderType.Text;
   orderDesc:=eOrderDescroption.Text;
   orderPrice:=strToInt(eOrderPrice.Text);
   orderAddress:=eOrderAddress.Text;
   orderPhone:=strToInt(eOrderPhone.Text);
   orderDate:=FormatDateTime('dd.mm.yyyy hh:nn:ss', now);

    main:=TJSONObject.Create;
    second:=TJSONObject.Create;
    third:=TJSONObject.Create;

    main.AddPair('task','order');
    main.AddPair('orderid','0');
    main.AddPair('operatorid',intToStr(TOperatorEntry.opID));
    second.AddPair('creation_date',orderDate);
    second.AddPair('order_operator_id',intToStr(TOperatorEntry.opID));
    second.AddPair('order_plumber_id','0');
    main.AddPair('orderdata', second);
    third.AddPair('type',orderType);
    third.AddPair('description',orderDesc);
    third.AddPair('price',intToStr(orderPrice));
    third.AddPair('phone',intToStr(orderPhone));
    third.AddPair('description',orderAddress);
    main.AddPair('order_info_data',third);

   dm.DataModule1.BackendEndpoint2.AddBody(main);
   dm.DataModule1.BackendEndpoint2.Execute;
   response1:=dm.DataModule1.RESTResponsePost.Content;

   if (response1<>'{"response" : "New Data added"}') then begin
         MessageDlg(response1,mtError, mbOKCancel, 0);

   end else close;



end;

end.
