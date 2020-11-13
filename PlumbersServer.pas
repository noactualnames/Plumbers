unit PlumbersServer;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Hash,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  [ResourceName('Plumbers')]
  TPlumbersResource1 = class(TDataModule)
    FDPlumDBConnection: TFDConnection;
    FDSelectOperators: TFDQuery;
    FDSelectOrders: TFDQuery;
    FDSelectOrdersInfo: TFDQuery;
    FDSelectPlumbers: TFDQuery;
    FDCheckAuth: TFDStoredProc;
    FDRegOP: TFDStoredProc;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    function GetDbData(FDQuery: TFDQuery): TJSONObject;
    function GetAllDBData(): TJSONObject;

    function FormJSONResponseMessage(msgtype: string; msg: string): TJSONObject;

    function CheckOperatorAuthorization(ARequest: TEndpointRequest; var opID: integer): Boolean;
    function AuthOperator(ARequest: TEndpointRequest): TJSONObject;

    function CheckOperatorLoginExists(Login: string): Boolean;
    function RegisterOperator(ARequest: TEndpointRequest): TJSONObject;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TPlumbersResource1.FormJSONResponseMessage(msgtype: string; msg: string): TJSONObject;

begin
  Result:= TJSONObject.Create;
  Result.AddPair(msgtype, msg);
end;


function TPlumbersResource1.CheckOperatorAuthorization(ARequest: TEndpointRequest; var opID: integer): Boolean;
var LoginStr, PasswordStr, HashedPassword: string;
truth: Boolean;
begin
  ARequest.Params.TryGetValue('login', LoginStr);
  ARequest.Params.TryGetValue('password', PasswordStr);
  HashedPassword:= THashSHA2.GetHashString(PasswordStr);
  FDCheckAuth.Prepare;
  FDCheckAuth.ParamByName('in_only_login').Value:= false;
  FDCheckAuth.ParamByName('in_login').Value:= LoginStr;
  FDCheckAuth.ParamByName('in_password').Value:= HashedPassword;
//  FDCheckAuth.Params[0].Value:= HashedPassword;
//  FDCheckAuth.Params[1].Value:= LoginStr;
  FDCheckAuth.ExecProc;
//  opID:= FDCheckAuth.Params.Items[2].AsInteger;
//  Result:= FDCheckAuth.Params.Items[3].AsBoolean;
opID:= FDCheckAuth.Params.FindParam('out_op_id').AsInteger;
Result:= FDCheckAuth.Params.FindParam('out_equality').AsBoolean;
end;

function TPlumbersResource1.GetDbData(FDQuery: TFDQuery): TJSONObject;
var dbArrayData: TJSONArray;
mainContainer, dbRow: TJSONObject;
columnName: string;
I: Integer;
begin
    FDQuery.Open();
    FDQuery.First;
    mainContainer:= TJSONObject.Create;
    dbArrayData:= TJSONArray.Create;
    while (not FDQuery.EOF) do
    begin
      dbRow:= TJSONObject.Create;
      for I := 0 to FDQuery.FieldDefs.Count - 1 do
      begin
        columnName:= FDQuery.FieldDefs[I].Name;
        if (FDQuery.FieldByName(columnName).DataType = ftInteger)
        or (FDQuery.FieldByName(columnName).DataType = ftFloat) then
            dbRow.AddPair(columnName,
                          TJSONNumber.Create(FDQuery.FieldByName(columnName).AsString))
        else dbRow.AddPair(columnName,
                           TJSONString.Create(FDQuery.FieldByName(columnName).AsString));
      end;
      dbArrayData.Add(dbRow);
      dbRow:= TJSONObject.Create;
      FDQuery.Next;
    end;
    FDQuery.Close;
    mainContainer.AddPair('data', dbArrayData);
    Result:= mainContainer;
end;

function TPlumbersResource1.GetAllDBData(): TJSONObject;
var JSONResponse: TJSONObject;
begin
    JSONResponse:= TJSONObject.Create;
    JSONResponse.AddPair('plumbers', GetDbData(FDSelectPlumbers));
    JSONResponse.AddPair('orders', GetDbData(FDSelectOrders));
    JSONResponse.AddPair('ordersinfo', GetDbData(FDSelectOrdersInfo));
    Result:= JSONResponse;
end;

function TPlumbersResource1.AuthOperator(ARequest: TEndpointRequest): TJSONObject;
var opID: integer;
begin
    if CheckOperatorAuthorization(ARequest, opID) then begin
      Result:= GetAllDBData();
      Result.AddPair('opID', TJSONNumber.Create(opID));
    end
    else Result:= FormJSONResponseMessage('error', 'Invalid login or password');
end;

function TPlumbersResource1.CheckOperatorLoginExists(Login: string): Boolean;
begin
  FDCheckAuth.Prepare;
  FDCheckAuth.ParamByName('in_login').Value:= Login;
  FDCheckAuth.ParamByName('in_only_login').Value:= true;
  FDCheckAuth.ExecProc;
  Result:= FDCheckAuth.Params.FindParam('out_equality').AsBoolean;
end;

function TPlumbersResource1.RegisterOperator(ARequest: TEndpointRequest): TJSONObject;
var
OperatorData: TJSONObject;
Name, Login, Password: string;
begin
  OperatorData:= TJSONObject.Create;
  if ARequest.Body.TryGetObject(OperatorData) then begin
      Login:= OperatorData.GetValue('login').Value;
      if not CheckOperatorLoginExists(Login) then begin
        Name:= OperatorData.GetValue('name').Value;

        Password:= OperatorData.GetValue('password').Value;
        Password:= THashSHA2.GetHashString(Password);

        FDRegOP.Prepare;
        FDRegOP.ParamByName('in_id').Value:= 0;
        FDRegOP.ParamByName('in_name').Value:= Name;
        FDRegOP.ParamByName('in_login').Value:= Login;
        FDRegOP.ParamByName('in_password').Value:= Password;
        FDRegOP.ParamByName('in_edit_status').Value:= false;
        FDRegOP.ExecProc;

        Result:= FormJSONResponseMessage('response', 'Registration made successfully');
      end
      else Result:= FormJSONResponseMessage('error', 'This login is already used');
  end
  else Result:= FormJSONResponseMessage('error', 'JSON expected');
end;

procedure TPlumbersResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var JSONResponse: TJSONObject;
QueryTask: string;
begin
  JSONResponse:= TJSONObject.Create;
  ARequest.Headers.TryGetValue('task', QueryTask);

  if QueryTask = 'auth' then JSONResponse:= AuthOperator(ARequest);

  AResponse.Body.SetValue(JSONResponse, True);
end;

procedure TPlumbersResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('Plumbers ' + LItem), True)
end;

procedure TPlumbersResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var JSONResponse: TJSONObject;
QueryTask: string;
begin
  JSONResponse:= TJSONObject.Create;
  ARequest.Headers.TryGetValue('task', QueryTask);

  if QueryTask = 'reg' then JSONResponse:= RegisterOperator(ARequest);

  AResponse.Body.SetValue(JSONResponse, True);
end;

procedure TPlumbersResource1.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
end;

procedure TPlumbersResource1.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TPlumbersResource1));
end;

initialization
  Register;
end.


