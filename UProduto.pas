unit UProduto;

interface

uses
  System.SysUtils;

type
  NomeInvalidoException = class(Exception);
  ValorInvalidoException = class(Exception);
  PrecentualDescontoInvalidoException = class(Exception);

  IProduto = interface
    ['{254E41A0-B5C6-456F-8FBC-624213DF694A}']
    function GetNome: string;
    function GetPreco: Double;
    function GetDesconto: Double;
    function GetTotal: Double;
    procedure AplicarDesconto(APercentual: Double);
  end;

  TProduto = class(TInterfacedObject, IProduto)
  private
    FNome: string;
    FPreco: Double;
    FDesconto: Double;
  public
    constructor Create(const ANome: string; const APreco: Double);
    function GetNome: string;
    function GetPreco: Double;
    function GetDesconto: Double;
    function GetTotal: Double;
    procedure AplicarDesconto(APercentual: Double);
  end;

implementation

{ TProduto }

constructor TProduto.Create(const ANome: string; const APreco: Double);
begin
  if ANome.IsEmpty then
    raise NomeInvalidoException.Create('Nome do produto n�o informado');

  if APreco < 0 then
    raise ValorInvalidoException.Create('Valor do produto n�o pode ser negativo');

  FNome := ANome;
  FPreco := APreco;
  FDesconto := 0;
end;

procedure TProduto.AplicarDesconto(APercentual: Double);
begin
  if (APercentual < 0) or (APercentual > 100) then
    raise PrecentualDescontoInvalidoException.Create('Percutual de desconto inv�lido');

  FDesconto := (APercentual / 100) * FPreco;
end;

function TProduto.GetDesconto: Double;
begin
  Result := FDesconto;
end;

function TProduto.GetNome: string;
begin
  Result := FNome;
end;

function TProduto.GetPreco: Double;
begin
  Result := FPreco;
end;

function TProduto.GetTotal: Double;
begin
  Result := FPreco - FDesconto;
end;

end.
