unit cantAddPlumberFormPas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TcantAddPlumberForm = class(TForm)
    errorLabelcant: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cantAddPlumberForm: TcantAddPlumberForm;

implementation

{$R *.dfm}


procedure TcantAddPlumberForm.Button1Click(Sender: TObject);
begin
  cantAddPlumberForm.Close;
end;

end.
