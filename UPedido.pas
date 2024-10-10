unit UPedido;

interface

uses
  System.SysUtils, UProduto, System.Generics.Collections;

type
  IPedido = interface
    ['{3812BB54-F215-4949-94A6-5E253E8F3074}']
    procedure AdicionarProduto(AProduto: IProduto);
    procedure RemoverProduto(AProduto: IProduto);
    function CalcularTotal: Double;
  end;

  TPedido = class(TInterfacedObject, IPedido)
  private
    FProdutos: TList<IProduto>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarProduto(AProduto: IProduto);
    procedure RemoverProduto(AProduto: IProduto);
    function CalcularTotal: Double;
    property Produtos: TList<IProduto> read FProdutos;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  FProdutos := TList<IProduto>.Create;
end;

destructor TPedido.Destroy;
begin
  FreeAndNil(FProdutos);
  inherited;
end;

procedure TPedido.AdicionarProduto(AProduto: IProduto);
begin
  FProdutos.Add(AProduto);
end;

function TPedido.CalcularTotal: Double;
var
  Total: Double;
  Produto: IProduto;
begin
  Total := 0;
  for Produto in FProdutos do
  begin
    Total := Total + Produto.GetTotal;
  end;
  Result := Total;
end;

procedure TPedido.RemoverProduto(AProduto: IProduto);
begin
  FProdutos.Remove(AProduto);
end;

end.
