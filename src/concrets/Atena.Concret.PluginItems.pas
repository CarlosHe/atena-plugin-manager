unit Atena.Concret.PluginItems;

interface

uses
  Atena.Contract.PluginItems, Atena.Contract.Plugin, System.Classes;

type

  TAtenaPluginItems = class(TInterfacedObject, IAtenaPluginItems)
  private
    { private declarations }
    FAtenaPluginList: TInterfaceList;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; virtual;
    destructor Destroy; override;
    function Count: integer;
    function Item(Index: integer): IAtenaPlugin;
    procedure Add(APlugin: IAtenaPlugin);
    function Remove(const Value: IAtenaPlugin): integer;
    procedure Delete(Index: integer);
  end;

implementation

{ TAtenaPluginItems }

procedure TAtenaPluginItems.Add(APlugin: IAtenaPlugin);
begin
  FAtenaPluginList.Add(APlugin);
end;

function TAtenaPluginItems.Count: integer;
begin
  Result := FAtenaPluginList.Count;
end;

constructor TAtenaPluginItems.Create;
begin
  FAtenaPluginList := TInterfaceList.Create;
end;

procedure TAtenaPluginItems.Delete(Index: integer);
begin
  FAtenaPluginList.Delete(Index);
end;

destructor TAtenaPluginItems.Destroy;
begin

  inherited;
end;

function TAtenaPluginItems.Item(Index: integer): IAtenaPlugin;
begin
  Result := FAtenaPluginList.Items[Index] as IAtenaPlugin;
end;

function TAtenaPluginItems.Remove(const Value: IAtenaPlugin): integer;
begin
  Result:=FAtenaPluginList.Remove(Value);
end;

end.
