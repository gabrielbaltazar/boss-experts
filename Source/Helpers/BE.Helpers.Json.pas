unit BE.Helpers.Json;

interface

uses
  System.Classes,
  {$IF CompilerVersion > 26.0}
  System.JSON,
  {$ELSE}
  Data.DBXJSON,
  {$ENDIF}
  System.SysUtils;

type
  TJSONValue = {$IF CompilerVersion > 26.0} System.JSON.TJSONValue; {$ELSE} Data.DBXJSON.TJSONValue; {$ENDIF}
  TJSONObject = {$IF CompilerVersion > 26.0} System.JSON.TJSONObject; {$ELSE} Data.DBXJSON.TJSONObject; {$ENDIF}
  TJSONArray = {$IF CompilerVersion > 26.0} System.JSON.TJSONArray; {$ELSE} Data.DBXJSON.TJSONArray; {$ENDIF}

  TJSONObjectHelper = class helper for TJSONObject

  private
    {$IF CompilerVersion <= 26.0}
    function GetPairs(AIndex: Integer): TJSONPair;
    property Pairs[AIndex: Integer]: TJSONPair read GetPairs;
    {$ENDIF}
  public

    {$IF CompilerVersion <= 26.0}
    function Count: Integer;
    {$ENDIF}

    function ValueAsJSONObject(Name: String): TJSONObject;
    function PairName (Index: Integer): string;
    function PairValue(Index: Integer): string;

    class function LoadFromFile(AFileName: String): TJSONObject;

end;

implementation

{ TJSONObjectHelper }

{$IF CompilerVersion <= 26.0}
function TJSONObjectHelper.GetPairs(AIndex: Integer): TJSONPair;
begin
  result := Self.Get(AIndex);
end;
{$ENDIF}

{$IF CompilerVersion <= 26.0}
function TJSONObjectHelper.Count: Integer;
begin
  result := Self.Size;
end;
{$ENDIF}

class function TJSONObjectHelper.LoadFromFile(AFileName: String): TJSONObject;
var
  fileJson: TStringList;
begin
  fileJson := TStringList.Create;
  try
    fileJson.LoadFromFile(AFileName);
    result := TJSONObject.ParseJSONValue(fileJson.Text) as TJSONObject
  finally
    fileJson.Free;
  end;
end;

function TJSONObjectHelper.PairName(Index: Integer): string;
begin
  result := Self.Pairs[Index].JsonString.Value;
end;

function TJSONObjectHelper.PairValue(Index: Integer): string;
begin
  result := Self.Pairs[Index].JsonValue.Value;
end;

function TJSONObjectHelper.ValueAsJSONObject(Name: String): TJSONObject;
begin
  result := nil;
  if GetValue(Name) is TJSONObject then
    result := TJSONObject(GetValue(Name));
end;

end.
