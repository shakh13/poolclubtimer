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
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, System.DateUtils, INIFiles;

type
  Tmainform = class(TForm)
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    popup: TPopupMenu;
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
    query: TFDQuery;
    FDManager1: TFDManager;
    Options1: TMenuItem;
    Settings1: TMenuItem;
    Stop1: TMenuItem;
    ActivateVIP1: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tableslistDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure showtimerTimer(Sender: TObject);
    procedure timerTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure tableslistClick(Sender: TObject);
    procedure tablesClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure popupPopup(Sender: TObject);
    procedure ActivateVIP1Click(Sender: TObject);
  private
    { Private declarations }
    procedure TablesProcess(Row: Integer; Percent: Real;
      isVip: Boolean = false);
    function FindRowById(id: String): Integer;
    function SecondToHours(s: Extended): String;
    function ZeroToDoubleZero(z: Integer): String;
    procedure activateTimeItemClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Percent: Double;
  price: Integer;
  poolicon: TIcon;
  mainform: Tmainform;

  finishedTimerList: TStringList;

implementation

{$R *.dfm}

uses mManager, Models, SettingsF, cashF;

procedure DrawTheText(const hDC: hDC; const Font: TFont; var Text: string;
  aRect: TRect);
var
  lRect: TRect;
begin
  with TBitmap.Create do
    try

      Width := aRect.Right - aRect.Left;
      Height := aRect.Bottom - aRect.Top;
      lRect := Rect(0, 0, Width, Height);
      Canvas.Font.Assign(Font);
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(lRect);
      Canvas.Font.Color := clWhite;
      Canvas.TextRect(lRect, 5, 5, Text);
      BitBlt(hDC, aRect.Left, aRect.Top, Width, Height, Canvas.Handle, 0, 0,
        SRCINVERT);
    finally
      Free;
    end;
end;

procedure Tmainform.FormResize(Sender: TObject);
var
  w: Integer;
  i: Integer;
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
  i: Integer;
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
      for i := 1 to fdquery.RecordCount do
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

procedure Tmainform.popupPopup(Sender: TObject);
var
  id: String;
begin
  if (tables.Row > 0) and (Length(tables.Cells[0, tables.Row]) > 0) then
  begin
    id := tables.Cells[0, tables.Row];
    query.Close;
    query.Open('SELECT * FROM timer WHERE machine_id=' + id + ' AND status=1');
    if query.RecordCount > 0 then
    begin
      // Enable stop button
      // Disable activate vip button
      popup.Items.Find('Stop').Enabled := true;
      popup.Items.Find('Activate VIP').Enabled := false;
      popup.Items.Find('Activate Time').Enabled := false;
    end
    else
    begin
      // Disable stop button
      // Enable activate vip button
      popup.Items.Find('Stop').Enabled := false;
      popup.Items.Find('Activate VIP').Enabled := true;
      popup.Items.Find('Activate Time').Enabled := true;
    end;
  end;
end;

function Tmainform.SecondToHours(s: Extended): String;
var
  h, m, sec, mm, hh, i: Integer;
begin
  i := round(s);
  sec := i mod 60;
  mm := i div 60;
  m := mm mod 60;
  hh := mm div 60;
  h := hh mod 60;

  result := ZeroToDoubleZero(h) + ':' + ZeroToDoubleZero(m) + ':' +
    ZeroToDoubleZero(sec);
end;

procedure Tmainform.Settings1Click(Sender: TObject);
begin
  SettingsForm.ShowModal;
end;

procedure Tmainform.SpeedButton1Click(Sender: TObject);
begin
  machineManager.ShowModal;
end;

procedure Tmainform.SpeedButton2Click(Sender: TObject);
begin
  cashForm.ShowModal;
end;

procedure Tmainform.activateTimeItemClick(Sender: TObject);
  function clearChars(s: String): String;
  var
    a: String;
    i: Integer;
  begin
    a := '';
    for i := 1 to Length(s) do
      if (ord(s[i]) >= 48) and (ord(s[i]) <= 57) then
        a := a + s[i];
    result := a;
  end;

var
  menu: TMenuItem;
  cap: String;
  sum: Integer;
  seconds: Integer;
begin
  menu := Sender as TMenuItem;
  cap := clearChars(menu.Caption);
  sum := StrToInt(cap);

  seconds := round(sum * 3600 / price);

  ShowMessage(cap + ' ' + tables.Cells[0, tables.Row]);

  fdquery.Close;
  fdquery.SQL.Text := 'INSERT INTO timer (machine_id, finishes, status, created_at) VALUES ('
    + tables.Cells[0, tables.Row]
    + ', ' + IntToStr(DateTimeToUnix(now) + seconds) + ', 1, '
    + IntToStr(DateTimeToUnix(now)) + ')';
  fdquery.ExecSQL;
  // add time to machine -------------------------------------------------------

end;

procedure Tmainform.ActivateVIP1Click(Sender: TObject);
begin
  fdquery.Close;
  fdquery.SQL.Text := 'INSERT INTO timer (machine_id, is_vip, status, created_at) VALUES ('
    + tables.Cells[0, tables.ROW]+', 1, 1, ' + IntToStr(DateTimeToUnix(now)) + ')';
  fdquery.ExecSQL;
end;

function Tmainform.FindRowById(id: String): Integer;
var
  i: Integer;
begin
  for i := 1 to tables.RowCount-1 do
  begin
    if id = tables.Cells[0, i] then
    begin
      result := i;
      exit;
    end;
  end;
  result := 0;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  ini: TIniFile;
  i: Integer;
  newTimeItem: TMenuItem;
  activateTimeItem: TMenuItem;
begin
  randomize;

  finishedTimerList := TStringList.Create;

  timelabel.Caption := TimeToStr(Time);
  poolicon := TIcon.Create;
  poolicon.LoadFromFile('poolico.ico');

  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'price.ini');
  price := ini.ReadInteger('pr', 'pri', 10000);

  tables.Cells[0, 0] := '#';
  tables.Cells[1, 0] := 'Name';
  tables.Cells[2, 0] := 'Begin';
  tables.Cells[3, 0] := 'Process';
  tables.Cells[4, 0] := 'Left';
  tables.Cells[5, 0] := 'End';
  tables.Cells[6, 0] := 'Price';

  activateTimeItem := TMenuItem.Create(popup);
  activateTimeItem.Caption := 'Activate Time';
  popup.Items.Insert(1, activateTimeItem);
  query.Close;
  query.Open('SELECT * FROM `time` WHERE sum != 0');
  if query.RecordCount > 0 then
  begin
    query.First;
    activateTimeItem.Clear;
    for i := 1 to query.RecordCount do
    begin
      newTimeItem := TMenuItem.Create(popup);
      newTimeItem.Caption := query.FieldByName('sum').AsString;
      newTimeItem.OnClick := activateTimeItemClick; // register listener
      activateTimeItem.Add(newTimeItem);
      query.Next;
    end;
  end;
end;

procedure Tmainform.tablesClick(Sender: TObject);
begin
  tableslist.ItemIndex := tables.Row - 1;
end;

procedure Tmainform.tableslistClick(Sender: TObject);
begin
  tables.Row := tableslist.ItemIndex + 1;
end;

procedure Tmainform.tableslistDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  try
    if odSelected in State then
      tableslist.Canvas.Brush.Color := clRed
    else
      tableslist.Canvas.Brush.Color := clWhite;
    tableslist.Canvas.FillRect(Rect);
    tableslist.Canvas.Draw(2, Rect.Top + 2, poolicon);
    tableslist.Canvas.TextOut(36, Rect.Top + ((tableslist.ItemHeight div 2) -
      (Canvas.TextHeight('A')) div 2), tableslist.Items[Index]);
  finally

  end;
end;

procedure Tmainform.showtimerTimer(Sender: TObject);
begin
  timelabel.Caption := TimeToStr(Time);
end;

procedure Tmainform.timerTimer(Sender: TObject);
var
  i: Integer;
  timeleft: Integer;
  f, d, a, b, c: Double;
  p: Integer;
begin
  // TablesProcess(1, random(100) / 100, false); -- not VIP
  // TablesProcess(2, 0, true);                  -- VIP

  // check finished machines

  try
    query.Close;
    query.Open('SELECT * FROM timer WHERE is_vip=0 AND status=1 AND finishes<=strftime(''%s'',''now'', ''localtime'')');
      //IntToStr(DateTimeToUnix(now)));

    if query.RecordCount > 0 then
    begin
      query.First;
      for i := 1 to query.RecordCount do
      begin
        // cash plus -------------------------------------------------------------

        // check if exists timer.id in finishedTimerList

        if finishedTimerList.IndexOf(query.FieldByName('id').AsString) = -1 then
        begin
          finishedTimerList.Add(query.FieldByName('id').AsString);

          timeleft := query.FieldByName('finishes').AsInteger - query.FieldByName('created_at').AsInteger;

          Application.MessageBox
            (pchar(tables.Cells[1, FindRowById(query.FieldByName('machine_id').AsString)]
            + ' has been finished.' + #13#10 + 'Sum: ' +
            IntToStr(round((timeleft / 3600) * price))), 'Timer', MB_OK);
        end;

        // end check

        fdquery.Close;
        fdquery.SQL.Text := 'UPDATE timer SET status=0 WHERE id=' +
          query.FieldByName('id').AsString;
        fdquery.ExecSQL;
        fdquery.Close;

        query.Next;
      end;
    end;
  except
    on e: Exception do
  end;



  // end check

  for i := 1 to tables.RowCount - 1 do
  begin
    query.Close;
    query.SQL.Text := 'SELECT * FROM timer WHERE status = 1 AND machine_id = ' +
      tables.Cells[0, i];
    query.Open;
    if query.RecordCount > 0 then
    begin
      if query.FieldByName('is_vip').AsInteger = 1 then
      begin
        timeleft := DateTimeToUnix(now) - query.FieldByName('created_at')
          .AsInteger;

        tables.Cells[2, i] :=
          datetimetostr(UnixToDateTime(query.FieldByName('created_at')
          .AsInteger));
        TablesProcess(i, 0, true);

        tables.Cells[4, i] := SecondToHours(timeleft);

        tables.Cells[5, i] := '---';
        tables.Cells[6, i] := IntToStr(round((timeleft / 3600) * price));

        // caption := inttostr(DateTimeToUnix(now));
      end
      else
      begin
        // not VIP
        f := query.FieldByName('finishes').AsFloat -
          query.FieldByName('created_at').AsFloat;
        d := DateTimeToUnix(now) - query.FieldByName('created_at').AsInteger;

        p := round((d * 100) / f);

        Caption := floattostr(f) + ' ' + floattostr(d) + ' ' + floattostr(p);

        timeleft := round(d);

        tables.Cells[2, i] :=
          datetimetostr(UnixToDateTime(query.FieldByName('created_at')
          .AsInteger));
        TablesProcess(i, p / 100);

        tables.Cells[4, i] := SecondToHours(timeleft);

        tables.Cells[5, i] := SecondToHours(f);
        tables.Cells[6, i] := IntToStr(round((timeleft / 3600) * price));

      end;
    end
    else
    begin
      tables.Cells[2, i] := '---';
      tables.Cells[3, i] := '---';
      tables.Cells[4, i] := '---';
      tables.Cells[5, i] := '---';
      tables.Cells[6, i] := '---';
    end;
  end;
end;

function Tmainform.ZeroToDoubleZero(z: Integer): String;
begin
  z := abs(z);
  if z >= 10 then
    if z = 60 then
      result := '00'
    else
      result := IntToStr(z)
  else
    result := '0' + IntToStr(z)
end;

procedure Tmainform.TablesProcess(Row: Integer; Percent: Real; isVip: Boolean);
var
  lRect: TRect;
  Rect: TRect;
  s: String;
  c: TCanvas;
begin
  Rect := tables.CellRect(3, Row);
  c := tables.Canvas;
  c.Brush.Color := clWhite;
  c.FillRect(Rect);

  if isVip then
  begin
    // s:='VIP';
    // DrawTheText(c.Handle, tables.Font, s, rect);
    tables.Cells[3, Row] := 'VIP';
  end
  else
  begin
    lRect := Rect;
    lRect.Right := round(lRect.Left + (lRect.Right - lRect.Left) * Percent);
    inflaterect(lRect, -1, -1);
    c.Brush.Color := clNavy;
    c.Brush.Style := bsSolid;
    c.Pen.Color := clBlack;
    c.FillRect(lRect);
    s := FormatFloat('0.00 %', Percent * 100);
    DrawTheText(c.Handle, tables.Font, s, Rect);
  end;
end;

end.
