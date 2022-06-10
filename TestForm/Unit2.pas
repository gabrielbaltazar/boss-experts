unit Unit2;

interface

uses
  Boss.Experts.Resource,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,

  Winapi.Messages,
  Winapi.Windows, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    pnlBar: TPanel;
    Image1: TImage;
    imgInstall: TImage;
    imgUninstall: TImage;
    imgUpdate: TImage;
    imgLogin: TImage;
    imgExit: TImage;
    pnlBack: TPanel;
    pnlTop: TPanel;
    Label1: TLabel;
    Image2: TImage;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
