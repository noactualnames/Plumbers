object completeOrderForm: TcompleteOrderForm
  Left = 0
  Top = 0
  Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 116
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfoAdd: TLabel
    Left = 56
    Top = 26
    Width = 183
    Height = 24
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1079#1072#1082#1072#1079'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object completeOrderConfirmButton: TButton
    Left = 128
    Top = 72
    Width = 148
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1079#1072#1082#1072#1079
    TabOrder = 0
    OnClick = completeOrderConfirmButtonClick
  end
  object completeOrderCancelBtn: TButton
    Left = 32
    Top = 72
    Width = 73
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = completeOrderCancelBtnClick
  end
end
