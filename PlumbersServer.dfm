object PlumbersResource1: TPlumbersResource1
  OldCreateOrder = False
  Height = 351
  Width = 575
  object FDPlumDBConnection: TFDConnection
    Params.Strings = (
      'Database=B:\Code\Projects\Plumbers potugi\PLUMBERAGENCY.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=win1251'
      'DriverID=FB')
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
  object FDCheckAuth: TFDStoredProc
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
end
