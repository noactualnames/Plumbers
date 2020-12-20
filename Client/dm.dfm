object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 606
  Width = 876
  object EMSProvider1: TEMSProvider
    ApiVersion = '2'
    URLHost = 'localhost'
    URLPort = 8080
    Left = 192
    Top = 96
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
    Left = 280
    Top = 96
  end
  object dsetPlumbers: TClientDataSet
    PersistDataPacket.Data = {
      710000009619E0BD01000000180000000300000000000300000071000A504C55
      4D4245525F494404000100000000000E504C554D4245525F5354415455530100
      4900000001000557494454480200020064000C504C554D4245525F4E414D4501
      004900000001000557494454480200020064000000}
    Active = True
    Aggregates = <>
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
  object dsetOrders: TClientDataSet
    PersistDataPacket.Data = {
      CB0000009619E0BD010000001800000008000000000003000000CB00084F5244
      45525F494404000100000000000D4352454154494F4E5F444154450800080000
      0000000A424547494E5F44415445080008000000000009524541445F44415445
      080008000000000008454E445F4441544508000800000000000C4F524445525F
      5354415455530100490000000100055749445448020002006400104F52444552
      5F504C554D4245525F49440400010000000000114F524445525F4F5045524154
      4F525F494404000100000000000000}
    Active = True
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
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 232
    Top = 280
  end
  object dsetOrdersInfo: TClientDataSet
    PersistDataPacket.Data = {
      6A0000009619E0BD010000001800000001000100000003000000340005657272
      6F7202004A000000010005574944544802000200FE0100000000320049006E00
      760061006C006900640020006C006F00670069006E0020006F00720020007000
      61007300730077006F0072006400}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'error'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 280
  end
  object dsPlumbers: TDataSource
    DataSet = dsetPlumbers
    Left = 88
    Top = 368
  end
  object dsOrders: TDataSource
    DataSet = dsetOrders
    Left = 232
    Top = 368
  end
  object dsOrdersInfo: TDataSource
    DataSet = dsetOrdersInfo
    Left = 384
    Top = 368
  end
  object RESTResponseGet: TRESTResponse
    ContentType = 'application/json'
    Left = 232
    Top = 168
  end
  object AdapterPlumbers: TRESTResponseDataSetAdapter
    Active = True
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
    Left = 88
    Top = 232
  end
  object AdapterOrders: TRESTResponseDataSetAdapter
    Active = True
    Dataset = dsetOrders
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
    Left = 232
    Top = 232
  end
  object AdapterOrdersInfo: TRESTResponseDataSetAdapter
    Active = True
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
    Left = 384
    Top = 232
  end
end
