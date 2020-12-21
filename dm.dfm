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
    Left = 48
    Top = 208
  end
  object dsetOrders: TClientDataSet
    PersistDataPacket.Data = {
      FB0000009619E0BD010000001800000008000000000003000000FB00084F5244
      45525F494404000100000000000D4352454154494F4E5F444154450100490000
      000100055749445448020002001E000A424547494E5F44415445010049000000
      0100055749445448020002001E0009524541445F444154450100490000000100
      055749445448020002001E0008454E445F444154450100490000000100055749
      445448020002001E000C4F524445525F53544154555301004900000001000557
      49445448020002006400104F524445525F504C554D4245525F49440400010000
      000000114F524445525F4F50455241544F525F494404000100000000000000}
    Active = True
    Aggregates = <>
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
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 208
  end
  object dsetOrdersInfo: TClientDataSet
    PersistDataPacket.Data = {
      DD0000009619E0BD010000001800000006000000000003000000DD000D4F5244
      45525F494E464F5F494404000100000000000A4F524445525F54595045010049
      0000000100055749445448020002006400114F524445525F4445534352495054
      494F4E020049000000010005574944544802000200E8030B4F524445525F5052
      49434501004900000001000557494454480200020014000E435553544F4D4552
      5F50484F4E45010049000000010005574944544802000200140010435553544F
      4D45525F41444452455353010049000000010005574944544802000200640000
      00}
    Active = True
    Aggregates = <>
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
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 296
    Top = 208
  end
  object dsPlumbers: TDataSource
    DataSet = dsetPlumbers
    Left = 48
    Top = 264
  end
  object dsOrders: TDataSource
    DataSet = dsetOrders
    Left = 168
    Top = 264
  end
  object dsOrdersInfo: TDataSource
    DataSet = dsetOrdersInfo
    Left = 296
    Top = 264
  end
  object RESTResponseGet: TRESTResponse
    Left = 168
    Top = 88
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
    Left = 48
    Top = 152
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
        Name = 'ORDER_PLUMBER_ID'
        DataType = ftInteger
      end
      item
        Name = 'ORDER_STATUS'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ORDER_OPERATOR_ID'
        DataType = ftInteger
      end
      item
        Name = 'CREATION_DATE'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'BEGIN_DATE'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'READ_DATE'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'END_DATE'
        DataType = ftString
        Size = 18
      end>
    Response = RESTResponseGet
    RootElement = 'orders.data'
    Left = 168
    Top = 152
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
    Left = 296
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
  object BackendEndpoint3: TBackendEndpoint
    Provider = EMSProvider1
    Method = rmPOST
    Params = <>
    Resource = 'Plumbers'
    Response = RESTResponseAddPlumber
    Left = 756
    Top = 16
  end
  object RESTResponseAddPlumber: TRESTResponse
    ContentType = 'application/json'
    Left = 760
    Top = 80
  end
end