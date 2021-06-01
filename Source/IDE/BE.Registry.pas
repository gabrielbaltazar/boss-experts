unit BE.Registry;

interface

uses
  ToolsAPI,
  BE.ContextMenu;

procedure Register;

implementation

procedure Register;
begin
  RegisterContextMenu;
end;

end.
