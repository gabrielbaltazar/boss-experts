unit BE.Wizard.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  BE.Commands.Interfaces, Vcl.ComCtrls;

type
  TBEWizardForms = class(TForm)
    pnlBottom: TPanel;
    btnInstall: TButton;
    btnUpdate: TButton;
    btnUninstall: TButton;
    btnInit: TButton;
    Label3: TLabel;
    edtHostLogin: TComboBox;
    Label1: TLabel;
    edtDependency: TEdit;
    Label2: TLabel;
    edtVersion: TEdit;
    lstHistory: TListBox;
    btnLogin: TButton;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
    procedure btnInstallClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnUninstallClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure lstHistoryClick(Sender: TObject);
  private
    FBossCommand: IBECommands;
    { Private declarations }
  public
    constructor create(AOwner: TComponent; BossCommand: IBECommands); reintroduce;
    { Public declarations }
  end;

var
  BEWizardForms: TBEWizardForms;

implementation

{$R *.dfm}

uses
  ToolsAPI;

procedure TBEWizardForms.btnInitClick(Sender: TObject);
begin
  FBossCommand.Init;
end;

procedure TBEWizardForms.btnInstallClick(Sender: TObject);
begin
  FBossCommand.Install(edtDependency.Text, edtVersion.Text);
end;

procedure TBEWizardForms.btnLoginClick(Sender: TObject);
begin
  FBossCommand.Login(edtHostLogin.Text);
end;

procedure TBEWizardForms.btnUninstallClick(Sender: TObject);
begin
  FBossCommand.Uninstall(edtDependency.Text);
end;

procedure TBEWizardForms.btnUpdateClick(Sender: TObject);
begin
  FBossCommand.Update(edtDependency.Text, edtVersion.Text);
end;

constructor TBEWizardForms.create(AOwner: TComponent; BossCommand: IBECommands);
begin
  inherited create(AOwner);
  FBossCommand := BossCommand;
end;

procedure TBEWizardForms.FormShow(Sender: TObject);
var
  theme: IOTAIDEThemingServices250;
  i: Integer;
begin
  theme := (BorlandIDEServices as IOTAIDEThemingServices250);
  theme.RegisterFormClass(TBEWizardForms);

  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if Components[i] is TLabel then
      theme.ApplyTheme(TLabel(Components[i]));

    if Components[i] is TComboBox then
      theme.ApplyTheme(TComboBox(Components[i]));
  end;
end;

procedure TBEWizardForms.lstHistoryClick(Sender: TObject);
begin
  edtDependency.Text := lstHistory.Items[lstHistory.ItemIndex];
end;

end.
