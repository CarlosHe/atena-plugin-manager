unit Atena.Concret.DLLPlugin;

interface

uses
  Atena.Contract.PluginItems, Winapi.Windows;

type

  TAtenaDLLPlugin = class
  public
    Handle: THandle;
    Plugin: IAtenaPluginItems;
    Filename: string;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TAtenaDLLPlugin.Create;
begin
  Handle := 0;
end;

destructor TAtenaDLLPlugin.Destroy;
var
  UnloadPluginProcedure: procedure;
begin
  if Handle > 0 then
    try
      @UnloadPluginProcedure := GetProcAddress(Handle, 'UnloadPlugin');
      if assigned(UnloadPluginProcedure) then
        UnloadPluginProcedure;
      Plugin := nil;
      Sleep(10);
      FreeLibrary(Handle);
    except
    end;
  inherited;
end;

end.
