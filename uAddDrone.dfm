inherited frmAddDrone: TfrmAddDrone
  ActiveControl = edtName
  Caption = 'Add Drone'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TButton
    TabOrder = 2
    OnClick = btnConfirmarClick
  end
  inherited btnCancel: TButton
    TabOrder = 3
  end
  object edtName: TLabeledEdit
    Left = 24
    Top = 32
    Width = 603
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 0
  end
  object edtWeight: TLabeledEdit
    Left = 24
    Top = 88
    Width = 147
    Height = 21
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Weight'
    MaxLength = 10
    TabOrder = 1
    OnKeyPress = edtWeightKeyPress
  end
end
