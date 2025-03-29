unit Log4D.Provider;

interface

type
  ILog4DProvider = interface
    ['{430EC143-E250-4803-8CEF-17FB0D8AC947}']
    procedure Send(AMessage: string);
  end;

implementation

end.
