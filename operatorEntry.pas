unit operatorEntry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON,
  REST.Backend.ServiceTypes, REST.Client, REST.Backend.EndPoint,
  Data.Bind.Components, Data.Bind.ObjectScope, System.IOUtils;

type
  TTOperatorEntry = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    eLogin: TEdit;
    ePassword: TEdit;
    btnEntry: TButton;
    procedure btnEntryClick(Sender: TObject);
  private
    { Private declarations }
    UserValue:integer;
    UserData:string;
    ChangesUserObject:TJSONArray;
    ChangesDataObject:TJSONArray;
  public
    { Public declarations }
      opID:integer;

  end;

var
  TOperatorEntry: TTOperatorEntry;

implementation

{$R *.dfm}

uses dm, errorLogin, mainWindow;

procedure TTOperatorEntry.btnEntryClick(Sender: TObject);
var login, password, plumberStatus, plumberName, s:string;
     responseJSON :TJSONObject;
      plumbers, orders, ordersinfo, plumbersArrayData:TJSONValue;
      plumbersArray:TJSONArray;
      i:integer;
      plumberId:integer;
      JSONBytes:string;
      url:string;
      response:string;

begin
  login:=eLogin.Text;
  password:=ePassword.Text;

  dm.DataModule1.BackendEndpoint1.AddParameter('task','auth');
  dm.DataModule1.BackendEndpoint1.AddParameter('mode','1');
  dm.DataModule1.BackendEndpoint1.AddParameter('login', login);
  dm.DataModule1.BackendEndpoint1.AddParameter('password',password);
  dm.DataModule1.BackendEndpoint1.Execute;
  s:=dm.DataModule1.RESTResponseGet.Content;

  if (s.Length>45) then  begin

   responseJSON:=TJSONObject.ParseJSONValue(s) as TJSONObject;
      opID:=responseJSON.GetValue<integer>('ID');

    TOperatorEntry.Hide;
    fmMainWindow:=TfmMainWindow.Create(Application);
    fmMainWindow.ShowModal;
    fmMainWindow.Release;

  end else begin

    MessageDlg('������������ ����� ��� ������',mtError, mbOKCancel, 0);

    end;
end;


end.
