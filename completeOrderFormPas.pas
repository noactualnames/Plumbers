unit completeOrderFormPas;

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
  TcompleteOrderForm = class(TForm)
    completeOrderConfirmButton: TButton;
    completeOrderCancelBtn: TButton;
    LabelInfoAdd: TLabel;
    procedure completeOrderConfirmButtonClick(Sender: TObject);
    procedure completeOrderCancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  completeOrderForm: TcompleteOrderForm;

implementation

{$R *.dfm}
uses mainWindow;
procedure TcompleteOrderForm.completeOrderCancelBtnClick(Sender: TObject);
begin
  completeOrderForm.Close;
end;

procedure TcompleteOrderForm.completeOrderConfirmButtonClick(Sender: TObject);
  var body: TJSONObject;
      s:string;
begin
  body:=TJSONObject.Create;

  body.AddPair('task', 'accept');
  body.AddPair('order_id', TJSONNumber.Create(fmMainWindow.orderid));
  body.AddPair('plumber_id', TJSONNumber.Create(fmMainWindow.plumberidpick));

  dm.DataModule1.BackendEndpoint3.AddBody(body);
  dm.DataModule1.BackendEndpoint3.Execute;
  s:=dm.DataModule1.RESTResponseGet.Content;
  completeOrderForm.Close;
end;

end.
