program Client;

uses
  Vcl.Forms,
  operatorEntry in 'operatorEntry.pas' {TOperatorEntry},
  mainWindow in 'mainWindow.pas' {fmMainWindow},
  orderInfo in 'orderInfo.pas' {TOrderInfo},
  dm in 'dm.pas' {DataModule1: TDataModule},
  errorLogin in 'errorLogin.pas' {fmErrorLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTOperatorEntry, TOperatorEntry);
  Application.CreateForm(TfmMainWindow, fmMainWindow);
  Application.CreateForm(TTOrderInfo, TOrderInfo);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfmErrorLogin, fmErrorLogin);
  Application.Run;
end.
