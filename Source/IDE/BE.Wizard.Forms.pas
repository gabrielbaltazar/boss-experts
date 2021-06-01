unit BE.Wizard.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TBEWizardForms = class(TForm)
    pnlBottom: TPanel;
    btnInstall: TButton;
    btnUpdate: TButton;
    btnLogin: TButton;
    btnUninstall: TButton;
    btnInit: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BEWizardForms: TBEWizardForms;

implementation

{$R *.dfm}

uses
  ToolsAPI,
  BE.Commands;

procedure TBEWizardForms.btnInitClick(Sender: TObject);
begin
  BE.Commands.bossInit;
end;

procedure TBEWizardForms.FormShow(Sender: TObject);
var
  theme: IOTAIDEThemingServices250;
begin
  theme := (BorlandIDEServices as IOTAIDEThemingServices250);
  theme.RegisterFormClass(TBEWizardForms);

end;

end.
