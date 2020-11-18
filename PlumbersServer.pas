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
    FDCheckOperatorAuth: TFDStoredProc;
    FDRegOP: TFDStoredProc;
    FDAddOrder: TFDStoredProc;
    FDAddOrderInfo: TFDStoredProc;
    FDChangeOpEditStatus: TFDStoredProc;
    FDCheckPlumberAuth: TFDStoredProc;
    FDRegPlumber: TFDStoredProc;
    FDUpdatePlumAndOrderStatus: TFDStoredProc;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    function GetDbData(FDQuery: TFDQuery): TJSONObject;
    function GetAllDBData(): TJSONObject;

    function FormJSONResponseMessage(msgtype: string; msg: string): TJSONObject;

    function CheckAccountAuthorization(ARequest: TEndpointRequest; var ID: integer): Boolean;
    function AuthAccount(ARequest: TEndpointRequest): TJSONObject;

    function CheckAccountLoginExists(Login: string; AuthMode: integer): Boolean;
    function RegisterAccount(ARequest: TEndpointRequest): TJSONObject;

    function SetDateFormatSettings(): TFormatSettings;
    procedure SetOperatorEditStatus(CreatorOpID: integer; EditorOpID: integer);
    function AddOrChangeOrder(ResponseObject : TJSONObject): integer;
    function AddOrChangeOrderInfo(ResponseObject: TJSONObject; AddedOrderID: integer) : integer;
    function AddOrChangeOrderAndOrderInfo(ARequest: TEndpointRequest): TJSONObject;

    function AssignPlumberToOrder(ARequest: TEndpointRequest): TJSONObject;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TPlumbersResource1.FormJSONResponseMessage(msgtype: string; msg: string): TJSONObject;

begin
  Result:= TJSONObject.Create;
  Result.AddPair(msgtype, msg);
end;


function TPlumbersResource1.CheckAccountAuthorization(ARequest: TEndpointRequest; var ID: integer): Boolean;
var LoginStr, PasswordStr, HashedPassword, AuthModeStr: string;
truth: Boolean;
StoredProc: TFDStoredProc;
AuthMode: integer;
begin
  Result:= false;
  ARequest.Params.TryGetValue('login', LoginStr);
  ARequest.Params.TryGetValue('password', PasswordStr);
  ARequest.Params.TryGetValue('mode', AuthModeStr);
  AuthMode:= StrToInt(AuthModeStr);
  HashedPassword:= THashSHA2.GetHashString(PasswordStr);

  case AuthMode of
    1: StoredProc:= FDCheckOperatorAuth;
    2: StoredProc:= FDCheckPlumberAuth;
  end;

  if AuthMode <> 0 then begin
    StoredProc.Prepare;
    StoredProc.ParamByName('in_only_login').Value:= false;
    StoredProc.ParamByName('in_login').Value:= LoginStr;
    StoredProc.ParamByName('in_password').Value:= HashedPassword;
    StoredProc.ExecProc;

    case AuthMode of
      1: ID:= StoredProc.Params.FindParam('out_op_id').AsInteger;
      2: ID:= StoredProc.Params.FindParam('out_plum_id').AsInteger;
    end;

    Result:= StoredProc.Params.FindParam('out_equality').AsBoolean;
  end;
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

function TPlumbersResource1.AuthAccount(ARequest: TEndpointRequest): TJSONObject;
var ID, AuthMode: integer;
AuthModeStr: string;
begin
    Result:= TJSONObject.Create;
    if CheckAccountAuthorization(ARequest, ID) then begin
      ARequest.Params.TryGetValue('mode', AuthModeStr);
      AuthMode:= StrToInt(AuthModeStr);
      case AuthMode of
      1:
        begin
          Result:= GetAllDBData();
        end;
      2:
        begin
        // В случае надобности добавить что-то сюда
        end;
      end;

      Result.AddPair('ID', TJSONNumber.Create(ID));
    end
    else Result:= FormJSONResponseMessage('error', 'Invalid login or password');
end;

function TPlumbersResource1.CheckAccountLoginExists(Login: string; AuthMode: integer): Boolean;
var StoredProc: TFDStoredProc;
begin
  Result:= false;

  case AuthMode of
    1: StoredProc:= FDCheckOperatorAuth;
    2: StoredProc:= FDCheckPlumberAuth;
  end;

  if AuthMode <> 0 then begin
    StoredProc.Prepare;
    StoredProc.ParamByName('in_login').Value:= Login;
    StoredProc.ParamByName('in_only_login').Value:= true;
    StoredProc.ExecProc;
    Result:= StoredProc.Params.FindParam('out_equality').AsBoolean;
  end;
end;

function TPlumbersResource1.RegisterAccount(ARequest: TEndpointRequest): TJSONObject;
var
AuthMode: integer;
AccountData: TJSONObject;
Name, Login, Password, AuthModeStr: string;
StoredProc: TFDStoredProc;
begin
  ARequest.Headers.TryGetValue('mode', AuthModeStr);
  AuthMode:= StrToInt(AuthModeStr);
  AccountData:= TJSONObject.Create;
  if ARequest.Body.TryGetObject(AccountData) then begin
      Login:= AccountData.GetValue('login').Value;
      if not CheckAccountLoginExists(Login, AuthMode) then begin
        Name:= AccountData.GetValue('name').Value;

        Password:= AccountData.GetValue('password').Value;
        Password:= THashSHA2.GetHashString(Password);

        case AuthMode of
          1: StoredProc:= FDRegOP;
          2: StoredProc:= FDRegPlumber;
        end;

        StoredProc.Prepare;
        StoredProc.ParamByName('in_id').Value:= 0;
        StoredProc.ParamByName('in_name').Value:= Name;
        StoredProc.ParamByName('in_login').Value:= Login;
        StoredProc.ParamByName('in_password').Value:= Password;

        case AuthMode of
          1: StoredProc.ParamByName('in_edit_status').Value:= false;
          2: StoredProc.ParamByName('in_status').Value:= 'Не в сети';
        end;

        StoredProc.ExecProc;
        Result:= FormJSONResponseMessage('response', 'Registration made successfully');
      end
      else Result:= FormJSONResponseMessage('error', 'This login is already used');
  end
  else Result:= FormJSONResponseMessage('error', 'JSON expected');
end;


function TPlumbersResource1.SetDateFormatSettings(): TFormatSettings;
begin
  Result := TFormatSettings.Create;
  Result.DateSeparator := '.';
  Result.ShortDateFormat := 'dd.MM.yyyy';
  Result.TimeSeparator := ':';
  Result.ShortTimeFormat := 'hh:mm';
  Result.LongTimeFormat := 'hh:mm:ss';
end;

procedure TPlumbersResource1.SetOperatorEditStatus(CreatorOpID: integer; EditorOpID: integer);
begin
  if CreatorOpID <> EditorOpID then begin
    FDChangeOpEditStatus.Prepare;
    FDChangeOpEditStatus.ParamByName('in_id').Value:= EditorOpID;
    FDChangeOpEditStatus.ParamByName('in_status').Value:= True;
    FDChangeOpEditStatus.ExecProc;
  end;
end;

function TPlumbersResource1.AddOrChangeOrder(ResponseObject : TJSONObject): integer;
var
OrderData: TJSONObject;
ChangeOrCreateOrderID, OperatorID: integer;
TmpOrderID, TmpOpID: TJSONNumber;
DateFormatSettings: TFormatSettings;
begin
  if ResponseObject.TryGetValue('orderid', TmpOrderID) then
    ChangeOrCreateOrderID:= TmpOrderID.Value.ToInteger;
  if ResponseObject.TryGetValue('operatorid', TmpOpID) then
    OperatorID:= TmpOpID.Value.ToInteger;
  DateFormatSettings:= SetDateFormatSettings;
  Result:= 0;

  if ResponseObject.TryGetValue('orderdata', OrderData) then begin
    FDAddOrder.Prepare;
    FDAddOrder.ParamByName('in_id').Value:= ChangeOrCreateOrderID;

    if ChangeOrCreateOrderID = 0 then
    begin
      FDAddOrder.ParamByName('in_creation_date').Value:= StrToDateTime(OrderData.GetValue('creation_date').Value, DateFormatSettings);
      FDAddOrder.ParamByName('in_operator_id').Value:= OrderData.GetValue('order_operator_id').Value.ToInteger;
      FDAddOrder.ParamByName('in_status').Value:= OrderData.GetValue('order_status').Value;
      FDAddOrder.ExecProc;
      Result:= FDAddOrder.Params.FindParam('out_order_id').AsInteger;
    end
    else begin
      SetOperatorEditStatus(OrderData.GetValue('order_operator_id').Value.ToInteger, OperatorID);
      FDAddOrder.ParamByName('in_status').Value:= OrderData.GetValue('order_status').Value;
      FDAddOrder.ParamByName('in_plumber_id').Value:= OrderData.GetValue('order_plumber_id').Value.ToInteger;
      FDAddOrder.ExecProc;
      Result:= ChangeOrCreateOrderID;
    end;
  end;
end;

function TPlumbersResource1.AddOrChangeOrderInfo(ResponseObject: TJSONObject; AddedOrderID: integer): integer;
var
OrderInfoData: TJSONObject;
begin
    Result:= 0;
    if ResponseObject.TryGetValue('orderinfodata', OrderInfoData) and (AddedOrderID <> 0) then begin
      FDAddOrderInfo.Prepare;
      FDAddOrderInfo.ParamByName('in_order_id').Value:= AddedOrderID;
      FDAddOrderInfo.ParamByName('in_type').Value:= OrderInfoData.GetValue('type').Value;
      FDAddOrderInfo.ParamByName('in_description').Value:= OrderInfoData.GetValue('description').Value;
      FDAddOrderInfo.ParamByName('in_price').Value:= OrderInfoData.GetValue('price').Value.ToDouble;
      FDAddOrderInfo.ParamByName('in_phone').Value:= OrderInfoData.GetValue('phone').Value.ToInt64;
      FDAddOrderInfo.ParamByName('in_address').Value:= OrderInfoData.GetValue('address').Value;
      FDAddOrderInfo.ExecProc;

      Result:= FDAddOrderInfo.Params.FindParam('out_id').AsInteger;
    end;
end;

function TPlumbersResource1.AddOrChangeOrderAndOrderInfo(ARequest: TEndpointRequest): TJSONObject;
var
ResponseObject: TJSONObject;
AddedOrderID, AddedOrderInfoID: integer;
begin
  ResponseObject:= TJSONObject.Create;

  if ARequest.Body.TryGetObject(ResponseObject) then begin
    AddedOrderID:= AddOrChangeOrder(ResponseObject);
    AddedOrderInfoID:= AddOrChangeOrderInfo(ResponseObject, AddedOrderID);

    if (AddedOrderID <> 0) and (AddedOrderInfoID <> 0) then
      Result:= FormJSONResponseMessage('response', 'New Data added')
    else
      Result:= FormJSONResponseMessage('error', 'Something went wrong');
  end;

end;

function TPlumbersResource1.AssignPlumberToOrder(ARequest: TEndpointRequest): TJSONObject;
var
ResponseObject: TJSONObject;
OrderID, PlumberID: integer;
Status: string;
begin
  ResponseObject:= TJSONObject.Create;
  if ARequest.Body.TryGetObject(ResponseObject) then begin
    FDUpdatePlumAndOrderStatus.Prepare;
    if ResponseObject.TryGetValue('order_id', OrderID) then
      FDUpdatePlumAndOrderStatus.ParamByName('in_order_id').Value:= OrderID;
    if ResponseObject.TryGetValue('plumber_id', PlumberID) then
      FDUpdatePlumAndOrderStatus.ParamByName('in_plumber_id').Value:= PlumberID;
    if ResponseObject.TryGetValue('status', Status) then
      FDUpdatePlumAndOrderStatus.ParamByName('in_status').Value:= Status;
    FDUpdatePlumAndOrderStatus.ExecProc;
    Result:= FormJSONResponseMessage('response', 'Status updated');
  end
  else Result:= FormJSONResponseMessage('error', 'JSON expected');
end;

procedure TPlumbersResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var JSONResponse: TJSONObject;
QueryTask: string;
begin
  JSONResponse:= TJSONObject.Create;
  ARequest.Headers.TryGetValue('task', QueryTask);

  if QueryTask = 'auth' then JSONResponse:= AuthAccount(ARequest);

  AResponse.Body.SetValue(JSONResponse, True);
end;

procedure TPlumbersResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var JSONResponse: TJSONObject;
QueryTask: string;
begin
  JSONResponse:= TJSONObject.Create;
  ARequest.Headers.TryGetValue('task', QueryTask);

  if QueryTask = 'reg' then JSONResponse:= RegisterAccount(ARequest);
  if QueryTask = 'order' then  JSONResponse:= AddOrChangeOrderAndOrderInfo(ARequest);
  if QueryTask = 'assign' then JSONResponse:= AssignPlumberToOrder(ARequest);

  AResponse.Body.SetValue(JSONResponse, True);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TPlumbersResource1));
end;

initialization
  Register;
end.


