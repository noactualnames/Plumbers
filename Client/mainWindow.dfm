object fmMainWindow: TfmMainWindow
  Left = 274
  Top = 163
  Caption = 'fmMainWindow'
  ClientHeight = 618
  ClientWidth = 1059
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1059
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 937
    object btnAddOrder: TButton
      Left = 24
      Top = 8
      Width = 129
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
      TabOrder = 0
      OnClick = btnAddOrderClick
    end
    object btnExit: TButton
      Left = 936
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 1
      OnClick = btnExitClick
    end
    object addPlumberBtn: TButton
      Left = 168
      Top = 8
      Width = 129
      Height = 25
      Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1089#1072#1085#1090#1077#1093#1085#1080#1082#1072
      TabOrder = 2
      OnClick = addPlumberBtnClick
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 39
    Width = 793
    Height = 306
    DataSource = DataModule1.dsOrders
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid2CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ORDER_ID'
        Title.Alignment = taCenter
        Title.Caption = #1047#1072#1082#1072#1079
        Title.Color = clWhite
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_PLUMBER_ID'
        Title.Alignment = taCenter
        Title.Caption = #1057#1072#1085#1090#1077#1093#1085#1080#1082
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_OPERATOR_ID'
        Title.Alignment = taCenter
        Title.Caption = #1054#1087#1077#1088#1072#1090#1086#1088
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_STATUS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Title.Color = clMoneyGreen
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CREATION_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1057#1086#1079#1076#1072#1085#1080#1077
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BEGIN_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1095#1072#1083#1086
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'READ_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1095#1080#1090#1072#1085#1086
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'END_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077
        Visible = True
      end>
  end
  object DBGrid1: TDBGrid
    Left = 799
    Top = 39
    Width = 303
    Height = 578
    DataSource = DataModule1.dsPlumbers
    DragMode = dmAutomatic
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PLUMBER_ID'
        Title.Caption = #1057#1072#1085#1090#1077#1093#1085#1080#1082
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLUMBER_STATUS'
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLUMBER_NAME'
        Title.Caption = #1048#1084#1103
        Width = 100
        Visible = True
      end>
  end
  object DBGrid3: TDBGrid
    Left = 0
    Top = 344
    Width = 793
    Height = 273
    DataSource = DataModule1.dsOrdersInfo
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ORDER_INFO_ID'
        Title.Alignment = taCenter
        Title.Caption = #1047#1072#1082#1072#1079
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_TYPE'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_PRICE'
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CUSTOMER_PHONE'
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CUSTOMER_ADDRESS'
        Title.Caption = #1040#1076#1088#1077#1089
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_DESCRIPTION'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
        Width = 600
        Visible = True
      end>
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 20000
    OnTimer = Timer1Timer
    Left = 8
    Top = 104
  end
end
