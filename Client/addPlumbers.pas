unit addPlumbers;

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
  Vcl.Grids, Vcl.DBGrids, operatorEntry;

type
  TaddPlumber = class(TForm)
    DBGrid1: TDBGrid;
    add: TButton;
    cancel: TButton;
    procedure addClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  addPlumber: TaddPlumber;

implementation

{$R *.dfm}

uses mainWindow, dm;

procedure TaddPlumber.addClick(Sender: TObject);
var body: TJSONObject;
s:string;
begin

  body:=TJSONObject.Create;

  body.AddPair('task', 'assign');
  body.AddPair('order_id', TJSONNumber.Create(fmMainWindow.orderid));
  body.AddPair('plumber_id', DBGrid1.SelectedField.Value);

  dm.DataModule1.BackendEndpoint3.AddBody(body);
  dm.DataModule1.BackendEndpoint3.Execute;
  s:=dm.DataModule1.RESTResponseGet.Content;

  addPlumber.Close;
end;

end.
