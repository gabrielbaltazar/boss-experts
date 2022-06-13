unit BE.Wizard.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  BE.Commands.Interfaces, Vcl.ComCtrls, ToolsAPI, BE.Model, Vcl.Menus,
  BE.Dialogs, Vcl.Imaging.pngimage;

type
  TBEWizardForms = class(TForm)
    Label3: TLabel;
    edtHostLogin: TComboBox;
    Label1: TLabel;
    edtDependency: TEdit;
    Label2: TLabel;
    edtVersion: TEdit;
    lstHistory: TListBox;
    Label4: TLabel;
    lstDependencies: TListBox;
    Label5: TLabel;
    edtSearch: TEdit;
    pnlBack: TPanel;
    pnlBar: TPanel;
    Image1: TImage;
    imgInstall: TImage;
    imgUninstall: TImage;
    imgUpdate: TImage;
    imgLogin: TImage;
    imgExit: TImage;
    pnlTop: TPanel;
    Image2: TImage;
    Panel1: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lstHistoryClick(Sender: TObject);
    procedure lstDependenciesClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
    procedure imgInstallClick(Sender: TObject);
    procedure imgLoginClick(Sender: TObject);
    procedure imgUninstallClick(Sender: TObject);
    procedure imgUpdateClick(Sender: TObject);
  private
    FProject: IOTAProject;
    FBossCommand: IBECommands;

    procedure DoRefresh;
    procedure DoInstallDependency;
    procedure DoUninstallDependency;

    procedure LoadHistory;
    procedure LoadDependencies;

    function GetDependency: TBEModelDependency; overload;
    function GetDependency(Text: String): TBEModelDependency; overload;
    procedure SaveHistoryDependency;
    { Private declarations }
  public
    constructor create(AOwner: TComponent; BossCommand: IBECommands; Project: IOTAProject); reintroduce;
    { Public declarations }
  end;

var
  BEWizardForms: TBEWizardForms;

implementation

{$R *.dfm}

constructor TBEWizardForms.create(AOwner: TComponent; BossCommand: IBECommands; Project: IOTAProject);
begin
  inherited create(AOwner);
  FBossCommand := BossCommand;
  FProject := Project;
end;

procedure TBEWizardForms.DoInstallDependency;
begin
  DoRefresh;
  SaveHistoryDependency;
  LoadDependencies;
end;

procedure TBEWizardForms.DoRefresh;
begin
//  if Assigned(FProject) then
//    FProject.Refresh(True);
end;

procedure TBEWizardForms.DoUninstallDependency;
begin
  DoRefresh;
  LoadDependencies;
end;

procedure TBEWizardForms.edtSearchChange(Sender: TObject);
begin
  Self.LoadHistory;
end;

procedure TBEWizardForms.FormCreate(Sender: TObject);
begin
  Constraints.MinHeight := Height;
  Constraints.MinWidth  := Width;
end;

procedure TBEWizardForms.FormShow(Sender: TObject);
{$IF CompilerVersion > 31.0}
var
  theme: IOTAIDEThemingServices250;
  i: Integer;
{$ENDIF}
begin
  LoadHistory;
  LoadDependencies;

  {$IF CompilerVersion > 31.0}
  theme := (BorlandIDEServices as IOTAIDEThemingServices250);
  theme.RegisterFormClass(TBEWizardForms);

  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if Components[i] is TLabel then
      theme.ApplyTheme(TLabel(Components[i]));

    if Components[i] is TComboBox then
      theme.ApplyTheme(TComboBox(Components[i]));
  end;
  {$ENDIF}
end;

function TBEWizardForms.GetDependency(Text: String): TBEModelDependency;
var
  name: string;
  version: string;
begin
  name := Text;
  version := EmptyStr;
  if name.Contains(':') then
  begin
    name := Copy(Text, 1, Pos(':', Text) - 1);
    version:= Copy(Text, Pos(':', Text) + 1, 100).Trim;
  end;

  result := TBEModelDependency.create(name, version);
end;

function TBEWizardForms.GetDependency: TBEModelDependency;
begin
  result := TBEModelDependency.create(edtDependency.Text, edtVersion.Text);
end;

procedure TBEWizardForms.imgExitClick(Sender: TObject);
begin
  Close;
end;

procedure TBEWizardForms.imgInstallClick(Sender: TObject);
var
  dependency: TBEModelDependency;
begin
  dependency := GetDependency;
  try
    if dependency.name.Trim.IsEmpty then
      Exit;

    FBossCommand.Install(dependency, Self.DoInstallDependency);
  finally
    dependency.Free;
  end;
end;

procedure TBEWizardForms.imgLoginClick(Sender: TObject);
begin
  FBossCommand.Login(edtHostLogin.Text);
end;

procedure TBEWizardForms.imgUninstallClick(Sender: TObject);
var
  dependency: TBEModelDependency;
begin
  if lstDependencies.ItemIndex < 0 then
    Exit;

  dependency := GetDependency(lstDependencies.Items[lstDependencies.ItemIndex]);
  try
    if MessageConfirmation('Do you really want to uninstall the dependency %s?', [dependency.name])
    then
      FBossCommand.Uninstall(dependency, Self.DoUninstallDependency);
  finally
    dependency.Free;
  end;
end;

procedure TBEWizardForms.imgUpdateClick(Sender: TObject);
var
  dependency: TBEModelDependency;
begin
  dependency := GetDependency;
  try
    if dependency.name.Trim.IsEmpty then
      Exit;

    FBossCommand.Update(dependency, Self.DoInstallDependency);
  finally
    dependency.Free;
  end;
end;

procedure TBEWizardForms.LoadDependencies;
var
  Model: TBEModel;
  i: Integer;
begin
  Model := TBEModel.LoadDependencies(FProject);
  try
    lstDependencies.Items.Clear;
    for i := 0 to Pred(Model.dependencies.Count) do
      lstDependencies.Items.Add(Model.dependencies[i].ToString);
  finally
    Model.Free;
  end;
end;

procedure TBEWizardForms.LoadHistory;
var
  Model: TBEModel;
  i: Integer;
  search: string;
  dependency: string;
begin
  Model := TBEModel.LoadHistory;
  search := LowerCase(edtSearch.Text).Trim;
  try
    lstHistory.Items.Clear;
    for i := 0 to Pred(Model.dependencies.Count) do
    begin
      dependency := Model.dependencies[i].ToString;

      if (search.IsEmpty) or
         (dependency.Contains(search))
      then
        lstHistory.Items.Add(dependency);
    end;
  finally
    Model.Free;
  end;
end;

procedure TBEWizardForms.lstDependenciesClick(Sender: TObject);
var
  dependency: TBEModelDependency;
begin
  if lstDependencies.ItemIndex < 0 then
    Exit;

  dependency := GetDependency(lstDependencies.Items[lstDependencies.ItemIndex]);
  try
    edtDependency.Text := dependency.name;
    edtVersion.Text := dependency.version;
  finally
    dependency.Free;
  end;
end;

procedure TBEWizardForms.lstHistoryClick(Sender: TObject);
var
  dependency: TBEModelDependency;
begin
  if lstHistory.ItemIndex < 0 then
    Exit;

  dependency := GetDependency(lstHistory.Items[lstHistory.ItemIndex]);
  try
    edtDependency.Text := dependency.name;
    edtVersion.Text := dependency.version;
  finally
    dependency.Free;
  end;
end;

procedure TBEWizardForms.SaveHistoryDependency;
var
  dependency: TBEModelDependency;
begin
  dependency := GetDependency;
  try
    dependency.SaveHistory;
  finally
    dependency.Free;
  end;
end;

end.
