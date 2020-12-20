object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 606
  Width = 876
  object EMSProvider1: TEMSProvider
    ApiVersion = '2'
    URLHost = 'localhost'
    URLPort = 8080
    Left = 40
    Top = 32
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
    Left = 144
    Top = 32
  end
  object AdapterPlumbers: TRESTResponseDataSetAdapter
    Dataset = dsetPlumbers
    FieldDefs = <>
    Response = RESTResponseGet
    RootElement = 'plumbers.data'
    Left = 88
    Top = 200
  end
  object dsetPlumbers: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PLUMBER_ID'
        DataType = ftInteger
      end
      item
        Name = 'PLUMBER_STATUS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PLUMBER_NAME'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'PLUMBER_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'PLUMBER_STATUS'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'PLUMBER_NAME'
        ParamType = ptUnknown
      end>
    StoreDefs = True
    Left = 88
    Top = 280
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
    FieldDefs = <
      item
        Name = 'ORDER_ID'
        DataType = ftInteger
      end
      item
        Name = 'CREATION_DATE'
        DataType = ftDateTime
      end
      item
        Name = 'BEGIN_DATE'
        DataType = ftDateTime
      end
      item
        Name = 'READ_DATE'
        DataType = ftDateTime
      end
      item
        Name = 'END_DATE'
        DataType = ftDateTime
      end
      item
        Name = 'ORDER_STATUS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ORDER_PLUMBER_ID'
        DataType = ftInteger
      end
      item
        Name = 'ORDER_OPERATOR_ID'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 240
    Top = 272
  end
  object dsetOrdersInfo: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ORDERS_INFO_ID'
        DataType = ftInteger
      end
      item
        Name = 'ORDER_TYPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ORDER_DESCRIPTION'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ORDER_PRICE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CUSTOMER_PHONE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CUSTOMER_ADDRESS'
        DataType = ftString
        Size = 100
      end>
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