object machineManager: TmachineManager
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Machine Manager'
  ClientHeight = 378
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 635
    Height = 40
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    AutoSize = True
    ButtonHeight = 40
    ButtonWidth = 40
    Caption = 'ToolBar1'
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 0
      Top = 0
      Width = 41
      Height = 40
      Caption = '+'
      OnClick = SpeedButton1Click
    end
    object machineDeleteBtn: TSpeedButton
      Left = 41
      Top = 0
      Width = 40
      Height = 40
      Caption = '-'
      OnClick = machineDeleteBtnClick
    end
  end
  object machinesgrid: TStringGrid
    Left = 0
    Top = 40
    Width = 635
    Height = 338
    Align = alClient
    DefaultColWidth = 120
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 1
  end
end
