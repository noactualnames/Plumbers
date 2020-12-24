unit cancelPlumberForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  IdTCPConnection, IdTCPClient, IdHTTP, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON,
  REST.Backend.ServiceTypes, REST.Client, REST.Backend.EndPoint,
  Data.Bind.Components, Data.Bind.ObjectScope,
  Vcl.Grids, Vcl.DBGrids, operatorEntry, dm;

type
  TcancelPlumbers = class(TForm)
    YesBtnOk: TButton;
    CancelBtn: TButton;
    LabelCancelPlumber: TLabel;
    procedure CancelBtnClick(Sender: TObject);
    procedure YesBtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cancelPlumbers: TcancelPlumbers;

implementation

{$R *.dfm}

uses mainWindow;

procedure TcancelPlumbers.CancelBtnClick(Sender: TObject);
begin
  cancelPlumbers.Close;
end;

procedure TcancelPlumbers.YesBtnOkClick(Sender: TObject);
var body: TJSONObject;
s:string;
      orderType, orderDesc, orderAddress, postJSON, orderDate, url:string;
      orderPrice:integer;
      orderPhone:int64;
      response1,resp:string;
      main, second, third:TJSONObject;
begin

    main:=TJSONObject.Create;
    second:=TJSONObject.Create;
    third:=TJSONObject.Create;

    main.AddPair('task','order');
    //showmessage(fmMainWindow.DBGrid2.Fields[0].Value);
    main.AddPair('orderid',TJSONNumber.Create(fmMainWindow.DBGrid2.Fields[0].Value));
    main.AddPair('operatorid',TJSONNumber.Create(fmMainWindow.DBGrid2.Fields[2].Value));
    second.AddPair('creation_date',fmMainWindow.DBGrid2.Fields[4].Value);
    second.AddPair('order_operator_id',TJsONNumber.Create(fmMainWindow.DBGrid2.Fields[2].Value));
    second.AddPair('order_plumber_id',TJSoNNumber.Create(0));
    second.AddPair('order_status', 'free');
    main.AddPair('orderdata', second);

    //orderinfo
    //showmessage(fmMainWindow.DBGrid2.Fields[0].Value);
    dm.DataModule1.dsetOrdersInfo.FieldByName('ORDER_INFO_ID');
    dm.DataModule1.dsetOrdersInfo.Locate('ORDER_INFO_ID', fmMainWindow.DBGrid2.Fields[0].AsVariant, [loCaseInsensitive]);
    orderType := dm.DataModule1.dsetOrdersInfo['ORDER_TYPE'];
    //showmessage(dm.DataModule1.dsetOrdersInfo['CUSTOMER_PHONE']);
    orderDesc := dm.DataModule1.dsetOrdersInfo['ORDER_DESCRIPTION'];
    //showmessage(dm.DataModule1.dsetOrdersInfo['ORDER_DESCRIPTION']);
    orderAddress := dm.DataModule1.dsetOrdersInfo['CUSTOMER_ADDRESS'];
    orderPhone := dm.DataModule1.dsetOrdersInfo['CUSTOMER_PHONE'];
    //showmessage(dm.DataModule1.dsetOrdersInfo['ORDER_PRICE']);
    orderPrice := dm.DataModule1.dsetOrdersInfo['ORDER_PRICE'];

    third.AddPair('type',orderType);
    third.AddPair('description',orderDesc);
    //showmessage(orderDesc);
    third.AddPair('price',TJSONNumber.Create(orderPrice));
    third.AddPair('phone',TJSONNumber.Create(orderPhone));
    third.AddPair('address',orderAddress);
    main.AddPair('orderinfodata',third);

   dm.DataModule1.BackendEndpoint2.AddBody(main);
   dm.DataModule1.BackendEndpoint2.Execute;
   response1:=dm.DataModule1.RESTResponsePost.Content;

   cancelPlumbers.Close;
end;

end.
