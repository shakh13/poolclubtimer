object machineAddForm: TmachineAddForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsToolWindow
  BorderWidth = 10
  Caption = 'Add Machine'
  ClientHeight = 68
  ClientWidth = 161
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
  object Edit1: TEdit
    Left = 0
    Top = 16
    Width = 161
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 86
    Top = 43
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = Button1Click
  end
end
