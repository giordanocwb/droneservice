unit uClasses;

interface

uses
  Generics.Collections, SysUtils, System.Classes;

type
  TTrip = class;

  TBaseObject = class
  private
    FName: String;
    FWeight: Double;
    procedure SetName(const Value: String);
    procedure SetWeight(const Value: Double);
  public
    constructor Create(AName: String; AWeight: Double); reintroduce;

    property Name: String read FName write SetName;
    property Weight: Double read FWeight write SetWeight;
  end;

  TDrone = class(TBaseObject)
  private
    FTrips: TList<TTrip>;
    procedure SetTrips(const Value: TList<TTrip>);
  public
    constructor Create(AName: String; AWeight: Double);
    destructor Destroy; override;

    property Trips: TList<TTrip> read FTrips write SetTrips;
  end;

  TLocation = class(TBaseObject)
  private
    FTrip: TTrip;
    procedure SetTrip(const Value: TTrip);
  public
    property Trip: TTrip read FTrip write SetTrip;
  end;

  TTrip = class
  private
    FLocations: TList<TLocation>;
    FNumber: Integer;
    FDrone: TDrone;
    procedure SetLocations(const Value: TList<TLocation>);
    procedure SetNumber(const Value: Integer);
    function GetAvailableWeight: Double;
    procedure SetDrone(const Value: TDrone);
  public
    constructor Create(ADrone: TDrone; ANumber: Integer; ALocation: TLocation); reintroduce;
    destructor Destroy; override;
    function GetAllLocations: String;

    property Number: Integer read FNumber write SetNumber;
    property Locations: TList<TLocation> read FLocations write SetLocations;
    property AvailableWeight: Double read GetAvailableWeight;
    property Drone: TDrone read FDrone write SetDrone;
  end;

implementation

{ TDrone }

constructor TBaseObject.Create(AName: String; AWeight: Double);
begin
  inherited Create;

  FName := AName;
  FWeight := AWeight;
end;

procedure TBaseObject.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TBaseObject.SetWeight(const Value: Double);
begin
  if Value < 0 then
    raise Exception.Create('Weight less than zero.')
  else if Value = 0 then
    raise Exception.Create('Weight equal to zero.');

  FWeight := Value;
end;

{ TDrone }

constructor TDrone.Create(AName: String; AWeight: Double);
begin
  inherited;
  FTrips := TList<TTrip>.Create;
end;

destructor TDrone.Destroy;
begin
  FTrips.Free;
  inherited;
end;

procedure TDrone.SetTrips(const Value: TList<TTrip>);
begin
  FTrips := Value;
end;

{ TTrip }

constructor TTrip.Create(ADrone: TDrone; ANumber: Integer; ALocation: TLocation);
begin
  inherited Create;
  FLocations := TList<TLocation>.Create;

  FDrone := ADrone;
  FNumber := ANumber;
  FLocations.Add(ALocation);

  ALocation.Trip := Self;
end;

destructor TTrip.Destroy;
begin
  FLocations.Free;
  inherited;
end;

function TTrip.GetAllLocations: String;
var
  slLocations: TStringList;
  location: TLocation;
begin
  slLocations := TStringList.Create;

  try
    slLocations.Delimiter := ',';
    slLocations.StrictDelimiter := True;

    for location in FLocations do
      slLocations.Add(location.Name);

    Result := slLocations.DelimitedText;
  finally
    slLocations.Free;
  end;
end;

function TTrip.GetAvailableWeight: Double;
var
  location: TLocation;
begin
  Result := FDrone.Weight;

  for location in FLocations do
    Result := Result - location.Weight;
end;

procedure TTrip.SetDrone(const Value: TDrone);
begin
  FDrone := Value;
end;

procedure TTrip.SetLocations(const Value: TList<TLocation>);
begin
  FLocations := Value;
end;

procedure TTrip.SetNumber(const Value: Integer);
begin
  FNumber := Value;
end;

{ TLocation }

procedure TLocation.SetTrip(const Value: TTrip);
begin
  FTrip := Value;
end;

end.
