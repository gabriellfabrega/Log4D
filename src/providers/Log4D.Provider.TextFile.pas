unit Log4D.Provider.TextFile;

interface

uses
  System.IOUtils,
  System.SysUtils,
  Log4D.Provider,
  Log4D.Provider.Param.Files;

type
  TLog4DProviderTextFile = class(TInterfacedObject,ILog4DProvider)
  private
    FParams: TLog4DProviderParamFiles;
  public
    constructor Create(AParams: TLog4DProviderParamFiles);
    procedure Send(AMessage: string);
  end;

implementation

{ TLog4DProviderTextFile }

constructor TLog4DProviderTextFile.Create(AParams: TLog4DProviderParamFiles);
begin
  FParams := AParams;
end;

procedure TLog4DProviderTextFile.Send(AMessage: string);
var
  LLogFile: TextFile;
  LFileName: string;
begin
  LFileName:= TPath.Combine(FParams.Path,FParams.FileName);
  AssignFile(LLogFile, LFileName);
  try
    if FileExists(LFileName) then
      Append(LLogFile)
    else
      Rewrite(LLogFile);

    Writeln(LLogFile, AMessage);
  finally
    CloseFile(LLogFile);
  end;
end;

end.
