object usersManagerForm: TusersManagerForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderWidth = 15
  Caption = 'Users manager'
  ClientHeight = 358
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 34
    Top = 3
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label2: TLabel
    Left = 332
    Top = 3
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label3: TLabel
    Left = 61
    Top = 51
    Width = 21
    Height = 13
    Caption = 'Role'
  end
  object grid: TDBGrid
    Left = 0
    Top = 77
    Width = 505
    Height = 281
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = gridCellClick
  end
  object usernameEdit: TDBEdit
    Left = 88
    Top = 0
    Width = 121
    Height = 21
    DataSource = DataSource1
    TabOrder = 1
  end
  object passwordEdit: TDBEdit
    Left = 384
    Top = 0
    Width = 121
    Height = 21
    DataSource = DataSource1
    TabOrder = 2
  end
  object roleEdit: TComboBox
    Left = 88
    Top = 48
    Width = 121
    Height = 21
    ItemIndex = 0
    TabOrder = 3
    Text = 'User'
    Items.Strings = (
      'User'
      'Admin')
  end
  object Button1: TButton
    Left = 215
    Top = 46
    Width = 115
    Height = 25
    Caption = 'Update/Insert'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 336
    Top = 46
    Width = 82
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 424
    Top = 46
    Width = 81
    Height = 25
    Caption = 'Delete'
    TabOrder = 6
    OnClick = Button3Click
  end
  object fdtable: TFDTable
    Left = 144
    Top = 192
  end
  object DataSource1: TDataSource
    DataSet = fdtable
    Left = 256
    Top = 264
  end
  object FDConnection1: TFDConnection
    Left = 336
    Top = 280
  end
end
