object machineDeleteForm: TmachineDeleteForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  BorderWidth = 15
  Caption = 'Delete machine'
  ClientHeight = 67
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 427
    Height = 23
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Alignment = taCenter
    Caption = 'Do you really want to delete Stol 1?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 297
  end
  object Button1: TButton
    Left = 120
    Top = 36
    Width = 75
    Height = 25
    Caption = 'No'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Yes'
    TabOrder = 1
    OnClick = Button2Click
  end
end
