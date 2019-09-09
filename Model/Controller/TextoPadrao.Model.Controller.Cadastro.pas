unit TextoPadrao.Model.Controller.Cadastro;

interface

uses
  TextoPadrao.Model.Controller.Cadastro.Interfaces, TextoPadrao.Model.DAO.TextoPadrao.interfaces,
  TextoPadrao.Model.DAO.TextoPadrao, TextoPadrao.Model.Entidades.TextoPadrao;

type
  TControllerCadastro = class(TInterfacedObject, iControllerCadastro)
  private
    FDAOTextoPadrao: iDAOTextoPadrao;
  public
    constructor Create;
    destructor Destroy; override;
    class function New(): iControllerCadastro;
    procedure GravarTextoPadrao(pTextoPadrao: TTextoPadrao);
    procedure ExcluirCadastroTextoPadrao(pID: string);
    function RetornarProximoCodigo:string;


end;

implementation

 { TClasseInterface }

constructor TControllerCadastro.Create;
begin
  FDAOTextoPadrao := TDaoTextoPadrao.New;
end;

destructor TControllerCadastro.Destroy;
begin

  inherited;
end;

procedure TControllerCadastro.ExcluirCadastroTextoPadrao(pID: string);
begin
  FDAOTextoPadrao.ExcluirCadastro(pID);
end;

procedure TControllerCadastro.GravarTextoPadrao(pTextoPadrao: TTextoPadrao);
begin
  if (pTextoPadrao.ID = 0) then
    FDAOTextoPadrao.GravarTextoPadrao(pTextoPadrao)
  else
    FDAOTextoPadrao.SalvarTextoPadrao(pTextoPadrao);

end;

class function TControllerCadastro.New():iControllerCadastro;
begin
  Result := Self.Create;
end;

function TControllerCadastro.RetornarProximoCodigo: string;
begin
  Result := FDAOTextoPadrao.ProximoCodigo;
end;

end.
