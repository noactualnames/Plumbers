object PlumbersResource1: TPlumbersResource1
  OldCreateOrder = False
  Height = 467
  Width = 775
  object FDPlumDBConnection: TFDConnection
    Params.Strings = (
      'Database=B:\Code\Projects\Plumbers potugi\PLUMBERAGENCY.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=win1251'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDSelectOperators: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from OPERATOR;')
    Left = 48
    Top = 88
  end
  object FDSelectOrders: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from ORDERS;')
    Left = 136
    Top = 88
  end
  object FDSelectOrdersInfo: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from ORDER_INFO;')
    Left = 224
    Top = 88
  end
  object FDSelectPlumbers: TFDQuery
    Connection = FDPlumDBConnection
    SQL.Strings = (
      'select * from PLUMBER;')
    Left = 328
    Top = 88
  end
  object FDCheckOperatorAuth: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'OPERATOR_CHECK_AUTH'
    Left = 512
    Top = 88
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
    Left = 512
    Top = 144
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
    Left = 512
    Top = 208
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
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Position = 3
        Name = 'IN_BEGIN_DATE'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Position = 4
        Name = 'IN_READ_DATE'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Position = 5
        Name = 'IN_END_DATE'
        DataType = ftDate
        ParamType = ptInput
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
        Name = 'OUT_ORDER_ID'
        DataType = ftInteger
        ParamType = ptOutput
      end>
  end
  object FDAddOrderInfo: TFDStoredProc
    Connection = FDPlumDBConnection
    StoredProcName = 'ORDER_INFO_ADD'
    Left = 512
    Top = 264
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
    Left = 512
    Top = 320
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
    Left = 640
    Top = 88
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
    Left = 640
    Top = 144
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
    Left = 640
    Top = 208
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
        Name = 'IN_STATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 15
      end>
  end
end
