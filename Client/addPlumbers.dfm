object addPlumber: TaddPlumber
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1072#1085#1090#1077#1093#1085#1080#1082#1072
  ClientHeight = 266
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 619
    Height = 201
    DataSource = DataModule1.dsPlumbers
    DragMode = dmAutomatic
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
  object add: TButton
    Left = 346
    Top = 233
    Width = 217
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = addClick
  end
  object cancel: TButton
    Left = 66
    Top = 233
    Width = 217
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
  end
end