object fmMainWindow: TfmMainWindow
  Left = 0
  Top = 0
  Caption = 'fmMainWindow'
  ClientHeight = 614
  ClientWidth = 937
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnAddOrder: TButton
      Left = 32
      Top = 8
      Width = 121
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
      TabOrder = 0
      OnClick = btnAddOrderClick
    end
    object btnExit: TButton
      Left = 832
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 1
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 39
    Width = 705
    Height = 306
    DataSource = DataModule1.dsOrders
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid1: TDBGrid
    Left = 704
    Top = 39
    Width = 233
    Height = 578
    DataSource = DataModule1.dsPlumbers
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid3: TDBGrid
    Left = 0
    Top = 344
    Width = 705
    Height = 273
    DataSource = DataModule1.dsOrdersInfo
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
