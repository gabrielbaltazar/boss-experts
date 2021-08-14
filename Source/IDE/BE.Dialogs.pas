unit BE.Dialogs;

interface

uses
  System.SysUtils,
  Vcl.Controls,
  Vcl.Dialogs;

function MessageConfirmation(AMessage: String): Boolean; overload;
function MessageConfirmation(AMessage: String; const Args: array of const): Boolean; overload;

implementation

function MessageConfirmation(AMessage: String; const Args: array of const): Boolean; overload;
begin
  result := MessageConfirmation(Format(AMessage, Args));
end;

function MessageConfirmation(AMessage: String): Boolean;
begin
  result := (MessageDlg(AMessage, mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes);
end;

end.
