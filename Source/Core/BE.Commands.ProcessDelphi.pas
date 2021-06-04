unit BE.Commands.ProcessDelphi;

interface

uses
  dprocess,
  BE.Model,
  BE.Commands.Interfaces,
  {$IF CompilerVersion > 26.0}
  System.Threading,
  {$ENDIF}
  System.Classes,
  System.SysUtils;

type TBECommandsProcessDelphi = class(TInterfacedObject, IBECommands)

  private
    FPath: string;
    FAsyncMode: Boolean;

    procedure RunCommand(ACommand: String; AComplete: TProc);

  protected
    function AsyncMode(Value: Boolean): IBECommands;

    function Init: IBECommands;
    function Login(Host: String): IBECommands;

    function Install(AComplete: TProc = nil): IBECommands; overload;
    function Install(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands; overload;

    function Update(AComplete: TProc = nil): IBECommands; overload;
    function Update(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands; overload;

    function Uninstall(AComplete: TProc = nil): IBECommands; overload;
    function Uninstall(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands; overload;

  public
    constructor create(Path: string);
    class function New(Path: string): IBECommands;
end;

implementation

{ TBECommandsProcessDelphi }

function TBECommandsProcessDelphi.AsyncMode(Value: Boolean): IBECommands;
begin
  result := Self;
  FAsyncMode := Value;
end;

constructor TBECommandsProcessDelphi.create(Path: string);
begin
  FPath := Path;
  FAsyncMode := True;
end;

function TBECommandsProcessDelphi.Init: IBECommands;
begin
  result := Self;
  RunCommand('boss init', nil);
end;

function TBECommandsProcessDelphi.Install(AComplete: TProc = nil): IBECommands;
begin
  result := Self;

  RunCommand('boss install', AComplete);
end;

function TBECommandsProcessDelphi.Install(ADependency: TBEModelDependency; AComplete: TProc): IBECommands;
begin
  result := Self;
  RunCommand(Format('boss install %s', [ADependency.ToString]).Trim, AComplete);
end;

function TBECommandsProcessDelphi.Login(Host: String): IBECommands;
begin
  result := Self;
  RunCommand(Format('boss login %s', [Host]), nil);
end;

class function TBECommandsProcessDelphi.New(Path: string): IBECommands;
begin
  result := Self.create(Path);
end;

procedure TBECommandsProcessDelphi.RunCommand(ACommand: String; AComplete: TProc);
var
{$IF CompilerVersion <= 26.0}
  threadCommand: TThread;
{$ENDIF}
  proc: TProc;
begin
  proc :=
    procedure
    var
      output: AnsiString;
    begin
      RunCommandIndir(
        FPath,
        'cmd',
        ['/c', ACommand],
        output,
        [poNoConsole]);

      if Assigned(AComplete) then
        AComplete;
    end;

  if not FAsyncMode then
    proc
  else
  begin
    {$IF CompilerVersion <= 26.0}
    threadCommand := TThread.CreateAnonymousThread(
      procedure
      begin
        proc;
      end);
    threadCommand.Start;
    {$ELSE}
    TTask.Run(proc);
    {$ENDIF}
  end;
end;

function TBECommandsProcessDelphi.Uninstall(AComplete: TProc = nil): IBECommands;
begin
  result := Self;
  RunCommand('boss uninstall', AComplete);
end;

function TBECommandsProcessDelphi.Uninstall(ADependency: TBEModelDependency; AComplete: TProc = nil): IBECommands;
begin
  result := Self;
  RunCommand(Format('boss uninstall %s', [ADependency.name]).Trim, AComplete);
end;

function TBECommandsProcessDelphi.Update(AComplete: TProc = nil): IBECommands;
begin
  result := Self;
  RunCommand('boss update', AComplete);
end;

function TBECommandsProcessDelphi.Update(ADependency: TBEModelDependency; AComplete: TProc): IBECommands;
begin
  result := Self;
  RunCommand(Format('boss update %s', [ADependency.ToString]).Trim, AComplete);
end;

end.
