object frmLoadMemo: TfrmLoadMemo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Load Configuration from Memo'
  ClientHeight = 484
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    939
    484)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 8
    Width = 65
    Height = 13
    Caption = 'Configuration'
  end
  object btnOK: TButton
    Left = 680
    Top = 440
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 808
    Top = 440
    Width = 107
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object memInput: TMemo
    Left = 24
    Top = 27
    Width = 891
    Height = 393
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Drone 4, 4, Drone 6, 6, Drone 5.5, 5.5'
      'Location 0.5, 0.5'
      'Location 1, 1'
      'Location 1.5, 1.5'
      'Location 2, 2'
      'Location 2.5, 2.5'
      'Location 3, 3'
      'Location 3.5, 3.5'
      'Location 4, 4'
      'Location 4.5, 4.5'
      'Location 5, 5'
      'Location 5.5, 5.5'
      'Location 6, 6'
      'Location 7, 7'
      'Location 8, 8')
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
  object btnExample: TButton
    Left = 24
    Top = 440
    Width = 107
    Height = 25
    Caption = 'Example'
    TabOrder = 3
    OnClick = btnExampleClick
  end
end
