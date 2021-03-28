unit Atena.Manager;

interface

uses
{$IFDEF MSWINDOWS} WinAPI.Windows, {$ENDIF}System.SysUtils, System.Classes,
  System.IOUtils, System.Generics.Collections, Atena.Contract.PluginItems,
  Atena.Concret.DLLPlugin, Atena.Contract.PluginInfo,
  Atena.Contract.PluginManager, Atena.Concret.PluginList, Atena.Types,
  Atena.Contract.RegisterPlugin, Atena.RegisterPlugin;

type

  TAtenaPluginManager<I: IInterface> = class(TInterfacedObject, IAtenaPluginManager<I>)
  private
    { private declarations }
    FAtenaDLLPluginList: TAtenaDLLPluginList;
    FOnLoadingPlugin: TLoadingPluginEvent;
    FConcret: I;
    class var FDefaultAtenaPluginManager: TAtenaPluginManager<I>;
    procedure SetOnLoadingPlugin(const Value: TLoadingPluginEvent);
    function GetOnLoadingPlugin: TLoadingPluginEvent;
  protected
    { protected declarations }
    procedure DoLoadingPlugin(AFileName, APluginName, AAuthor: string);
  public
    { public declarations }
    constructor Create(AConcret: I); virtual;
    destructor Destroy; override;
    function PluginList: TAtenaDLLPluginList;
    function LoadPlugin(APlugin: string): integer;
    procedure LoadPluginPath;
    property OnLoadingPlugin: TLoadingPluginEvent read GetOnLoadingPlugin write SetOnLoadingPlugin;
    class function GetDefaultAtenaPluginManager(AConcret: I): TAtenaPluginManager<I>; static;
  end;

implementation

{ TAtenaPluginManager }

constructor TAtenaPluginManager<I>.Create(AConcret: I);
begin
  FConcret := AConcret;
  FAtenaDLLPluginList := TAtenaDLLPluginList.Create;
end;

destructor TAtenaPluginManager<I>.Destroy;
begin
  FreeAndNil(FAtenaDLLPluginList);
  inherited;
end;

procedure TAtenaPluginManager<I>.DoLoadingPlugin(AFileName, APluginName, AAuthor: string);
begin
  if assigned(FOnLoadingPlugin) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnLoadingPlugin(AFileName, APluginName, AAuthor);
      end);
end;

class function TAtenaPluginManager<I>.GetDefaultAtenaPluginManager(AConcret: I): TAtenaPluginManager<I>;
begin
  if FDefaultAtenaPluginManager = nil then
    FDefaultAtenaPluginManager := TAtenaPluginManager<I>.Create(AConcret);
  Result := FDefaultAtenaPluginManager;
end;

function TAtenaPluginManager<I>.GetOnLoadingPlugin: TLoadingPluginEvent;
begin
  Result := FOnLoadingPlugin;
end;

function TAtenaPluginManager<I>.LoadPlugin(APlugin: string): integer;
var
  LoadPluginFunction: function(APluginApplication: I): IAtenaPluginItems;
  LPluginHandle: THandle;
  I: integer;
  LPluginItems: IAtenaPluginItems;
begin
  Result := -1;
  LPluginHandle := LoadLibrary(PWideChar(APlugin));
  if LPluginHandle > 0 then
  begin
    try
      @LoadPluginFunction := GetProcAddress(LPluginHandle, 'LoadPlugin');
      if assigned(LoadPluginFunction) then
      begin
        LPluginItems := LoadPluginFunction(FConcret);
        Result := FAtenaDLLPluginList.Add(LPluginHandle, APlugin, LPluginItems);
        for I := 0 to LPluginItems.Count - 1 do
        begin
          if Supports(LPluginItems.Item(I).Info, IAtenaPluginInfo) then
          begin
            if assigned(LPluginItems.Item(I).Info) then
              DoLoadingPlugin(APlugin, LPluginItems.Item(I).Info.PluginName, LPluginItems.Item(I).Info.Author);
          end
          else
            DoLoadingPlugin(APlugin, 'Undefined', 'Undefined');
        end;
      end
      else
        raise Exception.Create('Plugin error');
    except
      FreeLibrary(LPluginHandle);
      // raise;
    end;
  end;
end;

procedure TAtenaPluginManager<I>.LoadPluginPath;
var
  LFileMask: string;
  LSearchRec: TSearchRec;
  LPath: string;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'plugins';
  LFileMask := TPath.Combine(LPath, '*.dll');
  ForceDirectories(ExtractFileDir(LFileMask));
  if FindFirst(LFileMask, faAnyFile, LSearchRec) = 0 then
    try
      repeat
        LoadPlugin(TPath.Combine(LPath, LSearchRec.Name));
      until FindNext(LSearchRec) <> 0;
    finally
      findClose(LSearchRec);
    end;
end;

function TAtenaPluginManager<I>.PluginList: TAtenaDLLPluginList;
begin
  Result := FAtenaDLLPluginList;
end;

procedure TAtenaPluginManager<I>.SetOnLoadingPlugin(const Value: TLoadingPluginEvent);
begin
  FOnLoadingPlugin := Value;
end;

end.
