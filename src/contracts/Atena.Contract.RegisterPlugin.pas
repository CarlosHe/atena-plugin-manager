unit Atena.Contract.RegisterPlugin;

interface

uses
  Atena.Contract.Plugin, Atena.Contract.PluginItems;

type
  IAtenaRegisterPlugin = interface
    ['{B8F907E0-B8A3-4E7A-9425-92321F9D104A}']
    procedure RegisterPlugin(APlugin: IAtenaPlugin);
    function UnRegisterPlugin(APlugin: IAtenaPlugin): Integer;
    function PluginItems: IAtenaPluginItems;
  end;

implementation

end.
