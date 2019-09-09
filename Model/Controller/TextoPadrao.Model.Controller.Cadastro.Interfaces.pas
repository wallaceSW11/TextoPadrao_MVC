unit TextoPadrao.Model.Controller.Cadastro.Interfaces;

interface

uses
  TextoPadrao.Model.Entidades.TextoPadrao;

type
  iControllerCadastro = interface
    procedure GravarTextoPadrao(pTextoPadrao: TTextoPadrao);
    procedure ExcluirCadastroTextoPadrao(pID: string);
    function RetornarProximoCodigo:string;
  end;

implementation

end.
