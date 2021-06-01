unit BE.Wizard.Menu;

interface

uses
  ToolsAPI,
  System.SysUtils,
  System.Classes,
  Vcl.Menus,
  BE.Wizard.Forms;

type TBEWizardMenu = class(TNotifierObject, IOTAWizard, IOTAMenuWizard)

  protected
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    procedure Execute;

    function GetMenuText: string;

  public
    class function New: IOTAWizard;
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterPackageWizard(TBEWizardMenu.New);
end;

{ TBEWizardMenu }

procedure TBEWizardMenu.Execute;
begin
  if not Assigned(BEWizardForms) then
    BEWizardForms := TBEWizardForms.Create(nil);
  BEWizardForms.Show;
end;

function TBEWizardMenu.GetIDString: string;
begin
  result := Self.ClassName;
end;

function TBEWizardMenu.GetMenuText: string;
begin
  result := 'Boss Expert';
end;

function TBEWizardMenu.GetName: string;
begin
  result := Self.ClassName;
end;

function TBEWizardMenu.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

class function TBEWizardMenu.New: IOTAWizard;
begin
  result := Self.Create;
end;

initialization

finalization
  BEWizardForms.Free;

end.
