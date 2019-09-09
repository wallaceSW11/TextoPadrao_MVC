unit TextoPadrao.Model.Query;

interface

uses
  System.SysUtils,
  TextoPadrao.Model.Conexao.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, TextoPadrao.Model.Conexao, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TQuery = class(TInterfacedObject, iQuery)
  private
    FQuery: TFDQuery;
    FConexao: iConexao;
  public
    constructor Create;
    destructor Destroy; override;
    class function New(): iQuery;
    function Query(pComando: string): TFDQuery;
    function ExecSQL(pComando: string): Boolean;
    function SelectSimples(pComando: string):string;
end;

implementation

 { TQuery }

constructor TQuery.Create;
begin
  FConexao := TConexao.New;
  FQuery := TFDQuery.Create(nil);
end;

destructor TQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TQuery.ExecSQL(pComando: string): Boolean;
begin
  FQuery.Connection := FConexao.Conectar;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := pComando;

  try
    FQuery.ExecSQL;
  except
    on e:Exception do
    raise Exception.Create('Falha ao executar o comando.' +#13+
                           'Mensagem original: ' +#13+
                           e.Message );
  end;

  Result := True;
end;

class function TQuery.New():iQuery;
begin
  Result := Self.Create;
end;

function TQuery.Query(pComando: string): TFDQuery;
begin
  FQuery.Connection := FConexao.Conectar;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := pComando;

  try
    FQuery.Active := True;
    FQuery.Open;
  except
    on e:Exception do
    raise Exception.Create('Falha ao realizar a consulta.' +#13+
                           'Mensagem original: ' +#13+
                           e.Message );
  end;

  Result := FQuery;
end;

function TQuery.SelectSimples(pComando: string): string;
begin
  FQuery.Connection := FConexao.Conectar;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := pComando;

  try
    FQuery.Active := True;
    FQuery.Open;
  except
    on e:Exception do
    raise Exception.Create('Falha ao realizar a consulta.' +#13+
                           'Mensagem original: ' +#13+
                           e.Message );
  end;

  Result := FQuery.Fields[0].value;

end;

end.
