unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls,
  UPedido, UProduto, Data.DB, Vcl.DBGrids, Datasnap.DBClient;

type
  TPrincipal = class(TForm)
    EdtNome: TLabeledEdit;
    EdtPreco: TLabeledEdit;
    BtnInserir: TBitBtn;
    EdtTotal: TLabeledEdit;
    BtnRemover: TBitBtn;
    EdtDesconto: TLabeledEdit;
    SgrProdutos: TStringGrid;
    procedure BtnInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRemoverClick(Sender: TObject);
    procedure EdtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDescontoKeyPress(Sender: TObject; var Key: Char);
  private
    FPedido: IPedido;
    procedure AtualizarValorTotal;
    procedure ConfigurarGridProdutos;
    procedure InserirProduto(const ANome: string; const APreco, ADesconto: Double);
    procedure LimparCampos;
    procedure RemoverProduto;
    procedure RemoverLinhaGrid(const ALinha: Integer);
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

procedure TPrincipal.AtualizarValorTotal;
begin
  EdtTotal.Text := FormatFloat('###,##0.00', FPedido.CalcularTotal);
end;

procedure TPrincipal.BtnInserirClick(Sender: TObject);
begin
  InserirProduto(EdtNome.Text, StrToFloat(EdtPreco.Text), StrToFloat(EdtDesconto.Text));
  AtualizarValorTotal;
  LimparCampos;
end;

procedure TPrincipal.BtnRemoverClick(Sender: TObject);
begin
  RemoverProduto;
end;

procedure TPrincipal.ConfigurarGridProdutos;
begin
  SgrProdutos.Cells[0, 0] := 'Nome';
  SgrProdutos.Cells[1, 0] := 'Pre�o';
  SgrProdutos.Cells[2, 0] := 'Desconto (R$)';

  SgrProdutos.ColWidths[0] := 200;
  SgrProdutos.ColWidths[1] := 90;
  SgrProdutos.ColWidths[2] := 90;
end;

procedure TPrincipal.EdtDescontoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
  end;
end;

procedure TPrincipal.EdtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
  end;
end;

procedure TPrincipal.FormCreate(Sender: TObject);
begin
  FPedido := TPedido.Create;
  ConfigurarGridProdutos;
end;

procedure TPrincipal.InserirProduto(const ANome: string; const APreco,
  ADesconto: Double);
var
  Produto: TProduto;
  Desconto: Double;
  NovaLinhaGrid: Integer;
begin
  try
    Produto := TProduto.Create(ANome, APreco);

    if TryStrToFloat(EdtDesconto.Text, Desconto) then
      Produto.AplicarDesconto(Desconto);

    FPedido.AdicionarProduto(Produto);

    SgrProdutos.RowCount := SgrProdutos.RowCount + 1;
    NovaLinhaGrid := SgrProdutos.RowCount - 1;

    SgrProdutos.Rows[NovaLinhaGrid].AddObject(Produto.GetNome, Produto);

    SgrProdutos.Cells[0, NovaLinhaGrid] := ANome;
    SgrProdutos.Cells[1, NovaLinhaGrid] := FormatFloat('###,##0.00', Produto.GetPreco);
    SgrProdutos.Cells[2, NovaLinhaGrid] := FormatFloat('###,##0.00', Produto.GetDesconto);

    SgrProdutos.Row := NovaLinhaGrid;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TPrincipal.LimparCampos;
begin
  EdtNome.Clear;
  EdtPreco.Clear;
  EdtDesconto.Clear;
end;

procedure TPrincipal.RemoverLinhaGrid(const ALinha: Integer);
var
  I: Integer;
begin
  SgrProdutos.Row := ALinha;

  if SgrProdutos.Row = SgrProdutos.RowCount -1 then
  begin
    SgrProdutos.RowCount := SgrProdutos.RowCount -1;
    Exit;
  end;

  for I := ALinha to SgrProdutos.RowCount -1 do
  begin
    SgrProdutos.Rows[I] := SgrProdutos.Rows[I + 1];
  end;

  SgrProdutos.RowCount := SgrProdutos.RowCount -1;
end;

procedure TPrincipal.RemoverProduto;
var
  Produto: IProduto;
begin
  Produto := TProduto(SgrProdutos.Objects[0, SgrProdutos.Row]);
  FPedido.RemoverProduto(Produto);
  RemoverLinhaGrid(SgrProdutos.Row);
  AtualizarValorTotal;
end;

end.
