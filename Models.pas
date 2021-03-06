unit Models;

interface

uses
  FireDAC.Comp.Client, VCL.Dialogs, System.SysUtils, Classes, System.DateUtils;

type
  TUser = class
    id: Integer;
    username: String;
    password: String;
    role: Integer;
    status: Integer;
    last_update: Integer;
    created_at: Integer;
    Exists: Boolean;
  private

  public
    constructor Create(uname, pass: String);


  end;

type
  TMachine = class
    machine_id: Integer;
    machine_name: WideString;
    machine_port: Integer;
    machine_status: Integer;
    machine_created_at: Integer;
  private

  public
    procedure Add(n: String; port: String);
    procedure Delete(i: Integer);
  end;


implementation

{ TUser }

uses Unit1;

constructor TUser.Create(uname, pass: String);
var
  query: TFDQuery;
begin
  Exists := false;
  query:=mainform.fdquery;

  if query.Connection.Connected then
    begin
      query.Close;
      query.Open('SELECT * FROM users WHERE username='''+uname+''' AND password='''+pass+'''');
      if query.RecordCount > 0 then
        begin
          id := query.FieldByName('id').AsInteger;
          username := uname;
          password := pass;
          role := query.FieldByName('role').AsInteger;
          status := query.FieldByName('status').AsInteger;
          last_update := query.FieldByName('last_update').AsInteger;
          created_at := query.FieldByName('created_at').AsInteger;
          Exists := true;
        end
      else
        begin
          Exists := false;
        end;
    end
  else
    Exists := false;
end;

{ TMachine }

procedure TMachine.Add(n: String; port: String);
var query: TFDQuery;
begin
  query := mainform.fdquery;
  if query.Connection.Connected then
    begin
      query.Close;
      query.SQL.Text := 'INSERT INTO machines (machine_name, port, created_at) VALUES ('''+n+''', ''' + port + ''', '+IntToStr(DateTimeToUnix(Now()))+')';
      query.ExecSQL;
    end
  else
    ShowMessage('Please restart application');
end;

procedure TMachine.Delete(i: Integer);
var
  query: TFDQuery;
begin
  query := mainform.fdquery;
  if query.Connection.Connected then
    begin
      query.Close;
      query.SQL.Text := 'DELETE FROM machines WHERE id=' + IntToStr(i);
      query.ExecSQL;
    end
  else
    ShowMessage('Please restart application');
end;

end.
