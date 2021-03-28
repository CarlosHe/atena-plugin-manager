unit Atena.Concret.Plugin;

interface

uses
  Atena.Contract.Plugin, Atena.Contract.PluginInfo,
  Atena.Concret.PluginInfo;

type

  TAtenaPlugin = class(TInterfacedObject, IAtenaPlugin)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; virtual; abstract;
    function Info: IAtenaPluginInfo; virtual; abstract;
    procedure DoStart(APluginApplication: IInterface); virtual; abstract;
  end;

implementation



end.
