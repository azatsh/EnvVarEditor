object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 364
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object VarList: TListBox
    Left = 8
    Top = 8
    Width = 169
    Height = 249
    ItemHeight = 13
    TabOrder = 0
    OnClick = VarListClick
  end
  object btnChange: TButton
    Left = 190
    Top = 297
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = btnChangeClick
  end
  object ValEdit: TEdit
    Left = 190
    Top = 268
    Width = 385
    Height = 23
    TabOrder = 2
  end
  object btnAdd: TButton
    Left = 273
    Top = 297
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = btnAddClick
  end
  object ValList: TListBox
    Left = 190
    Top = 8
    Width = 385
    Height = 249
    ItemHeight = 13
    TabOrder = 4
    OnClick = ValListClick
  end
  object btnDelete: TButton
    Left = 356
    Top = 297
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 5
    OnClick = btnDeleteClick
  end
end
