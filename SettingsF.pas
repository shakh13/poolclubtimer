unit SettingsF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, INIFiles, Vcl.Buttons, FireDAC.Comp.Client, System.DateUtils;

type
  TSettingsForm = class(TForm)
    usersPage: TPageControl;
    pricePage: TTabSheet;
    priceEdit: TSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    timepricelist: TListBox;
    Label2: TLabel;
    timepricedelbtn: TSpeedButton;
    timeAddSpin: TSpinEdit;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure pricePageShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure timepricelistClick(Sender: TObject);
    procedure timepricedelbtnClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;
  query: TFDQuery;
  ini: TIniFile;

implementation

{$R *.dfm}

uses Unit1;

procedure TSettingsForm.Button1Click(Sender: TObject);
begin
  ini.WriteInteger('pr', 'pri', priceEdit.Value);
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'settings.ini');
  query := mainform.fdquery;
end;

procedure TSettingsForm.pricePageShow(Sender: TObject);
var
  I: Integer;
  s: Integer;
begin
  priceEdit.Value := ini.ReadInteger('pr', 'pri', 1000);
  query.Close;
  query.Open('SELECT * FROM time');
  if query.RecordCount > 0 then
    begin
      timepricelist.Clear;
      query.First;
      for I := 1 to query.RecordCount do
        begin
          s := query.FieldByName('sum').AsInteger;
          if s = 0 then
            timepricelist.Items.Add('VIP')
          else
            timepricelist.Items.Add(IntToStr(s));
          query.Next;

        end;
    end;
end;

procedure TSettingsForm.SpeedButton2Click(Sender: TObject);
begin
  if timeAddSpin.Value >= 1000 then
    begin
      query.Close;
      query.SQL.Text := 'INSERT INTO time (sum, created_at) VALUES ('+timeAddSpin.Value.ToString+', '+IntToStr(DateTimeToUnix(now))+')';
      query.ExecSQL;
      pricePageShow(Sender);
    end;
end;

procedure TSettingsForm.timepricedelbtnClick(Sender: TObject);
var
  s: String;
begin
  if timepricelist.ItemIndex > 0 then
    begin
      s := timepricelist.Items[timepricelist.ItemIndex];

      if not s.Equals('VIP') then
        begin
          query.Close;
          query.SQL.Text := 'DELETE FROM time WHERE sum=' + timepricelist.Items[timepricelist.ItemIndex];
          query.ExecSQL;
          pricePageShow(Sender);
        end;
    end;

    timepricedelbtn.Enabled := false;
end;

procedure TSettingsForm.timepricelistClick(Sender: TObject);
begin
  timepricedelbtn.Enabled := false;
  if (timepricelist.ItemIndex > 0) and (timepricelist.Items.Count > 1) then
      if not timepricelist.Items[timepricelist.ItemIndex].Equals('VIP') then
        timepricedelbtn.Enabled := true;
end;

end.
