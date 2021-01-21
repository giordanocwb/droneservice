unit uAddDrone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uAddDialog, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAddDrone = class(TfrmAddDialog)
    edtName: TLabeledEdit;
    edtWeight: TLabeledEdit;
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtWeightKeyPress(Sender: TObject; var Key: Char);
  private
    FDroneName: String;
    FDroneWeight: Double;
    procedure SetDroneName(const Value: String);
    procedure SetDroneWeight(const Value: Double);
    { Private declarations }
  public
    property DroneName: String read FDroneName write SetDroneName;
    property DroneWeight: Double read FDroneWeight write SetDroneWeight;
  end;

var
  frmAddDrone: TfrmAddDrone;

implementation

{$R *.dfm}

{ TfrmAddDrone }

procedure TfrmAddDrone.btnConfirmarClick(Sender: TObject);
var
  dWeight: Double;
begin
  inherited;
  if Trim(edtName.Text) = '' then
    raise Exception.Create('Name is required.');

  if Trim(edtWeight.Text) = '' then
    raise Exception.Create('Weight is required.');

  if not(TryStrToFloat(Trim(edtWeight.Text), dWeight)) then
    raise Exception.Create('Weight is invalid.');

  if StrToFloatDef(Trim(edtWeight.Text), 0) = 0 then
    raise Exception.Create('Weight is required.');

  FDroneName := Trim(edtName.Text);
  FDroneWeight := StrToFloatDef(Trim(edtWeight.Text), 0);
end;

procedure TfrmAddDrone.edtWeightKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if ((Key < '0') or (Key > '9')) and (Key <> #8) and (Key <> '.') then
    Key := #0
  else if (Key = '.') then
  begin
    if Pos('.', edtWeight.Text) > 0 then
      Key := #0
  end;
end;

procedure TfrmAddDrone.SetDroneName(const Value: String);
begin
  FDroneName := Value;
end;

procedure TfrmAddDrone.SetDroneWeight(const Value: Double);
begin
  FDroneWeight := Value;
end;

end.
