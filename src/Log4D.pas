unit Log4D;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Classes,
  Log4D.Provider;

type
  TLog4D = class
  private
    class var FInstance: TLog4D;
    class var FMemo: TStrings;
    class var FProviders: TList<ILog4DProvider>;
    class procedure Log(AMessage: string; AUseProviders: Boolean);
    constructor Create;
    destructor Destroy; override;
  public

    {$IFNDEF CONSOLE}
      class function Output(AMemo: TStrings): TLog4D;
    {$ENDIF}

    class function UseProvider(AProvider: ILog4DProvider): TLog4D;
    class procedure Trace(AMessage: string; const AUseProviders: Boolean = true);
    class procedure Debug(AMessage: string; const AUseProviders: Boolean = true);
    class procedure Info(AMessage: string; const AUseProviders: Boolean = true);
    class procedure Warn(AMessage: string; const AUseProviders: Boolean = true);
    class procedure Error(AMessage: string; const AUseProviders: Boolean = true);
  end;

implementation

{ TLog4D }

constructor TLog4D.Create;
begin
  FProviders := TList<ILog4DProvider>.Create;
end;

destructor TLog4D.Destroy;
begin
  FreeAndNIl(FProviders);
  inherited;
end;

class procedure TLog4D.Debug(AMessage: string; const AUseProviders: Boolean = true);
begin
  Log('[DEBUG] - ' + AMessage, AUseProviders);
end;

class procedure TLog4D.Error(AMessage: string; const AUseProviders: Boolean = true);
begin
  Log('[ERROR] - ' + AMessage, AUseProviders);
end;

class procedure TLog4D.Info(AMessage: string; const AUseProviders: Boolean = true);
begin
  Log('[INFO] - ' + AMessage, AUseProviders);
end;

class procedure TLog4D.Trace(AMessage: string; const AUseProviders: Boolean = true);
begin
  Log('[TRACE] - ' + AMessage, AUseProviders);
end;

class procedure TLog4D.Warn(AMessage: string; const AUseProviders: Boolean = true);
begin
  Log('[WARN] - ' + AMessage, AUseProviders);
end;

class procedure TLog4D.Log(AMessage: string; AUseProviders: Boolean);
var
  LProvider: ILog4DProvider;
begin
  {$IFDEF CONSOLE}
    Writeln(AMessage);
  {$ELSE}
    if Assigned(FMemo) then
      FMemo.Add(AMessage);
  {$ENDIF}

  if AUseProviders then
    for LProvider in FProviders do
      LProvider.Send(AMessage);
end;

{$IFNDEF CONSOLE}
class function TLog4D.Output(AMemo: TStrings): TLog4D;
begin
  Result := FInstance;
  FMemo := AMemo;
end;
{$ENDIF}

class function TLog4D.UseProvider(AProvider: ILog4DProvider): TLog4D;
begin
  Result := FInstance;
  FProviders.Add(AProvider);
end;

initialization
  TLog4D.FInstance := TLog4D.Create;

finalization
  FreeAndNil(TLog4D.FInstance);

end.
