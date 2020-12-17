unit dm;

interface

uses
  System.SysUtils, System.Classes, REST.Backend.ServiceTypes, System.JSON,
  REST.Backend.EMSServices, Data.DB, Datasnap.DBClient, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.EndPoint, REST.Backend.EMSProvider;

type
  TDataModule1 = class(TDataModule)
    EMSProvider1: TEMSProvider;
    BackendEndpoint1: TBackendEndpoint;
    AdapterPlumbers: TRESTResponseDataSetAdapter;
    dsetPlumbers: TClientDataSet;
    AdapterOrders: TRESTResponseDataSetAdapter;
    AdapterOrdersInfo: TRESTResponseDataSetAdapter;
    dsetOrders: TClientDataSet;
    dsetOrdersInfo: TClientDataSet;
    dsPlumbers: TDataSource;
    dsOrders: TDataSource;
    dsOrdersInfo: TDataSource;
    RESTResponseGet: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
