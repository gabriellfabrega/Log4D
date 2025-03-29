unit Log4D.Provider.Param.Http;

interface

uses
  System.Generics.Collections;

type
  TLog4DProviderParamHttp = record
    Endpoint: string;
    Secure: Boolean;
    Headers: TDictionary<string,string>;
  end;

implementation

end.
