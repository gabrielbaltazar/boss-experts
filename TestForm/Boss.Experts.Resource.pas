unit Boss.Experts.Resource;

interface

uses
  Vcl.ExtCtrls,

  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.Types;

type
  TServiceUtils = class
    private

    public
      class procedure ResourceImage(AResource: string; AImage: TImage);
  end;

implementation

{ TServiceUtils }

class procedure TServiceUtils.ResourceImage(AResource: string; AImage: TImage);
var
  Resource : TResourceStream;
begin
  Resource := TResourceStream.Create(HInstance, AResource, RT_RCDATA);
  try
    AImage.Picture.LoadFromStream(Resource);
  finally
    Resource.Free;
  end;
end;

end.