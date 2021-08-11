unit BE.ContextMenu;

interface

uses
  ToolsAPI,
  BE.Constants,
  BE.Commands.Interfaces,
  BE.Wizard.Forms,
  System.Classes,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Controls;

type
  TBEOnContextMenuClick = procedure (const MenuContextList: IInterfaceList) of object;

  TBEContextMenuWizard = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  private
    FBossCommand: IBECommands;
    FProject: IOTAProject;

    procedure Initialize(Project: IOTAProject);
    procedure VerifyBoss;
    procedure DoRefreshProject;

    procedure OnExecuteBossInit(const MenuContextList: IInterfaceList);
    procedure OnExecuteBossInstall(const MenuContextList: IInterfaceList);
    procedure OnExecuteBossUpdate(const MenuContextList: IInterfaceList);
    procedure OnExecuteBossUninstall(const MenuContextList: IInterfaceList);
    procedure OnExecuteDependencies(const MenuContextList: IInterfaceList);
    procedure OnExecuteCacheRemove(const MenuContextList: IInterfaceList);

    function AddMenu(Caption: String;
                     Position: Integer;
                     Parent: string = '';
                     OnExecute: TBEOnContextMenuClick = nil;
                     Checked: Boolean = False): IOTAProjectManagerMenu; overload;
  protected
    procedure AddMenu(const Project: IOTAProject;
                      const IdentList: TStrings;
                      const MenuList: IInterfaceList;
                            IsMultiSelect: Boolean); overload;

  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
  end;

  TBEContextMenu = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
  private
    FCaption: String;
    FIsMultiSelectable: Boolean;
    FChecked: Boolean;
    FEnabled: Boolean;
    FHelpContext: Integer;
    FName: string;
    FParent: string;
    FPosition: Integer;
    FVerb: string;

  protected
    FProject: IOTAProject;
    FBossCommand: IBECommands;
    FOnExecute: TBEOnContextMenuClick;

    procedure DoRefreshProject;

    procedure VerifyBoss;

    function GetCaption: string;
    function GetChecked: Boolean;
    function GetEnabled: Boolean;
    function GetHelpContext: Integer;
    function GetName: string;
    function GetParent: string;
    function GetPosition: Integer;
    function GetVerb: string;
    procedure SetCaption(const Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetHelpContext(Value: Integer);
    procedure SetName(const Value: string);
    procedure SetParent(const Value: string);
    procedure SetPosition(Value: Integer);
    procedure SetVerb(const Value: string);
    function GetIsMultiSelectable: Boolean;
    procedure SetIsMultiSelectable(Value: Boolean);
    procedure Execute(const MenuContextList: IInterfaceList); virtual;
    function PreExecute(const MenuContextList: IInterfaceList): Boolean;
    function PostExecute(const MenuContextList: IInterfaceList): Boolean;

    constructor create(OnExecute: TBEOnContextMenuClick); overload;
    class function New(OnExecute: TBEOnContextMenuClick): IOTAProjectManagerMenu; overload;
  end;

var
  IndexContextMenuBoss: Integer = -1;

procedure RegisterContextMenu;

implementation

procedure RegisterContextMenu;
begin
  IndexContextMenuBoss := (BorlandIDEServices as IOTAProjectManager)
    .AddMenuItemCreatorNotifier(TBEContextMenuWizard.New);
end;

{ TBEContextMenuWizard }

procedure TBEContextMenuWizard.AddMenu(const Project: IOTAProject;
                                       const IdentList: TStrings;
                                       const MenuList: IInterfaceList;
                                             IsMultiSelect: Boolean);
begin
  if (IdentList.IndexOf(sProjectContainer) < 0) or
     (not Assigned(MenuList))
  then
    Exit;

  Initialize(Project);

  MenuList.Add(AddMenu(BOSS_CAPTION, BOSS_POSITION));
  MenuList.Add(AddMenu(BOSS_INIT_CAPTION, BOSS_INIT_POSITION, BOSS_CAPTION, OnExecuteBossInit, FBossCommand.BossInstalled));
  MenuList.Add(AddMenu('-', BOSS_INSTALL_SEPARATOR_POSITION, BOSS_CAPTION));
  MenuList.Add(AddMenu(BOSS_INSTALL_CAPTION, BOSS_INSTALL_POSITION, BOSS_CAPTION, OnExecuteBossInstall));
  MenuList.Add(AddMenu(BOSS_UPDATE_CAPTION, BOSS_UPDATE_POSITION, BOSS_CAPTION, OnExecuteBossUpdate));
  MenuList.Add(AddMenu(BOSS_UNINSTALL_CAPTION, BOSS_UNINSTALL_POSITION, BOSS_CAPTION, OnExecuteBossUninstall));
  MenuList.Add(AddMenu('-', BOSS_DEPENDENCIES_SEPARATOR_POSITION, BOSS_CAPTION));
  MenuList.Add(AddMenu(BOSS_DEPENDENCIES_CAPTION, BOSS_DEPENDENCIES_POSITION, BOSS_CAPTION, OnExecuteDependencies));
  MenuList.Add(AddMenu('-', BOSS_CACHE_SEPARATOR_POSITION, BOSS_CAPTION));
  MenuList.Add(AddMenu(BOSS_REMOVE_CACHE_CAPTION, BOSS_REMOVE_CACHE_POSITION, BOSS_CAPTION, OnExecuteCacheRemove));
end;

function TBEContextMenuWizard.AddMenu(Caption: String;
  Position: Integer; Parent: string; OnExecute: TBEOnContextMenuClick;
  Checked: Boolean): IOTAProjectManagerMenu;
begin
  result := TBEContextMenu.New(OnExecute);
  Result.Caption := Caption;
  result.Verb := Caption;
  Result.Parent := Parent;
  result.Position := Position;
  result.Checked := Checked;
  result.IsMultiSelectable := False;
end;

procedure TBEContextMenuWizard.DoRefreshProject;
begin
  FProject.Refresh(True);
end;

procedure TBEContextMenuWizard.Initialize(Project: IOTAProject);
begin
  FProject := Project;
  FBossCommand := CreateBossCommand(ExtractFilePath(FProject.FileName));
end;

class function TBEContextMenuWizard.New: IOTAProjectMenuItemCreatorNotifier;
begin
  result := Self.Create;
end;

procedure TBEContextMenuWizard.OnExecuteBossInit(const MenuContextList: IInterfaceList);
begin
  if FBossCommand.BossInstalled then
    raise Exception.CreateFmt('Boss already installed.', []);
  FBossCommand.Init;
end;

procedure TBEContextMenuWizard.OnExecuteBossInstall(const MenuContextList: IInterfaceList);
begin
  VerifyBoss;
  FBossCommand.Install(Self.DoRefreshProject);
end;

procedure TBEContextMenuWizard.OnExecuteBossUninstall(const MenuContextList: IInterfaceList);
begin
  VerifyBoss;
  if(MessageDlg('Do you really want to uninstall all dependency?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes)then
    FBossCommand.Uninstall(Self.DoRefreshProject);
end;

procedure TBEContextMenuWizard.OnExecuteBossUpdate(const MenuContextList: IInterfaceList);
begin
  VerifyBoss;
  FBossCommand.Update(Self.DoRefreshProject);
end;

procedure TBEContextMenuWizard.OnExecuteCacheRemove(const MenuContextList: IInterfaceList);
begin
  VerifyBoss;
  FBossCommand.RemoveCache(Self.DoRefreshProject);
end;

procedure TBEContextMenuWizard.OnExecuteDependencies(const MenuContextList: IInterfaceList);
begin
  VerifyBoss;
  BEWizardForms := TBEWizardForms.create(nil, FBossCommand, FProject);
  try
    BEWizardForms.ShowModal;
  finally
    BEWizardForms.Free;
  end;
end;

procedure TBEContextMenuWizard.VerifyBoss;
begin
  if not FBossCommand.BossInstalled then
    raise Exception.Create('Boss is not installed. Use Boss Init...');
end;

{ TBEContextMenu }

constructor TBEContextMenu.create(OnExecute: TBEOnContextMenuClick);
begin
  FOnExecute := OnExecute;
  FEnabled := True;
  FChecked := False;
  FIsMultiSelectable := False;
end;

procedure TBEContextMenu.DoRefreshProject;
begin
  FProject.Refresh(True);
end;

procedure TBEContextMenu.Execute(const MenuContextList: IInterfaceList);
begin
  if Assigned(FOnExecute) then
    FOnExecute(MenuContextList);
end;

function TBEContextMenu.GetCaption: string;
begin
  result := FCaption;
end;

function TBEContextMenu.GetChecked: Boolean;
begin
  result := FChecked;
end;

function TBEContextMenu.GetEnabled: Boolean;
begin
  result := FEnabled;
end;

function TBEContextMenu.GetHelpContext: Integer;
begin
  result := FHelpContext;
end;

function TBEContextMenu.GetIsMultiSelectable: Boolean;
begin
  Result := FIsMultiSelectable;
end;

function TBEContextMenu.GetName: string;
begin
  result := FName;
end;

function TBEContextMenu.GetParent: string;
begin
  result := FParent;
end;

function TBEContextMenu.GetPosition: Integer;
begin
  result := FPosition;
end;

function TBEContextMenu.GetVerb: string;
begin
  result := FVerb;
end;

class function TBEContextMenu.New(OnExecute: TBEOnContextMenuClick): IOTAProjectManagerMenu;
begin
  result := Self.create(OnExecute);
end;

function TBEContextMenu.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  result := True;
end;

function TBEContextMenu.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  result := True;
end;

procedure TBEContextMenu.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TBEContextMenu.SetChecked(Value: Boolean);
begin
  FChecked := Value;
end;

procedure TBEContextMenu.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TBEContextMenu.SetHelpContext(Value: Integer);
begin
  FHelpContext := Value;
end;

procedure TBEContextMenu.SetIsMultiSelectable(Value: Boolean);
begin
  FIsMultiSelectable := Value;
end;

procedure TBEContextMenu.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TBEContextMenu.SetParent(const Value: string);
begin
  FParent := Value;
end;

procedure TBEContextMenu.SetPosition(Value: Integer);
begin
  FPosition := Value;
end;

procedure TBEContextMenu.SetVerb(const Value: string);
begin
  FVerb := Value;
end;

procedure TBEContextMenu.VerifyBoss;
begin
  if not FBossCommand.BossInstalled then
    raise Exception.Create('Boss is not installed. Use Boss Init...');
end;

initialization

finalization
  if IndexContextMenuBoss >= 0 then
    (BorlandIDEServices as IOTAProjectManager)
      .RemoveMenuItemCreatorNotifier(IndexContextMenuBoss);

end.
