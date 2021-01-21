program DroneDeliveryService;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uClasses in 'uClasses.pas',
  uAddDialog in 'uAddDialog.pas' {frmAddDialog},
  uAddDrone in 'uAddDrone.pas' {frmAddDrone},
  uAddLocation in 'uAddLocation.pas' {frmAddLocation},
  uLoadMemo in 'uLoadMemo.pas' {frmLoadMemo},
  uExample in 'uExample.pas' {frmExample};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
