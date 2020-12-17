unit mainWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TfmMainWindow = class(TForm)
    Panel1: TPanel;
    btnAddOrder: TButton;
    btnExit: TButton;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid1: TDBGrid;
    procedure btnAddOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMainWindow: TfmMainWindow;

implementation

{$R *.dfm}

uses orderInfo, dm;

procedure TfmMainWindow.btnAddOrderClick(Sender: TObject);
begin
 TOrderInfo:=TTOrderInfo.Create(Application);
 TOrderInfo.ShowModal;
 TOrderInfo.Release;
end;

end.
