unit orderInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON;

type
  TTOrderInfo = class(TForm)
    eOrderType: TEdit;
    LabelInfoAdd: TLabel;
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
    cancelBtn: TButton;
    procedure btnAddCustomerClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);

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
    main.AddPair('operatorid',TJSONNumber.Create(TOperatorEntry.opID));
    second.AddPair('creation_date',orderDate);
    second.AddPair('order_operator_id',TJSONNumber.Create(TOperatorEntry.opID));
    second.AddPair('order_plumber_id','0');
    main.AddPair('orderdata', second);
    third.AddPair('type',orderType);
    third.AddPair('description',orderDesc);
    third.AddPair('price',TJSONNumber.Create(orderPrice));
    third.AddPair('phone',TJSONNumber.Create(orderPhone));
    third.AddPair('address',orderAddress);
    main.AddPair('orderinfodata',third);

   dm.DataModule1.BackendEndpoint2.AddBody(main);
   dm.DataModule1.BackendEndpoint2.Execute;
   response1:=dm.DataModule1.RESTResponsePost.Content;

   TOrderInfo.Close;

   if (response1<>'{"response" : "New Data added"}') then begin
         //MessageDlg(response1,mtError, mbOKCancel, 0);

   end else close;

   TOrderInfo.Close;
end;

procedure TTOrderInfo.cancelBtnClick(Sender: TObject);
begin
  TOrderInfo.Close;
end;

end.
