unit Log4D.Provider.Sqlite;

interface

uses
  System.SysUtils,
  System.IOUtils,
  Log4D.Provider,
  Log4D.Provider.Param.Files,
  Log4D,
  FireDAC.Comp.Client,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Comp.UI;


type
  TLog4DProviderSqlite = class(TInterfacedObject,ILog4DProvider)
  private
    FConnection: TFDConnection;
    FCursor: TFDGUIxWaitCursor;
    FParams: TLog4DProviderParamFiles;
    procedure CreateDatabase;
    procedure CreateLogTable;
  public
    constructor Create(AParams: TLog4DProviderParamFiles);
    destructor Destroy; override;
    procedure Send(AMessage: string);
  end;

implementation

{ TLog4DProviderTextFile }

constructor TLog4DProviderSqlite.Create(AParams: TLog4DProviderParamFiles);
begin
  FParams := AParams;
  FCursor := TFDGUIxWaitCursor.Create(nil);
end;

procedure TLog4DProviderSqlite.Send(AMessage: string);
begin
  FConnection := TFDConnection.Create(nil);
  try
    try
      CreateDatabase;
      FConnection.ExecSQL(
        'INSERT INTO application_log (message) ' +
        'VALUES (' + QuotedStr(AMessage) + ')');
    except on e:Exception do
      TLog4D.Error(e.Message,false);
    end;
  finally
    FConnection.Free;
  end;
end;

procedure TLog4DProviderSqlite.CreateDatabase;
var
  LDatabasePath: String;
begin
  LDatabasePath := TPath.Combine(FParams.Path,FParams.FileName);
  FConnection.DriverName := 'SQLite';
  FConnection.Params.Values['Database'] := LDatabasePath;

  if not FileExists(LDatabasePath) then
  begin
    FConnection.Params.Values['OpenMode'] := 'CreateUTF8';
    FConnection.Connected := True;
    FConnection.Connected := False;
    FConnection.Params.Values['OpenMode'] := 'ReadWrite';
  end;

  FConnection.Params.Values['LockingMode'] := 'Normal';
  FConnection.Params.Values['Synchronous'] := 'Normal';
  FConnection.Params.Values['JournalMode'] := 'WAL';
  FConnection.Params.Values['StringFormat'] := 'Unicode';

  FConnection.Connected := True;
  CreateLogTable;
end;

procedure TLog4DProviderSqlite.CreateLogTable;
const
  SQL_CREATE_TABLE =
    'CREATE TABLE IF NOT EXISTS application_log (' +
    '  id INTEGER PRIMARY KEY AUTOINCREMENT,' +
    '  log_time DATETIME DEFAULT CURRENT_TIMESTAMP,' +
    '  message TEXT NOT NULL,' +
    '  source TEXT,' +
    '  user TEXT' +
    ')';
begin
  FConnection.ExecSQL(SQL_CREATE_TABLE);

  // Cria índice para melhor performance em consultas por data
  FConnection.ExecSQL('CREATE INDEX IF NOT EXISTS idx_log_time ON application_log(log_time)');
end;

destructor TLog4DProviderSqlite.Destroy;
begin
  FCursor.Free;
  inherited;
end;

end.
