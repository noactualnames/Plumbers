program Client;

uses
  Vcl.Forms,
  operatorEntry in 'operatorEntry.pas' {TOperatorEntry},
  mainWindow in 'mainWindow.pas' {fmMainWindow},
  orderInfo in 'orderInfo.pas' {TOrderInfo},
  dm in 'dm.pas' {DataModule1: TDataModule},
  errorLogin in 'errorLogin.pas' {fmErrorLogin},
  addPlumbers in 'addPlumbers.pas' {addPlumber},
  cancelPlumberForm in 'cancelPlumberForm.pas' {cancelPlumbers},
  changeOrderInfopas in 'changeOrderInfopas.pas' {changeOrderForm},
  completeOrderFormPas in 'completeOrderFormPas.pas' {completeOrderForm},
  cantAddPlumberFormPas in 'cantAddPlumberFormPas.pas' {cantAddPlumberForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTOperatorEntry, TOperatorEntry);
  Application.CreateForm(TfmMainWindow, fmMainWindow);
  Application.CreateForm(TTOrderInfo, TOrderInfo);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfmErrorLogin, fmErrorLogin);
  Application.CreateForm(TaddPlumber, addPlumber);
  Application.CreateForm(TcancelPlumbers, cancelPlumbers);
  Application.CreateForm(TchangeOrderForm, changeOrderForm);
  Application.CreateForm(TcompleteOrderForm, completeOrderForm);
  Application.CreateForm(TcantAddPlumberForm, cantAddPlumberForm);
  Application.Run;
end.
