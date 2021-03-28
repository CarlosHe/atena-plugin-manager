unit Atena.Contract.PluginItems;

interface

uses
  Atena.Contract.Plugin;

type
  IAtenaPluginItems = interface
    ['{D2DFDF6F-5807-4EDC-A463-9F70815ABAE1}']
    function Count: integer;
    function Item(Index: integer): IAtenaPlugin;
    procedure Add(APlugin: IAtenaPlugin);
    function Remove(const Value: IAtenaPlugin): integer;
    procedure Delete(Index: integer);
  end;

implementation

end.
