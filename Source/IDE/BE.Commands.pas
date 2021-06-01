unit BE.Commands;

interface

uses
  dprocess,
  System.SysUtils;

function RunCommand(ACommand: String): string;
function bossInit: String;
function login(AHost: String): string;
function install: string; overload;
function install(ADependency, AVersion: String): string; overload;
function update: string; overload;
function update(ADependency, AVersion: String): string; overload;
function uninstall(ADependency: String): string;

implementation

function bossInit: String;
begin
  result := RunCommand('boss init');
end;

function update: string;
begin
  Result := RunCommand('boss update');
end;

function install: string;
begin
  Result := RunCommand('boss install');
end;

function uninstall(ADependency: String): string;
begin
  result := RunCommand(Format('boss uninstall %s', [ADependency]));
end;

function update(ADependency, AVersion: String): string;
var
  dependency: string;
begin
  dependency := ADependency;
  if not AVersion.Trim.IsEmpty then
    dependency := Format('%s:%s', [ADependency, AVersion]);
  result := RunCommand(Format('boss update %s', [dependency]));
end;

function install(ADependency, AVersion: String): string;
var
  dependency: string;
begin
  dependency := ADependency;
  if not AVersion.Trim.IsEmpty then
    dependency := Format('%s:%s', [ADependency, AVersion]);
  result := RunCommand(Format('boss install %s', [dependency]));
end;

function login(AHost: String): string;
begin
  result := RunCommand(Format('boss login %s', [AHost]));
end;

function RunCommand(ACommand: String): string;
var
  output: AnsiString;
begin
  dprocess.RunCommand('cmd', ['/C:\workspace\Delphi\Frameworks\Nova pasta\', ACommand], output, [poNoConsole]);
  result := string(output);
end;

end.
