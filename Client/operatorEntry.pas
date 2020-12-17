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
  Data.Bind.Components, Data.Bind.ObjectScope;

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

  end;

var
  TOperatorEntry: TTOperatorEntry;

implementation

{$R *.dfm}

uses dm, errorLogin, mainWindow;

procedure TTOperatorEntry.btnEntryClick(Sender: TObject);
var login, password:string;
     responseJSON:string;
begin
  login:=eLogin.Text;
  password:=ePassword.Text;
  dm.DataModule1.BackendEndpoint1.Params.ParameterByName('login').AddValue(login); //��������� �������� � ��������� �������
  dm.DataModule1.BackendEndpoint1.Params.ParameterByName('password').AddValue(password);
  dm.DataModule1.BackendEndpoint1.Execute;



  if responseJSON.Length<40 then begin

    fmErrorLogin:=TfmErrorLogin.Create(Application);
    fmErrorLogin.ShowModal;
    fmErrorLogin.Release;
  end else begin
    fmMainWindow:=TfmMainWindow.Create(Application);
    fmMainWindow.ShowModal;
    fmMainWindow.Release;
  end;



end;


end.
