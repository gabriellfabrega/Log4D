unit Log4DApi.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TViewPrincipal = class(TForm)
    meLogs: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

uses
  Horse, Horse.Jhonson;

{$R *.dfm}

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  THorse.Post('/logs',
    procedure(AReq: THorseRequest; ARes: THorseResponse)
    begin
      meLogs.Lines.Add(AReq.Body);
    end);

  THorse.Use(Jhonson());
  THorse.Listen(8080,
    procedure()
    begin
      meLogs.Lines.Add('Api online on port ' + THorse.Port.ToString)
    end);
end;

end.
