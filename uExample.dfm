object frmExample: TfrmExample
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Example'
  ClientHeight = 501
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    794
    501)
  PixelsPerInch = 96
  TextHeight = 13
  object memInput: TMemo
    Left = 8
    Top = 8
    Width = 778
    Height = 435
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      
        'Drone A, 4, Drone B, 6, Drone C, 5.5, Drone D, 1, Drone E, 2, Dr' +
        'one F, 2, Drone G, 1'
      'Location A, 0.5'
      'Location B, 1'
      'Location C, 1.5'
      'Location D, 2'
      'Location E, 2.5'
      'Location F, 3'
      'Location G, 3.5'
      'Location H, 4'
      'Location I, 4.5'
      'Location J, 5'
      'Location K, 5.5'
      'Location L, 6'
      'Location M, 7'
      'Location N, 8')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitWidth = 768
    ExplicitHeight = 425
  end
  object btnClose: TButton
    Left = 679
    Top = 458
    Width = 107
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
    ExplicitLeft = 669
    ExplicitTop = 448
  end
end
