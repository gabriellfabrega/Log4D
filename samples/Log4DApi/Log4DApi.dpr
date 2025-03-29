program Log4DApi;

uses
  Vcl.Forms,
  Log4DApi.View.Principal in 'Log4DApi.View.Principal.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
