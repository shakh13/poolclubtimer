unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, Grids, XPMan, CPort, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons;

type
  Tmainform = class(TForm)
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    PopupMenu1: TPopupMenu;
    tables: TStringGrid;
    XPManifest1: TXPManifest;
    Panel2: TPanel;
    tableslist: TListBox;
    timelabel: TLabel;
    showtimer: TTimer;
    timer: TTimer;
    comport: TComPort;
    fdconnection: TFDConnection;
    fdquery: TFDQuery;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tableslistDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure showtimerTimer(Sender: TObject);
    procedure timerTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure TablesProcess(Row: Integer; Percent: Real; isVip: Boolean = false);

  public
    { Public declarations }
  end;

var
  percent:Double;
  poolicon : TIcon;
  mainform: Tmainform;

implementation

{$R *.dfm}

uses mManager, Models;

procedure DrawTheText(const hDC: HDC; const Font: TFont; var Text: string; aRect:TRect);
var
 lRect:Trect;
begin
  with TBitmap.Create do
    try

      Width := aRect.Right - aRect.Left;
      Height := aRect.Bottom - aRect.Top;
      LRect :=Rect(0,0,width,height);
      Canvas.Font.Assign(Font);
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Lrect);
      Canvas.Font.Color := clWhite;
      Canvas.TextRect(Lrect,5, 5, Text);
      BitBlt(hDC, aRect.Left, aRect.Top, Width, Height, Canvas.Handle, 0, 0, SRCINVERT);
    finally
      Free;
    end;
end;

procedure Tmainform.FormResize(Sender: TObject);
var
  w: integer;
  i: integer;
begin
  i := 50;
  w := tables.Width - i;
  tables.ColWidths[0] := i;
  tables.ColWidths[1] := round(w * 0.13);
  tables.ColWidths[2] := round(w * 0.13);
  tables.ColWidths[3] := round(w * 0.33);
  tables.ColWidths[4] := round(w * 0.13);
  tables.ColWidths[5] := round(w * 0.13);
  tables.ColWidths[6] := round(w * 0.13);
end;

procedure Tmainform.FormShow(Sender: TObject);
var
  I: Integer;
begin
  tableslist.Clear;
  if fdconnection.Connected then
    begin
       fdquery.Close;
       fdquery.Open('SELECT * FROM machines WHERE status=1 ORDER BY id');
       tables.RowCount := fdquery.RecordCount + 1;
       if fdquery.RecordCount > 0 then
        begin
          fdquery.First;
          for I := 1 to fdquery.RecordCount do
            begin
              tables.Cells[0, i] := fdquery.FieldByName('id').AsString;
              tables.Cells[1, i] := fdquery.FieldByName('machine_name').AsString;

              tableslist.Items.Add(fdquery.FieldByName('machine_name').AsString);
              fdquery.Next;
            end;

        end
       else
        begin
          // No machines
        end;
    end
  else
    begin
      ShowMessage('Cannot connect to DB. Please restart the application.');
      Close;
    end;

end;

procedure Tmainform.SpeedButton1Click(Sender: TObject);
begin
  machineManager.showmodal;
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  randomize;
  timelabel.Caption := TimeToStr(Time);
  poolicon := TIcon.Create;
  poolicon.LoadFromFile('poolico.ico');

  tables.Cells[0,0] := '#';
  tables.Cells[1,0] := 'Name';
  tables.Cells[2,0] := 'Begin';
  tables.Cells[3,0] := 'Process';
  tables.Cells[4,0] := 'Left';
  tables.Cells[5,0] := 'End';
  tables.Cells[6,0] := 'Price';
end;

procedure Tmainform.tableslistDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  try
    if odSelected in State then tableslist.Canvas.Brush.Color:=clRed else tableslist.Canvas.Brush.Color:=clWhite;
    tableslist.Canvas.FillRect(Rect);
    tableslist.Canvas.Draw(2,Rect.Top+2, poolicon);
    tableslist.Canvas.TextOut(36, Rect.Top+((tableslist.ItemHeight div 2)-(Canvas.TextHeight('A')) div 2), tableslist.Items[Index]);
  finally

  end;
end;

procedure Tmainform.showtimerTimer(Sender: TObject);
begin
  timelabel.Caption := TimeToStr(Time);
end;

procedure Tmainform.timerTimer(Sender: TObject);
begin
      TablesProcess(1, random(100) / 100, false);
      TablesProcess(2, 0, true);
end;

procedure Tmainform.TablesProcess(Row: Integer; Percent: Real;
  isVip: Boolean);
var
  LRect:Trect;
  rect: TRect;
  s:String;
  c:TCanvas;
begin
  rect := tables.CellRect(3, Row);
  c := tables.Canvas;
  c.Brush.Color := clWhite;
  c.FillRect(rect);

  if isVip then
    begin
      s:='VIP';
      DrawTheText(c.Handle, tables.Font, s, rect);
    end
  else
    begin
      LRect := rect;
      LRect.Right := Round(LRect.Left + (LRect.Right - LRect.Left)*percent);
      inflaterect(LRect,-1,-1);
      c.Brush.Color := clNavy;
      c.Brush.Style := bsSolid;
      c.Pen.Color := clBlack;
      c.FillRect(LRect);
      s := FormatFloat('0.00 %' , percent * 100);
      DrawTheText(c.Handle,tables.font,s,rect);
    end;

end;

end.
