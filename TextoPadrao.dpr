program TextoPadrao;

uses
  Vcl.Forms,
  TextoPadrao.View.Principal in 'Telas\TextoPadrao.View.Principal.pas' {frmPrincipal},
  TextoPadrao.Model.Entidades.TextoPadrao in 'Model\Entidades\TextoPadrao.Model.Entidades.TextoPadrao.pas',
  uTEditHelper in 'Helper\uTEditHelper.pas',
  TextoPadrao.View.Cadastro in 'Telas\TextoPadrao.View.Cadastro.pas' {frmCadastro},
  Vcl.Themes,
  Vcl.Styles,
  TextoPadrao.Model.Conexao.Interfaces in 'Model\Conexao\TextoPadrao.Model.Conexao.Interfaces.pas',
  TextoPadrao.Model.Conexao in 'Model\Conexao\TextoPadrao.Model.Conexao.pas',
  TextoPadrao.Model.Query in 'Model\Conexao\TextoPadrao.Model.Query.pas' {TextoPadrao.Model.DAO.TextoPadrao.interfaces in 'Model\DAO\TextoPadrao.Model.DAO.TextoPadrao.interfaces.pas';},
  TextoPadrao.Model.DAO.TextoPadrao.interfaces in 'Model\DAO\TextoPadrao.Model.DAO.TextoPadrao.interfaces.pas',
  TextoPadrao.Model.DAO.TextoPadrao in 'Model\DAO\TextoPadrao.Model.DAO.TextoPadrao.pas',
  TextoPadrao.Model.Controller.Interfaces in 'Model\Controller\TextoPadrao.Model.Controller.Interfaces.pas',
  TextoPadrao.Model.Controller.TextoPadrao in 'Model\Controller\TextoPadrao.Model.Controller.TextoPadrao.pas',
  TextoPadrao.Model.DAO.ComandosSQL in 'Model\DAO\TextoPadrao.Model.DAO.ComandosSQL.pas',
  TextoPadrao.Model.Controller.Cadastro.Interfaces in 'Model\Controller\TextoPadrao.Model.Controller.Cadastro.Interfaces.pas' {/  TextoPadrao.Model.Controller.Cadastro in 'Model\Controller\TextoPadrao.Model.Controller.Cadastro.pas';},
  TextoPadrao.Model.Controller.Cadastro in 'Model\Controller\TextoPadrao.Model.Controller.Cadastro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
