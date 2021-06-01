unit BE.ContextMenu;

interface

uses
  ToolsAPI,
  Vcl.Menus,
  Vcl.Dialogs,
  BE.Wizard.Forms,
  System.Classes,
  System.SysUtils;

type
  TBEContextMenuWizard = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  protected
    procedure AddMenu(const Project: IOTAProject;
                      const IdentList: TStrings;
                      const ProjectManagerMenuList: IInterfaceList;
                            IsMultiSelect: Boolean);

  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
  end;

  TBEContextMenuBoss = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
  private
    FProject: IOTAProject;
    FCaption: String;
    FChecked: Boolean;
    FEnabled: Boolean;
    FHelpContext: Integer;
    FName: string;
    FParent: string;
    FPosition: Integer;
    FVerb: string;

  protected
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
    procedure Execute(const MenuContextList: IInterfaceList); overload;
    function PreExecute(const MenuContextList: IInterfaceList): Boolean;
    function PostExecute(const MenuContextList: IInterfaceList): Boolean;

  public
    constructor create(Project: IOTAProject; Position: Integer);
    class function New(Project: IOTAProject; Position: Integer): IOTAProjectManagerMenu;
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
                                       const ProjectManagerMenuList: IInterfaceList;
                                             IsMultiSelect: Boolean);
var
  position: Integer;
  i: Integer;
  projectMenu: IOTAProjectManagerMenu;
begin
  if (IdentList.IndexOf(sProjectContainer) < 0) or
     (not Assigned(ProjectManagerMenuList))
  then
    Exit;

  for i := 0 to Pred(ProjectManagerMenuList.Count) do
  begin
    projectMenu := (ProjectManagerMenuList.Items[i] as IOTAProjectManagerMenu);

    if projectMenu.Verb = 'Compare' then
    begin
      position := projectMenu.Position + 1;
      Break;
    end;
  end;

  ProjectManagerMenuList.Add(TBEContextMenuBoss.New(Project, position));
end;

class function TBEContextMenuWizard.New: IOTAProjectMenuItemCreatorNotifier;
begin
  result := Self.Create;
end;

{ TBEContextMenuBoss }

constructor TBEContextMenuBoss.create(Project: IOTAProject; Position: Integer);
begin
  FPosition := Position;
  FProject  := Project;
  FEnabled  := True;
  FCaption  := 'Boss';
  FParent := '';

end;

procedure TBEContextMenuBoss.Execute(const MenuContextList: IInterfaceList);
begin
  if not Assigned(BEWizardForms) then
    BEWizardForms := TBEWizardForms.Create(nil);
  BEWizardForms.Show;
end;

function TBEContextMenuBoss.GetCaption: string;
begin
  result := FCaption;
end;

function TBEContextMenuBoss.GetChecked: Boolean;
begin
  result := FChecked;
end;

function TBEContextMenuBoss.GetEnabled: Boolean;
begin
  result := FEnabled;
end;

function TBEContextMenuBoss.GetHelpContext: Integer;
begin
  result := FHelpContext;
end;

function TBEContextMenuBoss.GetIsMultiSelectable: Boolean;
begin
  Result := False;
end;

function TBEContextMenuBoss.GetName: string;
begin
  result := FName;
end;

function TBEContextMenuBoss.GetParent: string;
begin
  result := FParent;
end;

function TBEContextMenuBoss.GetPosition: Integer;
begin
  result := FPosition;
end;

function TBEContextMenuBoss.GetVerb: string;
begin
  result := FVerb;
end;

class function TBEContextMenuBoss.New(Project: IOTAProject; Position: Integer): IOTAProjectManagerMenu;
begin
  result := Self.create(Project, Position);
end;

function TBEContextMenuBoss.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  result := True;
  ShowMessage('oi');
end;

function TBEContextMenuBoss.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  ShowMessage('oi');
  result := True;
end;

procedure TBEContextMenuBoss.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TBEContextMenuBoss.SetChecked(Value: Boolean);
begin
  FChecked := Value;
end;

procedure TBEContextMenuBoss.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TBEContextMenuBoss.SetHelpContext(Value: Integer);
begin
  FHelpContext := Value;
end;

procedure TBEContextMenuBoss.SetIsMultiSelectable(Value: Boolean);
begin

end;

procedure TBEContextMenuBoss.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TBEContextMenuBoss.SetParent(const Value: string);
begin
  FParent := Value;
end;

procedure TBEContextMenuBoss.SetPosition(Value: Integer);
begin
  FPosition := Value;
end;

procedure TBEContextMenuBoss.SetVerb(const Value: string);
begin
  FVerb := Value;
end;

initialization

finalization
  if IndexContextMenuBoss >= 0 then
    (BorlandIDEServices as IOTAProjectManager)
      .RemoveMenuItemCreatorNotifier(IndexContextMenuBoss);

end.
