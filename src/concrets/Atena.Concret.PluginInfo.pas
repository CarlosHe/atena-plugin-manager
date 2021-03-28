unit Atena.Concret.PluginInfo;

interface

uses
  Atena.Contract.PluginInfo;

type

  TAtenaPluginInfo = class(TInterfacedObject, IAtenaPluginInfo)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function Author: string; virtual; abstract;
    function PluginName: string; virtual; abstract;
    function PluginVersion: string; virtual; abstract;
  end;

implementation

end.
