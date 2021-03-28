unit Atena.RegisterPlugin;

interface

uses System.SysUtils, Atena.Contract.PluginItems, Atena.Contract.Plugin,
  Atena.Concret.PluginItems, Atena.Contract.RegisterPlugin;

type
  TAtenaRegisterPlugin = class(TInterfacedObject, IAtenaRegisterPlugin)
  private
    { private declarations }
    FAtenaPluginItems: IAtenaPluginItems;
    class var FDefaultAtenaRegisterPlugin: IAtenaRegisterPlugin;
    class function GetDefaultAtenaRegisterPlugin: IAtenaRegisterPlugin; static;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; virtual;
    destructor Destroy; override;
    procedure RegisterPlugin(APlugin: IAtenaPlugin);
    function UnRegisterPlugin(APlugin: IAtenaPlugin): Integer;
    function PluginItems: IAtenaPluginItems;
    class property DefaultAtenaRegisterPlugin: IAtenaRegisterPlugin read GetDefaultAtenaRegisterPlugin;
  end;

implementation

{ TRegisterPlugin }

constructor TAtenaRegisterPlugin.Create;
begin
  FAtenaPluginItems := TAtenaPluginItems.Create;
end;

destructor TAtenaRegisterPlugin.Destroy;
var
  I: Integer;
begin
  while FAtenaPluginItems.Count > 0 do
    FAtenaPluginItems.Delete(0);
  FAtenaPluginItems := nil;
  inherited;
end;

class function TAtenaRegisterPlugin.GetDefaultAtenaRegisterPlugin: IAtenaRegisterPlugin;
begin
  if FDefaultAtenaRegisterPlugin = nil then
    FDefaultAtenaRegisterPlugin := TAtenaRegisterPlugin.Create;
  Result := FDefaultAtenaRegisterPlugin;
end;

function TAtenaRegisterPlugin.PluginItems: IAtenaPluginItems;
begin
  Result := FAtenaPluginItems;
end;

procedure TAtenaRegisterPlugin.RegisterPlugin(APlugin: IAtenaPlugin);
begin
  PluginItems.Add(APlugin);
end;

function TAtenaRegisterPlugin.UnRegisterPlugin(APlugin: IAtenaPlugin): Integer;
begin
  Result := 0;
  if Assigned(FAtenaPluginItems) then
    Result := PluginItems.Remove(APlugin)
end;

end.
