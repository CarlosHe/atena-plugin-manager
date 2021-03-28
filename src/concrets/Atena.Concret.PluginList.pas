unit Atena.Concret.PluginList;

interface

uses
  System.Generics.Collections, Atena.Concret.DLLPlugin,
  Atena.Contract.PluginItems, System.SysUtils;

type

  TAtenaDLLPluginList = class
  private
    { private declarations }
    FAtenaDLLPluginList: TObjectList<TAtenaDLLPlugin>;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; virtual;
    destructor Destroy; override;
    function Add(AHandle: THandle; AFileName: String; APlugins: IAtenaPluginItems): integer; overload;
    function Count: integer;
    function GetItem(Index: integer): IAtenaPluginItems;
    function Find(APlugin: string): TAtenaDLLPlugin;
    function IndexOf(APlugin: string): integer;
  end;

implementation

{ TDLLPluginManager }

function TAtenaDLLPluginList.Add(AHandle: THandle; AFileName: String; APlugins: IAtenaPluginItems): integer;
var
  LAtenaDLLPlugin: TAtenaDLLPlugin;
begin
  LAtenaDLLPlugin := TAtenaDLLPlugin.Create;
  LAtenaDLLPlugin.Handle := AHandle;
  LAtenaDLLPlugin.Filename := AFileName;
  LAtenaDLLPlugin.Plugin := APlugins;
  FAtenaDLLPluginList.Add(LAtenaDLLPlugin);
  Result := FAtenaDLLPluginList.Count - 1;
end;

function TAtenaDLLPluginList.Count: integer;
begin
  Result := FAtenaDLLPluginList.Count;
end;

constructor TAtenaDLLPluginList.Create;
begin
  FAtenaDLLPluginList := TObjectList<TAtenaDLLPlugin>.Create;
end;

destructor TAtenaDLLPluginList.Destroy;
begin
  FAtenaDLLPluginList.Clear;
  FreeAndNil(FAtenaDLLPluginList);
  inherited;
end;

function TAtenaDLLPluginList.Find(APlugin: string): TAtenaDLLPlugin;
var
  I: integer;
begin
  Result := nil;
  I := IndexOf(APlugin);
  if I >= 0 then
    Result := FAtenaDLLPluginList.Items[I];
end;

function TAtenaDLLPluginList.GetItem(Index: integer): IAtenaPluginItems;
begin
  Result := FAtenaDLLPluginList.Items[Index].Plugin;
end;

function TAtenaDLLPluginList.IndexOf(APlugin: string): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to FAtenaDLLPluginList.Count - 1 do
    if sametext(APlugin, FAtenaDLLPluginList.Items[I].Filename) then
    begin
      Result := I;
      exit;
    end;
end;

end.
