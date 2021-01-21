object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Drone Delivery Service'
  ClientHeight = 489
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  DesignSize = (
    848
    489)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 34
    Height = 13
    Caption = 'Output'
  end
  object lblOutput: TLabel
    Left = 448
    Top = 8
    Width = 225
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
  end
  object btnAddDrone: TButton
    Left = 697
    Top = 118
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Add Drone'
    Enabled = False
    TabOrder = 0
    OnClick = btnAddDroneClick
  end
  object btnAddLocation: TButton
    Left = 697
    Top = 149
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Add Location'
    Enabled = False
    TabOrder = 1
    OnClick = btnAddLocationClick
  end
  object btnLoadFromFile: TButton
    Left = 697
    Top = 25
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Load From File'
    TabOrder = 2
    OnClick = btnLoadFromFileClick
  end
  object btnLoadFromMemo: TButton
    Left = 697
    Top = 56
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Load From Memo'
    TabOrder = 3
    OnClick = btnLoadFromMemoClick
  end
  object btnTrips: TButton
    Left = 697
    Top = 87
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'List Trips'
    Enabled = False
    TabOrder = 4
    OnClick = btnTripsClick
  end
  object memOutput: TMemo
    Left = 16
    Top = 27
    Width = 657
    Height = 446
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
  end
  object btnDrones: TButton
    Left = 697
    Top = 180
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'List Drones'
    Enabled = False
    TabOrder = 6
    OnClick = btnDronesClick
  end
  object btnLocations: TButton
    Left = 697
    Top = 211
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'List Locations'
    Enabled = False
    TabOrder = 7
    OnClick = btnLocationsClick
  end
  object openDialog: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 728
    Top = 304
  end
end
