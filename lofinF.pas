unit lofinF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.DateUtils;

type
  TloginForm = class(TForm)
    usernameEdit: TLabeledEdit;
    passwordEdit: TLabeledEdit;
    Button1: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure passwordEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  loginForm: TloginForm;

implementation

{$R *.dfm}

uses Models, Unit1;

procedure TloginForm.Button1Click(Sender: TObject);
var
  role: Integer;
begin
  mainform.user := TUser.Create(usernameEdit.Text, passwordEdit.Text);
  if mainform.user.Exists then
    begin
      role := mainform.user.role;
      if role = 0 then
        begin
          mainform.machinesManagerButton.Visible := false;
          mainform.cashButton.Visible := false;
          mainform.usersManagerButton.Visible := false;
          mainform.mainMenuOptionsButton.Enabled := false;
        end
      else
        if role = 1 then
          begin
            mainform.machinesManagerButton.Visible := true;
            mainform.cashButton.Visible := true;
            mainform.usersManagerButton.Visible := true;
            mainform.mainMenuOptionsButton.Enabled := true;
          end;
      mainform.timer.Enabled := true;
      mainform.Show;

      mainform.fdquery.Close;
      mainform.fdquery.SQL.Text := 'UPDATE users SET last_update=' + IntToStr(DateTimeToUnix(now));
      mainform.fdquery.ExecSQL;

      close;
    end
  else
    ShowMessage('User not found');
end;

procedure TloginForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not mainform.user.Exists then mainform.Close;
end;

procedure TloginForm.FormShow(Sender: TObject);
begin
  usernameEdit.Clear;
  passwordEdit.Clear;

  ActiveControl := usernameEdit;
end;

procedure TloginForm.passwordEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Button1.Click;
end;

end.
