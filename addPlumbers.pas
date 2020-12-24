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
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TaddPlumber.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    DBGrid1.Canvas.Brush.Color := clWhite;

    if (Dbgrid1.Fields[1].Value = 'online') then
      DBGrid1.Canvas.Brush.Color := clMoneyGreen;

    if (Dbgrid1.Fields[1].Value = 'assigned') then
      DBGrid1.Canvas.Brush.Color := clYellow;

    if (Dbgrid1.Fields[1].Value = 'working') then
      DBGrid1.Canvas.Brush.Color := clSkyBlue;

    if (Dbgrid1.Fields[1].Value = 'waiting') then
      DBGrid1.Canvas.Brush.Color := clTeal;

    if (Dbgrid1.Fields[1].Value = null) then
      DBGrid1.Canvas.Brush.Color := clWhite;

    Dbgrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
