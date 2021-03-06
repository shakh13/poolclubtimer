unit usersManagerF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, Data.FMTBcd, Data.SqlExpr, Data.Win.ADODB,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.VCLUI.Wait, System.DateUtils;

type
  TusersManagerForm = class(TForm)
    fdtable: TFDTable;
    grid: TDBGrid;
    DataSource1: TDataSource;
    usernameEdit: TDBEdit;
    passwordEdit: TDBEdit;
    roleEdit: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FDConnection1: TFDConnection;
    procedure FormCreate(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  usersManagerForm: TusersManagerForm;

implementation

{$R *.dfm}

uses Unit1;

procedure TusersManagerForm.Button1Click(Sender: TObject);
begin
  if fdtable.Fields[0].AsInteger > 0 then
    begin
      fdtable.Edit;
      fdtable.FieldByName('role').AsInteger := roleEdit.ItemIndex;
      fdtable.FieldByName('created_at').AsInteger := DateTimeToUnix(now);
      fdtable.Post;
    end
  else
    begin
      fdtable.FieldByName('role').AsInteger := roleEdit.ItemIndex;
      fdtable.FieldByName('created_at').AsInteger := DateTimeToUnix(now);
      fdtable.FieldByName('status').AsInteger := 1;
      fdtable.Post;
    end;
end;

procedure TusersManagerForm.Button2Click(Sender: TObject);
begin
  fdtable.Append;
end;

procedure TusersManagerForm.Button3Click(Sender: TObject);
begin
  fdtable.Delete;
end;

procedure TusersManagerForm.FormCreate(Sender: TObject);
begin
  fdtable.Connection := mainform.fdconnection;
  fdtable.TableName := 'users';
  fdtable.Active := true;

  usernameEdit.DataField := 'username';
  passwordEdit.DataField := 'password';

  grid.Columns[0].Width := 30;
  grid.Columns[1].Width := 100;
  grid.Columns[2].Width := 100;
  grid.Columns[3].Width := 30;
  grid.Columns[4].Width := 50;

end;

procedure TusersManagerForm.gridCellClick(Column: TColumn);
begin
  roleEdit.ItemIndex := grid.Fields[3].AsInteger;
end;

end.
