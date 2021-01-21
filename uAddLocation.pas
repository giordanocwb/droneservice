unit uAddLocation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uAddDialog, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAddLocation = class(TfrmAddDialog)
    edtName: TLabeledEdit;
    edtWeight: TLabeledEdit;
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtWeightKeyPress(Sender: TObject; var Key: Char);
  private
    FLocationName: String;
    FLocationWeight: Double;
    procedure SetLocationName(const Value: String);
    procedure SetLocationWeight(const Value: Double);
    { Private declarations }
  public
    property LocationName: String read FLocationName write SetLocationName;
    property LocationWeight: Double read FLocationWeight write SetLocationWeight;
  end;

var
  frmAddLocation: TfrmAddLocation;

implementation

{$R *.dfm}

{ TfrmAddLocation }

procedure TfrmAddLocation.btnConfirmarClick(Sender: TObject);
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

  FLocationName := Trim(edtName.Text);
  FLocationWeight := StrToFloatDef(Trim(edtWeight.Text), 0);
end;

procedure TfrmAddLocation.edtWeightKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmAddLocation.SetLocationName(const Value: String);
begin
  FLocationName := Value;
end;

procedure TfrmAddLocation.SetLocationWeight(const Value: Double);
begin
  FLocationWeight := Value;
end;

end.
