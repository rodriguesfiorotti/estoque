unit unitConsMovimentacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TformConsMovimentacao = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    txtDataInicial: TMaskEdit;
    txtDataFinal: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label4: TLabel;
    lblTotal: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formConsMovimentacao: TformConsMovimentacao;

implementation

{$R *.dfm}

uses unitDM;

procedure TformConsMovimentacao.Button1Click(Sender: TObject);
var
  DataInicial, DataFinal : TDateTime;

begin
  DM.sqlMovimentacoes.Close;
  DM.sqlMovProdutos.Close;
  lblTotal.Caption := '0';
  DM.sqlMovimentacoes.SQL.Clear;

  //Verifica se as datas estão vazias:
  if (AnsiSameText(txtDataInicial.Text, '  /  /    ') and AnsiSameText(txtDataFinal.Text, '  /  /    ')) then
  begin
    DM.sqlMovimentacoes.SQL.Text := 'SELECT * FROM movimentacoes';
  end

  // Verifica se as datas estão no formato esperado
  else if (TryStrToDate(txtDataInicial.Text, DataInicial) and TryStrToDate(txtDataFinal.Text, DataFinal)) then
  begin
    // Se as datas são válidas, realiza a consulta SQL
    DM.sqlMovimentacoes.SQL.Text := 'SELECT * FROM movimentacoes WHERE Date(dataHora) BETWEEN :PDataInicial AND :pDataFinal';
    DM.sqlMovimentacoes.ParamByName('pDataInicial').Value := FormatDateTime('yyyy/mm/dd', DataInicial);
    DM.sqlMovimentacoes.ParamByName('pDataFinal').Value := FormatDateTime('yyyy/mm/dd', DataFinal);
  end

  else
  begin
    // Se as datas não são válidas, exibe uma mensagem de erro
    ShowMessage('Formato de datas incorretas. Insira datas válidas no formato: dd/mm/aaaa');
    DM.sqlMovimentacoes.SQL.Text := 'SELECT * FROM movimentacoes';
  end;

  DM.sqlMovimentacoes.Open;
  DM.sqlMovProdutos.Open;

  lblTotal.Caption := IntToStr(DM.sqlMovimentacoes.RecordCount);
end;






procedure TformConsMovimentacao.FormShow(Sender: TObject);
begin
  DM.sqlMovimentacoes.Refresh;
  DM.sqlMovProdutos.Refresh;

  lblTotal.Caption := IntToStr(DM.sqlMovimentacoes.RecordCount);
end;

end.
