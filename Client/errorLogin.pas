unit errorLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmErrorLogin = class(TForm)
    lError: TLabel;
    btnErrorLogin: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btnErrorLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmErrorLogin: TfmErrorLogin;

implementation

{$R *.dfm}

uses dm;

procedure TfmErrorLogin.btnErrorLoginClick(Sender: TObject);
begin
close;
end;

procedure TfmErrorLogin.FormActivate(Sender: TObject);
begin

lError.Caption:='Неправильный логин или пароль';

end;

end.
