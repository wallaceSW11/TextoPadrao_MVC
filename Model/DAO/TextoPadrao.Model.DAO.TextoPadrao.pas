unit TextoPadrao.Model.DAO.TextoPadrao;

interface

uses
  TextoPadrao.Model.DAO.TextoPadrao.interfaces, System.Generics.Collections,
  TextoPadrao.Model.Entidades.TextoPadrao, TextoPadrao.Model.Query,
  TextoPadrao.Model.Conexao.Interfaces, System.SysUtils, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  TextoPadrao.Model.DAO.ComandosSQL;

type
  TDAOTextoPadrao = class (TInterfacedObject, iDAOTextoPadrao)
  private
  FListaTextoPadraoDAO: TObjectList<TTextoPadrao>;
    procedure PreencherListaTextoPadrao(pQuery: TFDquery);
    function RetornarComandoInsert(pTextoPadrao: TTextoPadrao): string;
    function RetornarComandoUpdate(pTextoPadrao: TTextoPadrao): string;
  public
    function CarregarTextoPadrao():TObjectList<TTextoPadrao>;
    function CarregarTextoPadraoFiltro(pFiltro: string):TObjectList<TTextoPadrao>;
    procedure GravarTextoPadrao(pTextoPadrao: TTextoPadrao);
    procedure SalvarTextoPadrao(pTextoPadrao: TTextoPadrao);
    function ProximoCodigo():string;
    procedure ExcluirCadastro(pID: string);
    constructor Create();
    destructor Destroy; override;
    class function New():iDAOTextoPadrao;
  end;

implementation

{ TDAOTextoPadrao }

function TDAOTextoPadrao.CarregarTextoPadrao: TObjectList<TTextoPadrao>;
begin
  PreencherListaTextoPadrao(TQuery.new.Query(SQL_CONSULTAR_TEXTOPADRAO));
  Result := FListaTextoPadraoDAO;
end;

function TDAOTextoPadrao.CarregarTextoPadraoFiltro(pFiltro: string): TObjectList<TTextoPadrao>;
begin
  PreencherListaTextoPadrao(TQuery.new.Query(Format(SQL_CONSULTAR_TEXTOPADRAO_FILTRO, [pFiltro])));
  Result := FListaTextoPadraoDAO;
end;

procedure TDAOTextoPadrao.PreencherListaTextoPadrao(pQuery: TFDquery);
var
  lTexto: TTextoPadrao;
begin
  FListaTextoPadraoDAO.Clear;
  pQuery.First;

  while not pQuery.Eof do
  begin
    lTexto := TTextoPadrao.Create;
    lTexto.ID := pQuery.FieldByName('ID').AsInteger;
    lTexto.Codigo := pQuery.FieldByName('Codigo').AsString;
    lTexto.Descricao := pQuery.FieldByName('Descricao').AsString;
    lTexto.Texto := pQuery.FieldByName('Texto').AsString;
    FListaTextoPadraoDAO.Add(lTexto);
    pQuery.Next;
  end;
end;



constructor TDAOTextoPadrao.Create;
begin
  FListaTextoPadraoDAO:= TObjectList<TTextoPadrao>.create();
end;

destructor TDAOTextoPadrao.Destroy;
begin
  FreeAndNil(FListaTextoPadraoDAO);
  inherited;
end;

procedure TDAOTextoPadrao.ExcluirCadastro(pID: string);
begin
  TQuery.New.ExecSQL(Format(SQL_EXCLUIR_TEXTO_PADRAO, [pID]));
end;

procedure TDAOTextoPadrao.GravarTextoPadrao(pTextoPadrao: TTextoPadrao);
begin
  TQuery.New.ExecSQL(RetornarComandoInsert(pTextoPadrao));
  TQuery.New.ExecSQL(Format(SQL_ATUALIZAR_ULTIMO_CODIGO, [pTextoPadrao.Codigo]))
end;

function TDAOTextoPadrao.RetornarComandoInsert(pTextoPadrao: TTextoPadrao):string;
begin
  Result := SQL_INSERT_TEXTOPADRAO +
            QuotedStr(pTextoPadrao.Codigo) + ', ' +
            QuotedStr(pTextoPadrao.Descricao) + ', ' +
            QuotedStr(pTextoPadrao.Texto)+ ') ';
end;

function TDAOTextoPadrao.RetornarComandoUpdate(pTextoPadrao: TTextoPadrao):string;
begin
  Result := Format(SQL_UPDATE_TEXTOPADRAO, [QuotedStr(pTextoPadrao.Codigo),
                                            QuotedStr(pTextoPadrao.Descricao),
                                            QuotedStr(pTextoPadrao.Texto),
                                            pTextoPadrao.ID.ToString]);
end;

procedure TDAOTextoPadrao.SalvarTextoPadrao(pTextoPadrao: TTextoPadrao);
begin
  TQuery.New.ExecSQL(RetornarComandoUpdate(pTextoPadrao));
end;

function TDAOTextoPadrao.ProximoCodigo: string;
var
  lCodigo: string;
begin
  Result := '1';

  lCodigo := TQuery.New.SelectSimples(SQL_CONSULTAR_ULTIMO_CODIGO);

  if (lCodigo <> EmptyStr) then
    Result := IntToStr(StrToInt(lCodigo)+1);
end;

class function TDAOTextoPadrao.New(): iDAOTextoPadrao;
begin
  Result := Self.Create;
end;

end.
