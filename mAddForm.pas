unit mAddForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TmachineAddForm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
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
  if Length(Edit1.Text) > 0 then
    begin
      m.Add(Edit1.Text);

      machineManager.OnShow(Sender);
      Close();
    end
  else
    ShowMessage('Please enter machine name');
end;

end.