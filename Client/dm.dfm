object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 606
  Width = 876
  object EMSProvider1: TEMSProvider
    ApiVersion = '2'
    URLHost = 'localhost'
    URLPort = 8080
    Left = 24
    Top = 40
  end
  object BackendEndpoint1: TBackendEndpoint
    Provider = EMSProvider1
    Params = <
      item
        Name = 'task'
        Value = 'auth'
      end
      item
        Name = 'mode'
        Value = '1'
      end
      item
        Name = 'login'
      end
      item
        Name = 'password'
      end>
    Resource = 'Plumbers'
    Response = RESTResponseGet
    Left = 104
    Top = 32
  end
  object AdapterPlumbers: TRESTResponseDataSetAdapter
    Dataset = dsetPlumbers
    FieldDefs = <>
    Response = RESTResponseGet
    RootElement = 'plumbers.data'
    Left = 88
    Top = 216
  end
  object dsetPlumbers: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 88
    Top = 304
  end
  object AdapterOrders: TRESTResponseDataSetAdapter
    Dataset = dsetOrders
    FieldDefs = <>
    Response = RESTResponseGet
    RootElement = 'orders.data'
    Left = 232
    Top = 192
  end
  object AdapterOrdersInfo: TRESTResponseDataSetAdapter
    Dataset = dsetOrdersInfo
    FieldDefs = <>
    Response = RESTResponseGet
    RootElement = 'ordersinfo.data'
    Left = 384
    Top = 192
  end
  object dsetOrders: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 240
    Top = 272
  end
  object dsetOrdersInfo: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 272
  end
  object dsPlumbers: TDataSource
    DataSet = dsetPlumbers
    Left = 88
    Top = 368
  end
  object dsOrders: TDataSource
    DataSet = dsetOrders
    Left = 240
    Top = 352
  end
  object dsOrdersInfo: TDataSource
    DataSet = dsetOrdersInfo
    Left = 384
    Top = 352
  end
  object RESTResponseGet: TRESTResponse
    ContentType = 'application/json'
    Left = 256
    Top = 112
  end
end
