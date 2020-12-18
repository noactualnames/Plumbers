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
var login, password, plumberStatus, plumberName:string;
     responseJSON :TJSONObject;
      plumbers, orders, ordersinfo, plumbersArrayData:TJSONObject;
      plumbersArray:TJSONArray;
      i:integer;
      plumberId:integer;

begin
  login:=eLogin.Text;
  password:=ePassword.Text;
  dm.DataModule1.BackendEndpoint1.Params.ParameterByName('login').AddValue(login); //��������� �������� � ��������� �������
  dm.DataModule1.BackendEndpoint1.Params.ParameterByName('password').AddValue(password);
  dm.DataModule1.BackendEndpoint1.Execute;

  if (dm.DataModule1.RESTResponseGet.Content.Length>40) then  begin

    responseJSON:=dm.DataModule1.RESTResponseGet.JSONValue as TJSONObject;
    try
       plumbers:=responseJSON.Values['plumbers'] as TJSONObject;
       orders:=responseJSON.Values['orders'] as TJSONObject;
       ordersinfo:=responseJSON.Values['ordersinfo'] as TJSONObject;

       plumbersArray:=plumbers.GetValue('data') as TJSONArray;
       if Assigned(plumbersArray) then  begin

          dm.DataModule1.dsetPlumbers.Open;

          for i := 0 to plumbersArray.Count-1 do begin

           plumbersArrayData:=plumbersArray.Items[i] as TJSONObject;

           plumberId:=plumbersArrayData.getValue<integer>('PLUMBER_ID');
           plumberStatus:=plumbersArrayData.getValue<string>('PLUMBER_STATUS');
           plumberName:=plumbersArrayData.getValue<string>('PLUMBER_NAME');

           dm.DataModule1.dsetPlumbers.FieldByName('PLUMBER_ID').AsInteger:=plumberId;
           dm.DataModule1.dsetPlumbers.FieldByName('PLUMBER_STATUS').AsString:=plumberStatus;
           dm.DataModule1.dsetPlumbers.FieldByName('PLUMBER_ID').AsString:=plumberName;

          end;
        end;





    end else begin

    end;
  end;




//  if responseJSON.Length<40 then begin
//
//    fmErrorLogin:=TfmErrorLogin.Create(Application);
//    fmErrorLogin.ShowModal;
//    fmErrorLogin.Release;
//  end else begin
//    fmMainWindow:=TfmMainWindow.Create(Application);
//    fmMainWindow.ShowModal;
//    fmMainWindow.Release;
//  end;



end;


end.
