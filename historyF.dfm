object historyForm: ThistoryForm
  Left = 0
  Top = 0
  Caption = 'History'
  ClientHeight = 354
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TStringGrid
    Left = 0
    Top = 0
    Width = 600
    Height = 354
    Align = alClient
    RowCount = 2
    TabOrder = 0
    ExplicitWidth = 584
  end
end