program Estoque;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {formPrincipal},
  unitCadProdutos in 'unitCadProdutos.pas' {formCadProdutos},
  unitCadMovimentacao in 'unitCadMovimentacao.pas' {formCadMovimentacoes},
  unitConsMovimentacao in 'unitConsMovimentacao.pas' {formConsMovimentacao},
  unitDM in 'unitDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TformCadProdutos, formCadProdutos);
  Application.CreateForm(TformCadMovimentacoes, formCadMovimentacoes);
  Application.CreateForm(TformConsMovimentacao, formConsMovimentacao);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
