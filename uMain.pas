unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Generics.Collections, uClasses,
  System.Generics.Defaults;

type
  TfrmMain = class(TForm)
    btnAddDrone: TButton;
    btnAddLocation: TButton;
    btnLoadFromFile: TButton;
    btnLoadFromMemo: TButton;
    btnTrips: TButton;
    Label1: TLabel;
    lblOutput: TLabel;
    memOutput: TMemo;
    btnDrones: TButton;
    btnLocations: TButton;
    openDialog: TOpenDialog;
    procedure btnAddDroneClick(Sender: TObject);
    procedure btnDronesClick(Sender: TObject);
    procedure btnAddLocationClick(Sender: TObject);
    procedure btnLocationsClick(Sender: TObject);
    procedure btnLoadFromFileClick(Sender: TObject);
    procedure btnLoadFromMemoClick(Sender: TObject);
    procedure btnTripsClick(Sender: TObject);
  private
    FDrones: TList<TDrone>;
    FLocations: TList<TLocation>;
    procedure SetDrones(const Value: TList<TDrone>);
    procedure SetLocations(const Value: TList<TLocation>);
    procedure LoadConfiguration(sl: TStrings);
    procedure LoadDrones(sDrones: String);
    procedure LoadLocation(sLocation: String);
    procedure ListTrips;
    procedure ReorganizeTrip(ADrone: TDrone; ATrip: TTrip);
    { Private declarations }
  public
    constructor Create(AOwer: TComponent); override;
    destructor Destroy; override;

    property Drones: TList<TDrone> read FDrones write SetDrones;
    property Locations: TList<TLocation> read FLocations write SetLocations;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uAddDrone, uAddLocation, uLoadMemo;

{ TfrmMain }

procedure TfrmMain.btnAddDroneClick(Sender: TObject);
var
  frm: TfrmAddDrone;
begin
  if FDrones.Count >= 100 then
    raise Exception.Create('The maximum number of drones is 100.');

  frm := TfrmAddDrone.Create(Self);

  try
    if frm.ShowModal = mrOk then
    begin
      FDrones.Add(TDrone.Create(frm.DroneName, frm.DroneWeight));
      ListTrips;
    end;
  finally
    frm.Release;
  end;
end;

procedure TfrmMain.btnAddLocationClick(Sender: TObject);
var
  frm: TfrmAddLocation;
begin
  frm := TfrmAddLocation.Create(Self);

  try
    if frm.ShowModal = mrOk then
    begin
      FLocations.Add(TLocation.Create(frm.LocationName, frm.LocationWeight));
      ListTrips;
    end;
  finally
    frm.Release;
  end;
end;

procedure TfrmMain.btnDronesClick(Sender: TObject);
var
  drone: TDrone;
  sl: TStringList;
begin
  lblOutput.Caption := 'Drones';

  memOutput.Clear;

  sl := TStringList.Create;

  try
    for drone in FDrones do
      sl.Add(drone.Name + ' - ' + drone.Weight.ToString);

    if sl.Count > 0 then
      memOutput.Lines := sl;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.btnLoadFromFileClick(Sender: TObject);
var
  sl: TStringList;
begin
  if openDialog.InitialDir = '' then
    openDialog.InitialDir := ExtractFilePath(Application.ExeName);

  if openDialog.Execute then
  begin
    if not(FileExists(openDialog.FileName)) then
    begin
      ShowMessage('File ' + openDialog.FileName + ' not found.');
      Exit;
    end;

    sl := TStringList.Create;

    try
      sl.LoadFromFile(openDialog.FileName);

      LoadConfiguration(sl);
    finally
      sl.Free;
    end;
  end;
end;

procedure TfrmMain.btnLoadFromMemoClick(Sender: TObject);
var
  fmMemo: TfrmLoadMemo;
begin
  fmMemo := TfrmLoadMemo.Create(Self);

  try
    if fmMemo.ShowModal = mrOk then
      LoadConfiguration(fmMemo.Input);
  finally
    fmMemo.Release;
  end;
end;

procedure TfrmMain.LoadConfiguration(sl: TStrings);
var
  sLine: String;
  i: Integer;
Begin
  Drones.Clear;
  Locations.Clear;
  
  btnTrips.Enabled := True;
  btnAddDrone.Enabled := True;
  btnAddLocation.Enabled := True;
  btnDrones.Enabled := True;
  btnLocations.Enabled := True;
  
  for i := 0 to sl.Count - 1 do
  begin
    sLine := sl[i];

    if i = 0 then //if first line, load drones
      LoadDrones(sLine)
    else if Trim(sLine) <> '' then //after first line, each line has one location
      LoadLocation(Trim(sLine));
  end;

  if (FDrones.Count > 0) and (FLocations.Count > 0) then
    ListTrips;
end;

procedure TfrmMain.LoadLocation(sLocation: String);
var
  iPos: Integer;
  sName: String;
  sWeight: String;
begin
  iPos := Pos(',', sLocation);

  if iPos = 0 then
    raise Exception.Create('Invalid configuration.')
  else
  begin
    //the location line is like "Location, 3" 
    
    sName := Trim(Copy(sLocation, 1, iPos - 1));
    sWeight := Trim(Copy(sLocation, iPos + 1, Length(sLocation)));

    FLocations.Add(TLocation.Create(sName, StrToFloatDef(sWeight, 0)));
  end;
end;

procedure TfrmMain.LoadDrones(sDrones: String);
var
  i: Integer;
  sName: String;
  sWeight: String;
  slValues: TStringList;
begin
  //the drones line is like "Drone A, 1, Drone B, 3, Drone C, 7"
  slValues := TStringList.Create;

  try
    slValues.Delimiter := ',';
    slValues.StrictDelimiter := True;
    slValues.DelimitedText := sDrones;

    if slValues.Count <= 1 then
      raise Exception.Create('Invalid configuration.');

    i := 0;

    repeat
      sName := Trim(slValues[i]);

      if i + 1 >= slValues.Count then
        raise Exception.Create('Invalid configuration.');

      sWeight := Trim(slValues[i + 1]);

      FDrones.Add(TDrone.Create(sName, StrToFloatDef(sWeight, 0)));

      if FDrones.Count >= 100 then
        raise Exception.Create('The maximum number of drones is 100.');

      Inc(i, 2);
    until i >= slValues.Count;
  finally
    slValues.Free;
  end;
end;

procedure TfrmMain.btnLocationsClick(Sender: TObject);
var
  location: TLocation;
  sl: TStringList;
begin
  lblOutput.Caption := 'Locations';

  memOutput.Clear;

  sl := TStringList.Create;

  try
    for location in FLocations do
      sl.Add(location.Name + ' - ' + location.Weight.ToString);

    if sl.Count > 0 then
      memOutput.Lines := sl;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.btnTripsClick(Sender: TObject);
begin
  ListTrips;
end;

procedure TfrmMain.ListTrips;
var
  drone: TDrone;
  location: TLocation;
  trip: TTrip;
  sl: TStringList;
  availableLocations: TList<TLocation>;
  bTripCreated: Boolean;
  iTrip: Integer;
  sLocations: String;
  i: Integer;
begin
  lblOutput.Caption := 'Trips';

  memOutput.Clear;
  
  Screen.Cursor := crHourGlass;

  //locations that don't have a trip yet
  availableLocations := TList<TLocation>.Create;
  sl := TStringList.Create;

  try
    //clear all trips configurations before start
    for drone in FDrones do
      drone.Trips.Clear;
      
    for location in FLocations do
      location.Trip := nil;

    //sort the drones by weight descending
    FDrones.Sort(TComparer<TDrone>.Construct(
      function (const Left, Right: TDrone): Integer
      begin
        if Left.Weight > Right.Weight then
          Result := -1
        else if Left.Weight = Right.Weight then
          Result := 0
        else
          Result := 1;
      end
    ));

    for location in FLocations do
      if not(Assigned(location.Trip)) then
        availableLocations.Add(location);

    iTrip := 1;

    while availableLocations.Count > 0 do
    begin
      //sort the locations by weight descending
      availableLocations.Sort(TComparer<TLocation>.Construct(
        function (const Left, Right: TLocation): Integer
        begin
          if Left.Weight > Right.Weight then
            Result := -1
          else if Left.Weight = Right.Weight then
            Result := 0
          else
            Result := 1;
        end
      ));

      for drone in FDrones do
      begin
        //if trip was created in this round of the for, we don't create it again
        bTripCreated := False;
        
        for location in availableLocations do
        begin
          if location.Weight <= drone.Weight then
          begin
            if Assigned(location.Trip) then
              Continue;
              
            if drone.Trips.Count = 0 then
            begin
              drone.Trips.Add(TTrip.Create(drone, 1, location));
              bTripCreated := True;
            end
            else if drone.Trips[drone.Trips.Count - 1].AvailableWeight >= location.Weight then
            begin
              drone.Trips[drone.Trips.Count - 1].Locations.Add(location);
              location.Trip := drone.Trips[drone.Trips.Count - 1];
              bTripCreated := True;
            end
            else if (not(bTripCreated)) then
            begin
              drone.Trips.Add(TTrip.Create(drone, drone.Trips.Count + 1, location));
              bTripCreated := True;
            end;

            if drone.Trips[drone.Trips.Count - 1].AvailableWeight = 0 then
              Break;
          end;
        end;
      end;

      //get all available locations
      availableLocations.Clear;
    
      for location in FLocations do
      begin
        if not(Assigned(location.Trip)) then
        begin
          for drone in FDrones do
          begin
            if location.Weight <= drone.Weight then
            begin
              availableLocations.Add(location);
              Break;
            end;
          end;
        end;
      end;

      //from the second trip onwards we can reorganize the trips and locations to
      //take advantage of drones not fully loaded
      if iTrip > 1 then
      begin
        for drone in FDrones do
        begin
          for trip in drone.Trips do
          begin
            //if trip.Number <= iTrip then
            begin
              if trip.AvailableWeight > 0 then
              begin  
                ReorganizeTrip(drone, trip);
              end;
            end;
          end;
        end;
      end;

      Inc(iTrip);
    end;

    //list everything to the memo
    for drone in FDrones do
    begin
      if drone.Trips.Count > 0 then
        sl.Add(drone.Name);
      
      for trip in drone.Trips do
      begin
        sLocations := trip.GetAllLocations;
        
        if Trim(sLocations) <> '' then
        begin
          sl.Add('  Trip ' + trip.Number.ToString);
          sl.Add('    ' + sLocations);
        end;
      end;
    end;
    
    if sl.Count > 0 then
      memOutput.Lines := sl;
  finally
    sl.Free;
    availableLocations.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.ReorganizeTrip(ADrone: TDrone; ATrip: TTrip);
var
  drone: TDrone;
  trip: TTrip;
  location: TLocation;
  i: Integer;
  iIndexADrone: Integer;
begin
  iIndexADrone := -1;
  for i := 0 to FDrones.Count - 1 do
  begin
    if FDrones[i] = ADrone then
    begin
      iIndexADrone := i;
      Break;
    end;
  end;

  
  for i := 0 to FDrones.Count - 1 do
  begin
    drone := FDrones[i];
  
    if i <= iIndexADrone then
      Continue;

    for trip in drone.Trips do
    begin
      if trip.Number < ATrip.Number then
      begin
        for location in trip.Locations do
        begin
          if ATrip.AvailableWeight >= location.Weight then
          begin
            trip.Locations.Remove(location);

            if trip.Locations.Count = 0 then
              trip.Drone.Trips.Remove(trip);
            
            ATrip.Locations.Add(location);
            location.Trip := ATrip;
          end;
        end;
      end;
    end;
  end;
end;

constructor TfrmMain.Create(AOwer: TComponent);
begin
  inherited;
  FDrones := TList<TDrone>.Create;
  FLocations := TList<TLocation>.Create;

  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
end;

destructor TfrmMain.Destroy;
begin
  FreeAndNil(FDrones);
  FreeAndNil(FLocations);
  inherited;
end;

procedure TfrmMain.SetDrones(const Value: TList<TDrone>);
begin
  FDrones := Value;
end;

procedure TfrmMain.SetLocations(const Value: TList<TLocation>);
begin
  FLocations := Value;
end;

end.
