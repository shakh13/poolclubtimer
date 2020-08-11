unit cashF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, inifiles, Vcl.Samples.Spin;

type
  TcashForm = class(TForm)
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cashForm: TcashForm;
  cashini: tinifile;
  cash: integer;

implementation

{$R *.dfm}

procedure TcashForm.Button1Click(Sender: TObject);
begin
  if (spinedit1.Value > 0) and (spinedit1.Value <= cash) then
    begin
      cash := cash - spinedit1.Value;
      cashini.WriteInteger('cash', 'c', cash);
      cashForm.OnShow(Sender);
    end;
end;

procedure TcashForm.FormCreate(Sender: TObject);
begin
  cashini := tinifile.Create(extractfilepath(paramstr(0)) + 'settings.ini');
end;

procedure TcashForm.FormShow(Sender: TObject);
begin
  cash := cashini.ReadInteger('cash', 'c', 0);
  spinedit1.MaxValue := cash;
  label1.Caption := 'Cash: ' + inttostr(cash) + ' so''m';
end;

end.
