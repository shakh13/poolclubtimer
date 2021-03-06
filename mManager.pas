unit mManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.Grids, FireDAC.Comp.Client, System.DateUtils;

type
  TmachineManager = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    machineDeleteBtn: TSpeedButton;
    machinesgrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure machineDeleteBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    function statusToStr(s: Integer): String;
    { Public declarations }
  end;

var
  machineManager: TmachineManager;

implementation

{$R *.dfm}

uses Models, Unit1, mAddForm, mDeleteForm;

procedure TmachineManager.FormCreate(Sender: TObject);
begin
  machinesgrid.Cells[0,0] := 'ID';
  machinesgrid.Cells[1,0] := 'Name';
  machinesgrid.Cells[2,0] := 'Port';
  machinesgrid.Cells[3,0] := 'Status';
  machinesgrid.Cells[4,0] := 'Created at';
end;

procedure TmachineManager.FormShow(Sender: TObject);
var
  i : integer;
  query: TFDQuery;
begin
  machineDeleteBtn.Enabled := false;
  query := mainform.fdquery;
  if query.Connection.Connected then
    begin
      query.Close;
      query.Open('SELECT * FROM machines ORDER BY id');
      if query.RecordCount > 0 then
        begin
          machineDeleteBtn.Enabled := true;
          machinesgrid.RowCount := query.RecordCount + 1;
          query.First;
          for i := 1 to query.RecordCount do
            begin
              machinesgrid.Cells[0, i] := query.FieldByName('id').AsString;
              machinesgrid.Cells[1, i] := query.FieldByName('machine_name').AsString;
              machinesgrid.Cells[2, i] := query.FieldByName('port').AsString;
              machinesgrid.Cells[3, i] := statusToStr(query.FieldByName('status').AsInteger);
              machinesgrid.Cells[4, i] := datetimetostr(UnixToDateTime(query.FieldByName('created_at').AsInteger));
              query.Next;
            end;

        end
      else
        ShowMessage('No machines found');
    end
  else
    ShowMessage('Please restart application');
end;

procedure TmachineManager.SpeedButton1Click(Sender: TObject);
begin
  machineAddForm.ShowModal;
end;

procedure TmachineManager.machineDeleteBtnClick(Sender: TObject);
begin
  machineDeleteForm.ShowModal;
end;

function TmachineManager.statusToStr(s: Integer): String;
begin
  if s = 1 then
    result := 'Active'
  else
    result := 'Inactive';
end;

end.
