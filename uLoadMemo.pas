unit uLoadMemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLoadMemo = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    memInput: TMemo;
    Label1: TLabel;
    btnExample: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnExampleClick(Sender: TObject);
  private
    FInput: TStrings;
    procedure SetInput(const Value: TStrings);
    { Private declarations }
  public
    property Input: TStrings read FInput write SetInput;
  end;

var
  frmLoadMemo: TfrmLoadMemo;

implementation

{$R *.dfm}

uses uExample;

procedure TfrmLoadMemo.btnExampleClick(Sender: TObject);
var
  frm: TfrmExample;
begin
  frm := TfrmExample.Create(Self);

  try
    frm.ShowModal;
  finally
    frm.Release;
  end;
end;

procedure TfrmLoadMemo.btnOKClick(Sender: TObject);
begin
  if Trim(memInput.Text) = '' then
    raise Exception.Create('Configuration is required');

  FInput := memInput.Lines;

  ModalResult := mrOk;
end;

procedure TfrmLoadMemo.SetInput(const Value: TStrings);
begin
  FInput := Value;
end;

end.
