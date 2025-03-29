unit Log4DSample.Factory.Providers;

interface

uses
  System.SysUtils,
  Vcl.Forms,

  Log4D.Provider.Param.Files,
  Log4D.Provider.Param.Mqtt,
  Log4D.Provider.Param.Http,
  Log4D.Provider.Sqlite,
  Log4D.Provider.Mqtt,
  Log4D.Provider.Http,
  Log4D.Provider.TextFile;

type
  TLog4DSampleFactoryProviders = class
  public
    class function CreateHttpProvider: TLog4DProviderHttp; static;
    class function CreateMqttProvider: TLog4DProviderMqtt; static;
    class function CreateTextFileProvider: TLog4DProviderTextFile; static;
    class function CreateSqliteProvider: TLog4DProviderSqlite; static;
  end;

implementation

class function TLog4DSampleFactoryProviders.CreateSqliteProvider: TLog4DProviderSqlite;
var
  LParams: TLog4DProviderParamFiles;
begin
  LParams.Path := ExtractFilePath(Application.ExeName);
  LParams.FileName := 'log4d.db';
  Result := TLog4DProviderSqlite.Create(LParams);
end;

class function TLog4DSampleFactoryProviders.CreateHttpProvider: TLog4DProviderHttp;
var
  LParams: TLog4DProviderParamHttp;
begin
  LParams.Endpoint := 'http://127.0.0.1:8080/logs';
  LParams.Secure := false;
  Result := TLog4DProviderHttp.Create(LParams);
end;

class function TLog4DSampleFactoryProviders.CreateMqttProvider: TLog4DProviderMqtt;
var
  LParams: TLog4DProviderParamMqtt;
begin
  LParams.Broker := '127.0.0.1';
  LParams.Port := 1883;
  LParams.Topic := '/logs';
  Result := TLog4DProviderMqtt.Create(LParams);
end;

class function TLog4DSampleFactoryProviders.CreateTextFileProvider: TLog4DProviderTextFile;
var
  LParams: TLog4DProviderParamFiles;
begin
  LParams.Path := ExtractFilePath(Application.ExeName);
  LParams.FileName := 'log4d.txt';
  Result := TLog4DProviderTextFile.Create(LParams);
end;



end.
