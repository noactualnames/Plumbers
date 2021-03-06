object PlumbersResource1: TPlumbersResource1
  OldCreateOrder = False
  Height = 467
  Width = 544
  object FDPlumDBConnection: TFDConnection
    Params.Strings = (
      'Database=B:\Code\Projects\Plumbers server\PLUMBERAGENCY.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=win1251'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDSelectOrders: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from ORDERS where order_status <> '#39'accepted'#39';')
    Left = 48
    Top = 88
  end
  object FDSelectOrdersInfo: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      
        'select oi.order_info_id, oi.order_type, oi.order_description, oi' +
        '.order_price, oi.customer_phone, oi.customer_address'
      
        ' from ORDER_INFO oi inner join ORDERS o on o.order_id = oi.order' +
        '_info_id where o.order_status <> '#39'accepted'#39';  ')
    Left = 136
    Top = 88
  end
  object FDSelectPlumbers: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      
        'select plumber_id, plumber_status, plumber_name from PLUMBER whe' +
        're plumber_status <> '#39'offline'#39';')
    Left = 240
    Top = 88
  end
  object FDCheckOperatorAuth: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'OPERATOR_CHECK_AUTH'
    Left = 48
    Top = 160
    ParamData = <
      item
        Position = 1
        Name = 'IN_PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 2
        Name = 'IN_LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end
      item
        Position = 3
        Name = 'OUT_OP_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end
      item
        Position = 4
        Name = 'OUT_EQUALITY'
        DataType = ftBoolean
        ParamType = ptOutput
      end>
  end
  object FDRegOP: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'OPERATOR_ADD'
    Left = 48
    Top = 216
    ParamData = <
      item
        Position = 1
        Name = 'IN_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 3
        Name = 'IN_LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end
      item
        Position = 4
        Name = 'IN_PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 5
        Name = 'OUT_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end>
  end
  object FDAddOrder: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'ORDERS_ADD'
    Left = 48
    Top = 280
    ParamData = <
      item
        Position = 1
        Name = 'IN_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_CREATION_DATE'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end
      item
        Position = 3
        Name = 'IN_BEGIN_DATE'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end
      item
        Position = 4
        Name = 'IN_READ_DATE'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end
      item
        Position = 5
        Name = 'IN_END_DATE'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end
      item
        Position = 6
        Name = 'IN_STATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 15
      end
      item
        Position = 7
        Name = 'IN_PLUMBER_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 8
        Name = 'IN_OPERATOR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 9
        Name = 'IN_MODE'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 10
        Name = 'OUT_ORDER_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end>
  end
  object FDAddOrderInfo: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'ORDER_INFO_ADD'
    Left = 48
    Top = 336
    ParamData = <
      item
        Position = 1
        Name = 'IN_ORDER_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_TYPE'
        DataType = ftString
        ParamType = ptInput
        Size = 15
      end
      item
        Position = 3
        Name = 'IN_DESCRIPTION'
        DataType = ftString
        ParamType = ptInput
        Size = 500
      end
      item
        Position = 4
        Name = 'IN_PRICE'
        DataType = ftFMTBcd
        Precision = 15
        NumericScale = 2
        ParamType = ptInput
      end
      item
        Position = 5
        Name = 'IN_PHONE'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Position = 6
        Name = 'IN_ADRESS'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 7
        Name = 'OUT_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end>
  end
  object FDChangeOpEditStatus: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'CHANGE_OPERATOR_EDIT_STATUS'
    Left = 48
    Top = 392
    ParamData = <
      item
        Position = 1
        Name = 'IN_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_STATUS'
        DataType = ftBoolean
        ParamType = ptInput
      end>
  end
  object FDCheckPlumberAuth: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'PLUMBER_CHECK_AUTH'
    Left = 176
    Top = 160
    ParamData = <
      item
        Position = 1
        Name = 'IN_ONLY_LOGIN'
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Position = 3
        Name = 'IN_PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 4
        Name = 'OUT_PLUM_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end
      item
        Position = 5
        Name = 'OUT_EQUALITY'
        DataType = ftBoolean
        ParamType = ptOutput
      end>
  end
  object FDRegPlumber: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'PLUMBER_ADD'
    Left = 176
    Top = 216
    ParamData = <
      item
        Position = 1
        Name = 'IN_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_STATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end
      item
        Position = 3
        Name = 'IN_NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 4
        Name = 'IN_LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Position = 5
        Name = 'IN_PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 6
        Name = 'OUT_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end>
  end
  object FDUpdatePlumAndOrderStatus: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'UPDATE_PLUMBER_AND_ORDER_STATUS'
    Left = 176
    Top = 280
    ParamData = <
      item
        Position = 1
        Name = 'IN_PLUMBER_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'IN_ORDER_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 3
        Name = 'IN_ORDER_STATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 15
      end
      item
        Position = 4
        Name = 'IN_PLUMBER_STATUS'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Position = 5
        Name = 'OUT_UPDATED'
        DataType = ftBoolean
        ParamType = ptOutput
      end>
  end
  object FDGetAssignedOrder: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'IS_SOME_ORDER_ASSIGNED'
    Left = 176
    Top = 336
    ParamData = <
      item
        Position = 1
        Name = 'IN_PLUMBER_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'OUT_ASSIGNED'
        DataType = ftBoolean
        ParamType = ptOutput
      end
      item
        Position = 3
        Name = 'OUT_ORDER_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end
      item
        Position = 4
        Name = 'OUT_ORDER_STATUS'
        DataType = ftString
        ParamType = ptOutput
        Size = 15
      end>
  end
  object FDSelectOneOrder: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from ORDERS where order_id = :in_id;')
    Left = 344
    Top = 88
    ParamData = <
      item
        Name = 'IN_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDSelectOneOrderInfo: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from ORDER_INFO where order_info_id = :in_id;')
    Left = 448
    Top = 88
    ParamData = <
      item
        Name = 'IN_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 488
    Top = 400
  end
  object IdThreadComponent1: TIdThreadComponent
    Active = False
    Loop = False
    Priority = tpNormal
    StopMode = smTerminate
    OnRun = IdThreadComponent1Run
    Left = 392
    Top = 400
  end
end
