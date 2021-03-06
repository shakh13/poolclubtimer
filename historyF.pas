unit historyF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.DateUtils;

type
  ThistoryForm = class(TForm)
    grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  historyForm: ThistoryForm;

implementation

{$R *.dfm}

uses Unit1;

procedure ThistoryForm.FormCreate(Sender: TObject);
begin

  grid.Cells[0, 0] := 'ID';
  grid.Cells[1, 0] := 'Machine';
  grid.Cells[2, 0] := 'Is VIP';
  grid.Cells[3, 0] := 'Price';
  grid.Cells[4, 0] := 'Begin';

  grid.ColWidths[0] := 60;
  grid.ColWidths[1] := 140;

  grid.ColWidths[3] := 140;
  grid.ColWidths[4] := 140;
end;

procedure ThistoryForm.FormShow(Sender: TObject);
var
  I: Integer;
  price: Integer;
begin
  mainform.fdquery.Close;
  mainform.fdquery.Open('SELECT timer.id as id, machines.machine_name as machine_name, timer.is_vip as is_vip, timer.finishes as finishes, timer.created_at as created_at FROM timer INNER JOIN machines ON timer.machine_id=machines.id ORDER BY timer.id DESC');

  if mainform.fdquery.RecordCount > 0 then
    begin
      grid.RowCount := mainform.fdquery.RecordCount + 1;
      mainform.fdquery.First;
      for I := 1 to mainform.fdquery.RecordCount do
        begin
          grid.Cells[0, I] := mainform.fdquery.FieldByName('id').AsString;
          grid.Cells[1, I] := mainform.fdquery.FieldByName('machine_name').AsString;

          if mainform.fdquery.FieldByName('is_vip').AsInteger = 0 then
            grid.Cells[2, I] := 'Not VIP'
          else
            grid.Cells[2, I] := 'VIP';

          grid.Cells[3, I] := IntToStr(round((mainform.fdquery.FieldByName('finishes').AsInteger - mainform.fdquery.FieldByName('created_at').AsInteger) / 3600 * mainform.getPrice));
          grid.Cells[4, I] := DateTimeToStr(UnixToDateTime(mainform.fdquery.FieldByName('created_at').AsInteger));

          mainform.fdquery.Next;
        end;
    end;
end;

end.
