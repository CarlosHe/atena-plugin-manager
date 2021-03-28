unit Atena.PluginInit;

interface

uses System.SysUtils, Atena.RegisterPlugin, Atena.Contract.PluginItems,
  Atena.Contract.RegisterPlugin;

function LoadPlugin(APluginApplication: IInterface): IAtenaPluginItems;
procedure UnloadPlugin;

var
  PluginExitProc: TProc;
  PluginEnterProc: TProc;

implementation

function LoadPlugin(APluginApplication: IInterface): IAtenaPluginItems;
var
  I: integer;
begin
  Result := TAtenaRegisterPlugin.DefaultAtenaRegisterPlugin.PluginItems;
  for I := 0 to Result.Count - 1 do
    Result.Item(I).DoStart(APluginApplication);
  if assigned(PluginEnterProc) then
    PluginEnterProc;
end;

procedure UnloadPlugin;
begin
  if assigned(PluginExitProc) then
    PluginExitProc;
end;

exports LoadPlugin, UnloadPlugin;

end.
