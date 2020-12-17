unit mainWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTMainWindow = class(TForm)
    Panel1: TPanel;
    btnAddOrder: TButton;
    btnExit: TButton;
    Panel2: TPanel;
    procedure btnAddOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TMainWindow: TTMainWindow;

implementation

{$R *.dfm}

uses orderInfo;

procedure TTMainWindow.btnAddOrderClick(Sender: TObject);
begin
 TOrderInfo:=TTOrderInfo.Create(Application);
 TOrderInfo.ShowModal;
 TOrderInfo.Release;
end;

end.
