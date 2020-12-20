object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 606
  Width = 876
  object EMSProvider1: TEMSProvider
    ApiVersion = '2'
    URLHost = 'localhost'
    URLPort = 8080
    Left = 128
    Top = 16
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
    Left = 216
    Top = 16
  end
  object dsetPlumbers: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
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
    Left = 48
    Top = 200
  end
  object dsetOrders: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 200
  end
  object dsetOrdersInfo: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 200
  end
  object dsPlumbers: TDataSource
    DataSet = dsetPlumbers
    Left = 40
    Top = 280
  end
  object dsOrders: TDataSource
    DataSet = dsetOrders
    Left = 168
    Top = 280
  end
  object dsOrdersInfo: TDataSource
    DataSet = dsetOrdersInfo
    Left = 320
    Top = 272
  end
  object RESTResponseGet: TRESTResponse
    Left = 168
    Top = 88
  end
  object AdapterPlumbers: TRESTResponseDataSetAdapter
    Dataset = dsetPlumbers
    FieldDefs = <
      item
        Name = 'PLUMBER_ID'
        DataType = ftInteger
      end
      item
        Name = 'PLUMBER_STATUS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PLUMBER_NAME'
        DataType = ftString
        Size = 100
      end>
    Response = RESTResponseGet
    RootElement = 'plumbers.data'
    Left = 48
    Top = 144
  end
  object AdapterOrders: TRESTResponseDataSetAdapter
    Dataset = dsetOrders
    FieldDefs = <
      item
        Name = 'ORDER_ID'
        DataType = ftInteger
      end
      item
        Name = 'CREATION_DATE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'BEGIN_DATE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'READ_DATE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'END_DATE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ORDER_STATUS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ORDER_PLUMBER_ID'
        DataType = ftInteger
      end
      item
        Name = 'ORDER_OPERATOR_ID'
        DataType = ftInteger
      end>
    Response = RESTResponseGet
    RootElement = 'orders.data'
    Left = 168
    Top = 152
  end
  object AdapterOrdersInfo: TRESTResponseDataSetAdapter
    Dataset = dsetOrdersInfo
    FieldDefs = <
      item
        Name = 'ORDER_INFO_ID'
        DataType = ftInteger
      end
      item
        Name = 'ORDER_TYPE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ORDER_DESCRIPTION'
        DataType = ftString
        Size = 1000
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
    Response = RESTResponseGet
    RootElement = 'ordersinfo.data'
    Left = 320
    Top = 152
  end
  object BackendEndpoint2: TBackendEndpoint
    Provider = EMSProvider1
    Method = rmPOST
    Params = <>
    Resource = 'Plumbers'
    Response = RESTResponsePost
    Left = 568
    Top = 16
  end
  object RESTResponsePost: TRESTResponse
    ContentType = 'application/json'
    Left = 568
    Top = 80
  end
end
