object machineAddForm: TmachineAddForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsToolWindow
  BorderWidth = 10
  Caption = 'Add Machine'
  ClientHeight = 132
  ClientWidth = 171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 0
    Top = 58
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Edit1: TEdit
    Left = 0
    Top = 19
    Width = 171
    Height = 21
    TabOrder = 0
  end
  object SpinEdit1: TSpinEdit
    Left = 26
    Top = 55
    Width = 145
    Height = 22
    MaxValue = 13
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object Button1: TButton
    Left = 0
    Top = 96
    Width = 171
    Height = 36
    Caption = 'Add'
    TabOrder = 2
    OnClick = Button1Click
  end
end
