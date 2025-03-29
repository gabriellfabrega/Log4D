unit Log4DSample.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;


type
  TViewPrincipal = class(TForm)
    Memo1: TMemo;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

uses
  Log4D,
  Log4D.Provider.TextFile,
  Log4D.Provider.Http,
  Log4D.Provider.Mqtt,
  Log4D.Provider.Sqlite,
  Log4DSample.Factory.Providers;


{$R *.dfm}

procedure TViewPrincipal.Button2Click(Sender: TObject);
begin
  TLog4D.Debug('Exemplo Debug');
  TLog4D.Trace('Exemplo Trace');
  TLog4D.Warn('Exemplo Warn');
  TLog4D.Info('Exemplo Info');
  TLog4D.Error('Exemplo Error');
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  TLog4D
    .Output(Memo1)
//    .UseProvider(TLog4DSampleFactoryProviders.CreateTextFileProvider)
//    .UseProvider(TLog4DSampleFactoryProviders.CreateHttpProvider)
//    .UseProvider(TLog4DSampleFactoryProviders.CreateMqttProvider)
    .UseProvider(TLog4DSampleFactoryProviders.CreateSqliteProvider)
end;

end.
