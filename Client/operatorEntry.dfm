object TOperatorEntry: TTOperatorEntry
  Left = 0
  Top = 0
  Caption = 'TOperatorEntry'
  ClientHeight = 216
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 112
    Top = 24
    Width = 36
    Height = 21
    Caption = #1042#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 33
    Top = 118
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object Label3: TLabel
    Left = 40
    Top = 75
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object eLogin: TEdit
    Left = 76
    Top = 72
    Width = 121
    Height = 21
    Hint = #1051#1086#1075#1080#1085
    TabOrder = 0
  end
  object ePassword: TEdit
    Left = 76
    Top = 115
    Width = 121
    Height = 21
    Hint = #1055#1072#1088#1086#1083#1100
    PasswordChar = #9679
    TabOrder = 1
  end
  object btnEntry: TButton
    Left = 76
    Top = 160
    Width = 121
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 2
    OnClick = btnEntryClick
  end
end
