unit mainWindow;

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
  Vcl.Grids, Vcl.DBGrids, operatorEntry, addPlumbers, cancelPlumberForm, changeOrderInfoPas, completeOrderFormPas, cantAddPlumberFormPas,
  System.ImageList, Vcl.ImgList, IdThreadComponent, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdGlobal, IdSocketHandle;

type
  TfmMainWindow = class(TForm)
    Panel1: TPanel;
    btnAddOrder: TButton;
    btnExit: TButton;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    DBGrid3: TDBGrid;
    Timer1: TTimer;
    addPlumberBtn: TButton;
    cancelPlumber: TButton;
    changeOrderButton: TButton;
    completeOrderBtn: TButton;
    ForceUpdateBtn: TButton;
    ImageList1: TImageList;
    IdUDPServer1: TIdUDPServer;
    procedure btnAddOrderClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure DBGrid2CellClick(Column: TColumn);
    //procedure DBGrid1TitleClick(Column: TColumn);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    //procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
    //  Shift: TShiftState; X, Y: Integer);
    //procedure DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
    //  State: TDragState; var Accept: Boolean);
    //procedure DBGrid3DragOver(Sender, Source: TObject; X, Y: Integer;
    //  State: TDragState; var Accept: Boolean);
    //procedure DBGrid3DragDrop(Sender, Source: TObject; X, Y: Integer);
    //procedure DBGrid1StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure addPlumberBtnClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure cancelPlumberClick(Sender: TObject);
    procedure changeOrderButtonClick(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure completeOrderBtnClick(Sender: TObject);
    procedure ForceUpdateBtnClick(Sender: TObject);
    procedure DBGrid2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure UpdateGrids();
  private
    { Private declarations }
  public
    var plumberid: integer;
    var orderid: integer;
    var plumberidpick: integer;
    { Public declarations }
  end;

var
  fmMainWindow: TfmMainWindow;
  curID: integer;
  SourceCol, SourceRow: integer;

implementation

{$R *.dfm}

uses orderInfo, dm;


procedure TfmMainWindow.Timer1Timer(Sender: TObject);
  var login, password, plumberStatus, plumberName, s:string;
      responseJSON : TJSONObject;
      plumbers, orders, ordersinfo, plumbersArrayData:TJSONValue;
      plumbersArray:TJSONArray;
      i:integer;
      plumberId:integer;
      JSONBytes:string;
      url:string;
      response:string;
      begin
        Timer1.Enabled := True;
        login:=TOperatorEntry.eLogin.Text;
        password:=TOperatorEntry.ePassword.Text;
        dm.DataModule1.BackendEndpoint1.AddParameter('task','auth');
        dm.DataModule1.BackendEndpoint1.AddParameter('mode','1');
        dm.DataModule1.BackendEndpoint1.AddParameter('login', login);
        dm.DataModule1.BackendEndpoint1.AddParameter('password',password);
        dm.DataModule1.BackendEndpoint1.Execute;
        s:=dm.DataModule1.RESTResponseGet.Content;

        if (s.Length>45) then  begin
          responseJSON:=TJSONObject.ParseJSONValue(s) as TJSONObject;
          TOperatorEntry.opID:=responseJSON.GetValue<integer>('ID');
        end;
end;


procedure TfmMainWindow.btnAddOrderClick(Sender: TObject);
begin
 TOrderInfo:=TTOrderInfo.Create(Application);
 TOrderInfo.ShowModal;
 TOrderInfo.Release;
end;


procedure TfmMainWindow.btnExitClick(Sender: TObject);
begin
    fmMainWindow.Close;
    TOperatorEntry.Show;
end;

procedure TfmMainWindow.changeOrderButtonClick(Sender: TObject);
begin
  changeOrderForm := TchangeOrderForm.Create(Application);
  changeOrderForm.ShowModal;
  changeOrderForm.Release;
end;

procedure TfmMainWindow.completeOrderBtnClick(Sender: TObject);
begin
  if (DBGrid2.Fields[3].Value = 'completed') then
  begin
    completeOrderForm := TcompleteOrderForm.Create(Application);
    completeOrderForm.ShowModal;
    completeOrderForm.Release end
  else
  begin
    cantAddPlumberForm := TcantAddPlumberForm.Create(Application);
    cantAddPlumberForm.ShowModal;
    cantAddPlumberForm.Release;
  end;
end;

procedure TfmMainWindow.cancelPlumberClick(Sender: TObject);
begin
  if (DBGrid2.Fields[3].Value <> 'free') then
    begin
    cancelPlumbers := TcancelPlumbers.Create(Application);
    cancelPlumbers.ShowModal;
    cancelPlumbers.Release end
  else
  begin
    cantAddPlumberForm := TcantAddPlumberForm.Create(Application);
    cantAddPlumberForm.ShowModal;
    cantAddPlumberForm.Release;
  end;
end;

///////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

//Обновление, граббинг ID.
procedure TfmMainWindow.DBGrid1CellClick(Column: TColumn);
begin
  plumberid := mainWindow.fmMainWindow.DBGrid1.Fields[0].Value;
end;

procedure TfmMainWindow.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfmMainWindow.DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Begindrag(false);
  inherited;
  { Convert mouse coordinates X, Y to
    to StringGrid related col and row numbers }
  //DBGrid2.Drag
  //DBGrid2.MouseCoord(X, Y);
  { Allow dragging only if an acceptable cell was clicked
    (cell beyond the fixed column and row) }
  //if (SourceCol > 0) and (SourceRow > 0) then
    { Begin dragging after mouse has moved 4 pixels }
  //  SG.BeginDrag(False, 4);
end;

procedure TfmMainWindow.DBGrid2CellClick(Column: TColumn);
begin
  orderid := mainWindow.fmMainWindow.DBGrid2.Fields[0].Value;
  plumberidpick := mainWindow.fmMainWindow.DBGrid2.Fields[1].Value;
end;

////////////////////////////////////////////////
////////////////////////////////////////////////

procedure TfmMainWindow.DBGrid2DragDrop(Sender, Source: TObject; X, Y: Integer);
var currentcol, currentrow: integer;
begin
  DBGrid2.MouseCoord(X, Y);
  //(Sender as TCellItem).Assign(Source as TCellItem);
end;

procedure TfmMainWindow.DBGrid2DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Sender is TColumn;
end;

////////////////////////////////////////////////
////////////////////////////////////////////////
procedure TfmMainWindow.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

   DBGrid1.Canvas.Brush.Color := clWhite;

   if (Dbgrid2.Fields[3].Value = 'free') then
      DBGrid2.Canvas.Brush.Color := clWhite;

   if (Dbgrid2.Fields[3].Value = 'assigned') then
      DBGrid2.Canvas.Brush.Color := clYellow;

   if (Dbgrid2.Fields[3].Value = 'watched') then
      DBGrid2.Canvas.Brush.Color := clGrayText;

   if (Dbgrid2.Fields[3].Value = 'processing') then
      DBGrid2.Canvas.Brush.Color := clSkyBlue;

   if (Dbgrid2.Fields[3].Value = 'completed') then
      DBGrid2.Canvas.Brush.Color := clTeal;

   if (Dbgrid2.Fields[3].Value = null) then
      DBGrid1.Canvas.Brush.Color := clWhite;

   Dbgrid2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfmMainWindow.addPlumberBtnClick(Sender: TObject);
  var body: TJSONObject;
begin
  if (DBGrid2.Fields[3].Value = 'free') then
  begin
    addPlumber := TaddPlumber.Create(Application);
    addPlumber.ShowModal;
    addPlumber.Release; end
  else
  begin
    cantAddPlumberForm := TcantAddPlumberForm.Create(Application);
    cantAddPlumberForm.ShowModal;
    cantAddPlumberForm.Release;
  end;
end;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////


//procedure TfmMainWindow.DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
//  State: TDragState; var Accept: Boolean);
//  var DraggableField: integer;
//begin
//    //Sender := DBGrid1.Field
//end;
//
//procedure TfmMainWindow.DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
//  Shift: TShiftState; X, Y: Integer);
//begin
//  //Begindrag(false);
//  inherited;
//end;
//
//procedure TfmMainWindow.DBGrid1StartDrag(Sender: TObject;
//  var DragObject: TDragObject);
//  var plumberid: integer;
//begin
//  Begindrag(true);
//  plumberid := mainWindow.fmMainWindow.DBGrid1.SelectedField.Value;
//end;
//
//procedure TfmMainWindow.DBGrid2CellClick(Column: TColumn);
//begin
//    curID := dm.DataModule1.dsetOrders.FieldByName('ORDER_ID').Value;
//end;
//
//////////////////////////////
////Принятие информации гридами
//procedure TfmMainWindow.DBGrid3DragDrop(Sender, Source: TObject; X, Y: Integer);
//begin
//  (Sender as TDBGridColumns).Assign(Source as TDbGridColumns);
//end;
//
//procedure TfmMainWindow.DBGrid3DragOver(Sender, Source: TObject; X, Y: Integer;
//  State: TDragState; var Accept: Boolean);
//begin
//   Accept := Sender is TDBGridColumns;
//end;
//////////////////////////////

//sort ----
//procedure TfmMainWindow.DBGrid1TitleClick(Column: TColumn);
//begin
//  Column.Field.DataSet.FieldByName('ORDER_INFO_ID');
//end;

procedure TfmMainWindow.UpdateGrids();
 var login, password, plumberStatus, plumberName, s:string;
      responseJSON : TJSONObject;
      plumbers, orders, ordersinfo, plumbersArrayData:TJSONValue;
      plumbersArray:TJSONArray;
      i:integer;
      plumberId:integer;
      JSONBytes:string;
      url:string;
      response:string;
      begin
        login:=TOperatorEntry.eLogin.Text;
        password:=TOperatorEntry.ePassword.Text;
        dm.DataModule1.BackendEndpoint1.AddParameter('task','auth');
        dm.DataModule1.BackendEndpoint1.AddParameter('mode','1');
        dm.DataModule1.BackendEndpoint1.AddParameter('login', login);
        dm.DataModule1.BackendEndpoint1.AddParameter('password',password);
        dm.DataModule1.BackendEndpoint1.Execute;
        s:=dm.DataModule1.RESTResponseGet.Content;

        if (s.Length>45) then  begin
          responseJSON:=TJSONObject.ParseJSONValue(s) as TJSONObject;
          TOperatorEntry.opID:=responseJSON.GetValue<integer>('ID');
        end;
end;

procedure TfmMainWindow.ForceUpdateBtnClick(Sender: TObject);
  var login, password, plumberStatus, plumberName, s:string;
      responseJSON : TJSONObject;
      plumbers, orders, ordersinfo, plumbersArrayData:TJSONValue;
      plumbersArray:TJSONArray;
      i:integer;
      plumberId:integer;
      JSONBytes:string;
      url:string;
      response:string;
      begin
        Timer1.Enabled := False;
        login:=TOperatorEntry.eLogin.Text;
        password:=TOperatorEntry.ePassword.Text;
        dm.DataModule1.BackendEndpoint1.AddParameter('task','auth');
        dm.DataModule1.BackendEndpoint1.AddParameter('mode','1');
        dm.DataModule1.BackendEndpoint1.AddParameter('login', login);
        dm.DataModule1.BackendEndpoint1.AddParameter('password',password);
        dm.DataModule1.BackendEndpoint1.Execute;
        s:=dm.DataModule1.RESTResponseGet.Content;

        if (s.Length>45) then  begin
          responseJSON:=TJSONObject.ParseJSONValue(s) as TJSONObject;
          TOperatorEntry.opID:=responseJSON.GetValue<integer>('ID');
        end;
end;

procedure TfmMainWindow.FormActivate(Sender: TObject);
begin
  Timer1.Enabled := False;
  IdUDPServer1.Active:= False;
  IdUDPServer1.Bindings.Clear;
  IdUDPServer1.Bindings.Add.Port:=1488;
  IdUDPServer1.Active := True;
end;

procedure TfmMainWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmMainWindow.Close;
  TOperatorEntry.Show;
end;

procedure TfmMainWindow.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
  var RecievedStr: string;
begin
   RecievedStr:= BytesToString(AData, en7bit);
  if RecievedStr = 'update' then UpdateGrids;
end;

end.
