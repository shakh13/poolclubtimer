unit mAddForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TmachineAddForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  machineAddForm: TmachineAddForm;

implementation

{$R *.dfm}

uses Models, Unit1, mManager;

procedure TmachineAddForm.Button1Click(Sender: TObject);
var
  m: TMachine;
begin

  mainform.fdquery.Close;
  mainform.fdquery.Open('SELECT * FROM machines WHERE status=1 AND port=' + SpinEdit1.Value.ToString);
  if mainform.fdquery.RecordCount > 0 then
    begin
      ShowMessage('This port is busy. Please try another port');
      exit;
    end;

  if (Length(Edit1.Text) > 0) and (SpinEdit1.Value > 0) and (SpinEdit1.Value < 14) then
    begin
      m.Add(Edit1.Text, SpinEdit1.Value.ToString);

      machineManager.OnShow(Sender);
      Close();
    end
  else
    ShowMessage('Please enter machine name');
end;

end.
