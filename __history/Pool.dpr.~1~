program Pool;

uses
  Forms,
  Unit1 in 'Unit1.pas' {mainform},
  mManager in 'mManager.pas' {machineManager},
  Models in 'Models.pas',
  mAddForm in 'mAddForm.pas' {machineAddForm},
  mDeleteForm in 'mDeleteForm.pas' {machineDeleteForm},
  SettingsF in 'SettingsF.pas' {SettingsForm},
  cashF in 'cashF.pas' {cashForm},
  lofinF in 'lofinF.pas' {loginForm},
  usersManagerF in 'usersManagerF.pas' {usersManagerForm},
  historyF in 'historyF.pas' {historyForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(TloginForm, loginForm);
  Application.CreateForm(TmachineManager, machineManager);
  Application.CreateForm(TmachineAddForm, machineAddForm);
  Application.CreateForm(TmachineDeleteForm, machineDeleteForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TcashForm, cashForm);
  Application.CreateForm(TusersManagerForm, usersManagerForm);
  Application.CreateForm(ThistoryForm, historyForm);
  Application.Run;
end.
