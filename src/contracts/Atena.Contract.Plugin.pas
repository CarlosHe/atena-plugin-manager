unit Atena.Contract.Plugin;

interface

uses
  Atena.Contract.PluginInfo;

type
  IAtenaPlugin = interface
    ['{36027C2C-3D37-4EC1-BCAE-5A366AABB8E1}']
    function Info: IAtenaPluginInfo;
    procedure DoStart(APluginApplication: IInterface);
  end;

implementation

end.
