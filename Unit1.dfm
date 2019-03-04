object mainform: Tmainform
  Left = 195
  Top = 138
  Caption = 'Pool Control'
  ClientHeight = 444
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tables: TStringGrid
    Left = 0
    Top = 51
    Width = 560
    Height = 393
    Align = alClient
    ColCount = 7
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitTop = 57
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64)
  end
  object Panel2: TPanel
    Left = 560
    Top = 51
    Width = 224
    Height = 393
    Align = alRight
    BevelOuter = bvLowered
    BorderWidth = 5
    Caption = 'Panel2'
    TabOrder = 1
    object timelabel: TLabel
      Left = 6
      Top = 6
      Width = 212
      Height = 37
      Align = alTop
      Alignment = taCenter
      Caption = '00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 135
    end
    object tableslist: TListBox
      Left = 6
      Top = 43
      Width = 212
      Height = 344
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
      OnDrawItem = tableslistDrawItem
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 784
    Height = 51
    ButtonHeight = 51
    Caption = 'ToolBar1'
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 0
      Top = 0
      Width = 73
      Height = 51
      Caption = 'Machines'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 73
      Top = 0
      Width = 56
      Height = 51
      Caption = 'Cash'
    end
  end
  object MainMenu1: TMainMenu
    Left = 704
    Top = 9
    object Menu1: TMenuItem
      Caption = 'Menu'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 648
    Top = 8
  end
  object XPManifest1: TXPManifest
    Left = 584
    Top = 8
  end
  object showtimer: TTimer
    OnTimer = showtimerTimer
    Left = 640
    Top = 57
  end
  object timer: TTimer
    Enabled = False
    OnTimer = timerTimer
    Left = 360
    Top = 8
  end
  object comport: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = True
    Left = 528
    Top = 8
  end
  object fdconnection: TFDConnection
    Params.Strings = (
      'Database=db.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 416
  end
  object fdquery: TFDQuery
    Connection = fdconnection
    Left = 488
  end
end
