unit BE.Model;

interface

uses
  System.Generics.Collections,
  System.SysUtils;

type
  TBEModelDependency = class;

  TBEModel = class
  private
    Fdependencies: TObjectList<TBEModelDependency>;
  public
    property dependencies: TObjectList<TBEModelDependency> read Fdependencies write Fdependencies;

    constructor create;
    destructor Destroy; override;
  end;

  TBEModelDependency = class(TObject)
  private
    Fname: string;
    Fversion: String;
    procedure setname(const Value: string);
    procedure setversion(const Value: String);
  public
    property name: string read Fname write setname;
    property version: String read Fversion write setversion;

    function ToString: string; override;

    constructor create; overload;
    constructor create(AName: string; AVersion: String = ''); overload;
  end;

implementation

{ TBEModel }

constructor TBEModel.create;
begin
  Fdependencies := TObjectList<TBEModelDependency>.create;
end;

destructor TBEModel.Destroy;
begin
  Fdependencies.Free;
  inherited;
end;

{ TBEModelDependency }

constructor TBEModelDependency.create(AName, AVersion: String);
begin
  name := AName;
  version := AVersion;
end;

procedure TBEModelDependency.setname(const Value: string);
begin
  Fname := Value.ToLower.Trim;
end;

procedure TBEModelDependency.setversion(const Value: String);
begin
  Fversion := Value.ToLower.Trim;
end;

function TBEModelDependency.ToString: string;
begin
  result := name;
  if not version.Trim.IsEmpty then
    result := Format('%s:%s', [name, version]);
end;

constructor TBEModelDependency.create;
begin

end;

end.
