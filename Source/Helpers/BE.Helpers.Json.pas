unit BE.Helpers.Json;

interface

uses
  System.Classes,
  System.JSON,
  System.SysUtils;

type TJSONObjectHelper = class helper for TJSONObject

  public
    function ValueAsJSONObject(Name: String): TJSONObject;
    function PairName (Index: Integer): string;
    function PairValue(Index: Integer): string;

    class function LoadFromFile(AFileName: String): TJSONObject;

end;

implementation

{ TJSONObjectHelper }

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
