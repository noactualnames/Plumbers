unit operatorEntry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON;

type
  TTOperatorEntry = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    eLogin: TEdit;
    ePassword: TEdit;
    btnEntry: TButton;
    IdHTTP1: TIdHTTP;
    FDQuery1: TFDQuery;
    procedure btnEntryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  TOperatorEntry: TTOperatorEntry;

implementation

{$R *.dfm}

procedure TTOperatorEntry.btnEntryClick(Sender: TObject);
var url,login,password: string;
    resultJSON:TJSONObject;
    resultJSONArray: TJSONArray;
begin
   login:=eLogin.Text;
   password:=ePassword.Text;
   url:='http://localhost:8080/Plumbers&task=auth&mode=1?login='+login+'&password='+password;

    resultJSON:=TJSONObject.Create;
    resultJSONArray:=TJSONArray.Create;
    resultJSON:=TJSONObject.ParseJSONValue(IdHTTP1.Get(url)) as TJSONObject;
     try

     finally

     end;



end;


end.