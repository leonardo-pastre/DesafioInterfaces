program DesafioInterfaces;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {Principal},
  UProduto in 'UProduto.pas',
  UPedido in 'UPedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
