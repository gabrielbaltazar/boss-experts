unit BE.Model;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  System.SysUtils,
  System.IniFiles,
  BE.Helpers.Json,
  ToolsAPI;

const
  INI_FILE = 'BossExperts.ini';

type
  TBEModelDependency = class;

  TBEModel = class
  private
    Fdependencies: TObjectList<TBEModelDependency>;

    procedure loadHashloadMiddlewares;

    function DependencyExist(Name: String): Boolean;
    function AddDependency(Name: string; Version: String = ''): TBEModel;
  public
    property dependencies: TObjectList<TBEModelDependency> read Fdependencies write Fdependencies;

    constructor create;
    destructor Destroy; override;

    class procedure RemoveHistory(ADependency: String);
    class function LoadHistory: TBEModel;
    class function LoadDependencies(Project: IOTAProject): TBEModel;
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
    procedure SaveHistory;
    procedure RemoveHistory;

    constructor create; overload;
    constructor create(AName: string; AVersion: String = ''); overload;
  end;

function GetIniFile: TIniFile;

implementation

function GetIniFile: TIniFile;
var
  path: string;
begin
  path := ExtractFilePath(GetModuleName(HInstance) + 'BossExperts\');
  ForceDirectories(path);

  result := TIniFile.Create(path + INI_FILE);
end;

{ TBEModel }

function TBEModel.AddDependency(Name: string; Version: String = ''): TBEModel;
begin
  result := Self;
  if not DependencyExist(Name) then
    Fdependencies.Add(TBEModelDependency.create(Name, Version));
end;

constructor TBEModel.create;
begin
  Fdependencies := TObjectList<TBEModelDependency>.create;
end;

function TBEModel.DependencyExist(Name: String): Boolean;
var
  i: Integer;
begin
  result := False;
  for i := 0 to Pred(Fdependencies.Count) do
  begin
    if Fdependencies[i].name.Equals(Name.ToLower) then
      Exit(True);
  end;
end;

destructor TBEModel.Destroy;
begin
  Fdependencies.Free;
  inherited;
end;

class function TBEModel.LoadDependencies(Project: IOTAProject): TBEModel;
var
  jsonFile: String;
  json: TJSONObject;
  jsonDependencies: TJSONObject;
  i: Integer;
begin
  result := TBEModel.create;
  try
    jsonFile := ExtractFilePath(Project.FileName) + 'boss.json';
    if not FileExists(jsonFile) then
      exit;

    json := TJSONObject.LoadFromFile(jsonFile);
    try
      jsonDependencies := json.ValueAsJSONObject('dependencies');
      if not Assigned(jsonDependencies) then
        exit;

      for i := 0 to Pred(jsonDependencies.Count) do
        Result
          .AddDependency(jsonDependencies.PairName(i), jsonDependencies.PairValue(i));
    finally
      json.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TBEModel.LoadHistory: TBEModel;
var
  iniFile: TIniFile;
  sections: TStrings;
  i: Integer;
begin
  result := Self.create;
  try
    iniFile := GetIniFile;
    try
      sections := TStringList.Create;
      try
        iniFile.ReadSections(sections);
        for i := 0 to Pred(sections.Count) do
          Result
            .AddDependency(sections[i], iniFile.ReadString(sections[i], 'version', ''))
      finally
        sections.Free;
      end;

      result.loadHashloadMiddlewares;
    finally
      iniFile.Free;
    end;
  except
    result.Free;
    raise;
  end;
end;

class procedure TBEModel.RemoveHistory(ADependency: String);
var
  dependency: TBEModelDependency;
begin
  dependency := TBEModelDependency.create(ADependency);
  try
    dependency.RemoveHistory;
  finally
    dependency.Free;
  end;
end;

procedure TBEModel.loadHashloadMiddlewares;
begin
  Self
    .AddDependency('horse')
    .AddDependency('horse-basic-auth')
    .AddDependency('horse-compression')
    .AddDependency('horse-cors')
    .AddDependency('handle-exception')
    .AddDependency('horse-jwt')
    .AddDependency('horse-logger')
    .AddDependency('horse-octet-stream')
    .AddDependency('jhonson');
end;

{ TBEModelDependency }

constructor TBEModelDependency.create(AName, AVersion: String);
begin
  name := AName;
  version := AVersion;
end;

procedure TBEModelDependency.RemoveHistory;
var
  iniFile: TIniFile;
begin
  iniFile := GetIniFile;
  try
    iniFile.EraseSection(name);
  finally
    iniFile.Free;
  end;
end;

procedure TBEModelDependency.SaveHistory;
var
  iniFile: TIniFile;
begin
  iniFile := GetIniFile;
  try
    iniFile.WriteString(name, 'version', Self.version);
  finally
    iniFile.Free;
  end;
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
