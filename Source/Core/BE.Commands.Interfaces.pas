unit BE.Commands.Interfaces;

interface

uses
  BE.Model,
  System.SysUtils;

type
  IBECommands = interface
    ['{26E2AB32-5572-446B-B154-E23F5E227369}']
    function AsyncMode(Value: Boolean): IBECommands;

    function Init: IBECommands;
    function Login(Host: String): IBECommands;

    function Install(AComplete: TProc = nil): IBECommands; overload;
    function Install(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands; overload;

    function Update(AComplete: TProc = nil): IBECommands; overload;
    function Update(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands; overload;

    function Uninstall(AComplete: TProc = nil): IBECommands; overload;
    function Uninstall(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands; overload;

    function BossInstalled: Boolean;
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
