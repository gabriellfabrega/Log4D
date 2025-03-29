program Log4DSample;

uses
  Vcl.Forms,
  Log4DSample.View.Principal in 'Log4DSample.View.Principal.pas' {ViewPrincipal},
  Log4DSample.Factory.Providers in 'Log4DSample.Factory.Providers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
