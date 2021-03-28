unit Atena.Contract.PluginManager;

interface

uses
  Atena.Types, Atena.Concret.PluginList;

type

  IAtenaPluginManager<I: IInterface> = interface
    ['{8AAE14EC-0209-4F0D-AA8F-E18B8F52079B}']
    procedure SetOnLoadingPlugin(const Value: TLoadingPluginEvent);
    function GetOnLoadingPlugin: TLoadingPluginEvent;
    procedure DoLoadingPlugin(AFileName, APluginName, AAuthor: string);
    function PluginList: TAtenaDLLPluginList;
    function LoadPlugin(APlugin: string): integer;
    procedure LoadPluginPath;
    property OnLoadingPlugin: TLoadingPluginEvent read GetOnLoadingPlugin write SetOnLoadingPlugin;

  end;

implementation

end.
