unit BE.Commands.Interfaces;

interface

type
  IBECommands = interface
    ['{26E2AB32-5572-446B-B154-E23F5E227369}']
    function Init: IBECommands;
    function Login(Host: String): IBECommands;

    function Install: IBECommands; overload;
    function Install(ADependency: string; AVersion: String = ''): IBECommands; overload;

    function Update: IBECommands; overload;
    function Update(ADependency: string; AVersion: String = ''): IBECommands; overload;

    function Uninstall: IBECommands; overload;
    function Uninstall(ADependency: String): IBECommands; overload;
  end;

function CreateBossCommand(Path: String): IBECommands;

implementation

uses
  BE.Commands.ProcessDelphi;

function CreateBossCommand(Path: String): IBECommands;
begin
  result := TBECommandsProcessDelphi.New(Path);
end;

end.
