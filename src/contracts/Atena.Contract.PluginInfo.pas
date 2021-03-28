unit Atena.Contract.PluginInfo;

interface

type

  IAtenaPluginInfo = interface
    ['{555C909D-31FC-48A6-953D-C0B0EC0D895B}']
    function Author: string;
    function PluginName: string;
    function PluginVersion: string;
  end;

implementation

end.
