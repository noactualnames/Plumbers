object cancelPlumbers: TcancelPlumbers
  Left = 0
  Top = 0
  ClientHeight = 109
  ClientWidth = 313
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
  object LabelCancelPlumber: TLabel
    Left = 34
    Top = 16
    Width = 254
    Height = 24
    Caption = #1057#1085#1103#1090#1100' '#1089#1072#1085#1090#1077#1093#1085#1080#1082#1072' '#1089' '#1079#1072#1082#1072#1079#1072'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object YesBtnOk: TButton
    Left = 168
    Top = 64
    Width = 120
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    ModalResult = 1
    TabOrder = 0
    OnClick = YesBtnOkClick
  end
  object CancelBtn: TButton
    Left = 26
    Top = 64
    Width = 119
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = CancelBtnClick
  end
end
