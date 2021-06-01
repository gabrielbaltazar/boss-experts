unit BE.Commands.ProcessDelphi;

interface

uses
  dprocess,
  BE.Commands.Interfaces,
  System.SysUtils;

type TBECommandsProcessDelphi = class(TInterfacedObject, IBECommands)

  private
    FPath: string;

    procedure RunCommand(ACommand: String);
  protected
    function Init: IBECommands;
    function Login(Host: String): IBECommands;

    function Install: IBECommands; overload;
    function Install(ADependency: string; AVersion: String = ''): IBECommands; overload;

    function Update: IBECommands; overload;
    function Update(ADependency: string; AVersion: String = ''): IBECommands; overload;

    function Uninstall: IBECommands; overload;
    function Uninstall(ADependency: String): IBECommands; overload;

  public
    constructor create(Path: string);
    class function New(Path: string): IBECommands;
end;

implementation

{ TBECommandsProcessDelphi }

constructor TBECommandsProcessDelphi.create(Path: string);
begin
  FPath := Path;
end;

function TBECommandsProcessDelphi.Init: IBECommands;
begin
  result := Self;
  RunCommand('boss init');
end;

function TBECommandsProcessDelphi.Install: IBECommands;
begin
  result := Self;
  RunCommand('boss install');
end;

function TBECommandsProcessDelphi.Install(ADependency, AVersion: String): IBECommands;
var
  dependency: String;
begin
  result := Self;
  dependency := ADependency;
  if not AVersion.Trim.IsEmpty then
    dependency := dependency + ':' + AVersion;

  RunCommand(Format('boss install %s', [dependency]).Trim);
end;

function TBECommandsProcessDelphi.Login(Host: String): IBECommands;
begin
  result := Self;
  RunCommand(Format('boss login %s', [Host]));
end;

class function TBECommandsProcessDelphi.New(Path: string): IBECommands;
begin
  result := Self.create(Path);
end;

procedure TBECommandsProcessDelphi.RunCommand(ACommand: String);
var
  output: AnsiString;
begin
  RunCommandIndir(
    FPath,
    'cmd',
    ['/c', ACommand],
    output,
    [poNoConsole]);
end;

function TBECommandsProcessDelphi.Uninstall: IBECommands;
begin
  result := Self;
  RunCommand('boss uninstall');
end;

function TBECommandsProcessDelphi.Uninstall(ADependency: String): IBECommands;
begin
  result := Self;
  RunCommand(Format('boss uninstall %s', [ADependency]).Trim);
end;

function TBECommandsProcessDelphi.Update: IBECommands;
begin
  result := Self;
  RunCommand('boss update');
end;

function TBECommandsProcessDelphi.Update(ADependency, AVersion: String): IBECommands;
var
  dependency: String;
begin
  result := Self;
  dependency := ADependency;
  if not AVersion.Trim.IsEmpty then
    dependency := dependency + ':' + AVersion;

  RunCommand(Format('boss update %s', [dependency]).Trim);
end;

end.
