object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  Caption = 'Settings'
  ClientHeight = 422
  ClientWidth = 482
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
  object usersPage: TPageControl
    Left = 8
    Top = 8
    Width = 465
    Height = 406
    ActivePage = pricePage
    TabOrder = 0
    object pricePage: TTabSheet
      Caption = 'Price'
      OnShow = pricePageShow
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Price'
      end
      object Label2: TLabel
        Left = 3
        Top = 79
        Width = 39
        Height = 13
        Caption = 'Price list'
      end
      object timepricedelbtn: TSpeedButton
        Left = 431
        Top = 76
        Width = 23
        Height = 22
        Caption = '-'
        Enabled = False
        OnClick = timepricedelbtnClick
      end
      object SpeedButton2: TSpeedButton
        Left = 402
        Top = 76
        Width = 23
        Height = 22
        Caption = '+'
        OnClick = SpeedButton2Click
      end
      object Label3: TLabel
        Left = 375
        Top = 79
        Width = 21
        Height = 13
        Caption = 'so'#39'm'
      end
      object priceEdit: TSpinEdit
        Left = 45
        Top = 13
        Width = 121
        Height = 22
        Increment = 1000
        MaxValue = 1000000
        MinValue = 1000
        TabOrder = 0
        Value = 1000
      end
      object Button1: TButton
        Left = 172
        Top = 11
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 1
        OnClick = Button1Click
      end
      object timepricelist: TListBox
        Left = 0
        Top = 104
        Width = 457
        Height = 274
        Align = alBottom
        ItemHeight = 13
        TabOrder = 2
        OnClick = timepricelistClick
      end
      object timeAddSpin: TSpinEdit
        Left = 248
        Top = 76
        Width = 121
        Height = 22
        Increment = 1000
        MaxValue = 100000
        MinValue = 1000
        TabOrder = 3
        Value = 1000
      end
    end
  end
end
