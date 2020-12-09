program Client;

uses
  Vcl.Forms,
  operatorEntry in 'operatorEntry.pas' {TOperatorEntry},
  mainWindow in 'mainWindow.pas' {TMainWindow},
  orderInfo in 'orderInfo.pas' {TOrderInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTOperatorEntry, TOperatorEntry);
  Application.CreateForm(TTMainWindow, TMainWindow);
  Application.CreateForm(TTOrderInfo, TOrderInfo);
  Application.Run;
end.
