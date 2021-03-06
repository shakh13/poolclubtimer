unit mDeleteForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TmachineDeleteForm = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  id: Integer;
  machineDeleteForm: TmachineDeleteForm;

implementation

{$R *.dfm}

uses mManager, Models;

{ TmachineDeleteForm }

procedure TmachineDeleteForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TmachineDeleteForm.Button2Click(Sender: TObject);
var
  m: TMachine;
begin
  if id > 0 then
    m.Delete(id);
  machineManager.OnShow(Sender);
  Close;
end;


procedure TmachineDeleteForm.FormShow(Sender: TObject);
begin
  id := 0;
  if machineManager.machinesgrid.Row > 0 then
    begin
      label1.Caption := 'Do you really want to delete ' + machineManager.machinesgrid.Cells[1, machineManager.machinesgrid.Row] + '?';
      id := StrToInt(machineManager.machinesgrid.Cells[0, machineManager.machinesgrid.Row]);
    end
  else
    Close;
    
end;

end.
