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
  Vcl.Grids, Vcl.DBGrids, operatorEntry, addPlumbers;

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
  private
    { Private declarations }
  public
    var plumberid: integer;
    var orderid: integer;
    { Public declarations }
  end;

var
  fmMainWindow: TfmMainWindow;
  curID: integer;

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

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

procedure TfmMainWindow.DBGrid1CellClick(Column: TColumn);
begin
  plumberid := mainWindow.fmMainWindow.DBGrid1.Fields[0].Value;
end;

procedure TfmMainWindow.DBGrid2CellClick(Column: TColumn);
begin
  orderid := mainWindow.fmMainWindow.DBGrid2.Fields[0].Value;
end;

procedure TfmMainWindow.addPlumberBtnClick(Sender: TObject);
  var body: TJSONObject;
begin
  addPlumber := TaddPlumber.Create(Application);
  addPlumber.ShowModal;
  addPlumber.Release;
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

procedure TfmMainWindow.FormActivate(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TfmMainWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmMainWindow.Close;
  TOperatorEntry.Show;
end;



end.
