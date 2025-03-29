unit Log4D.Provider.Http;

interface

uses
  System.SysUtils,
  IdHTTP,
  IdSSLOpenSSL,
  IdGlobal,
  Log4D,
  Log4D.Provider,
  Log4D.Provider.Param.Http, System.Classes;

type
  TLog4DProviderHttp = class(TInterfacedObject,ILog4DProvider)
  private
    FParams: TLog4DProviderParamHttp;
    function GetMessageStream(AMessage: string): TStringStream;
  public
    constructor Create(AParams: TLog4DProviderParamHttp);
    procedure Send(AMessage: string);
  end;

implementation

{ TLog4DProviderTextFile }

constructor TLog4DProviderHttp.Create(AParams: TLog4DProviderParamHttp);
begin
  FParams := AParams;
end;

function TLog4DProviderHttp.GetMessageStream(AMessage: string): TStringStream;
begin
  Result := TStringStream.Create('{"message":"'+ AMessage + '"}');
  Result.Position := 0;
end;

procedure TLog4DProviderHttp.Send(AMessage: string);
var
  LHttp: TIdHTTP;
  LMessageStream: TStringStream;
begin
  try
    LHttp := TIdHTTP.Create(nil);
    try
      LMessageStream := GetMessageStream(AMessage);
      try
        if FParams.Secure then
          LHttp.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(LHttp);

        LHttp.Post(FParams.Endpoint, LMessageStream);
      finally
        LMessageStream.Free;
      end;
    finally
      LHttp.Free;
    end;
  except on e:Exception do
    TLog4D.Error(e.Message,false);
  end;
end;

end.
