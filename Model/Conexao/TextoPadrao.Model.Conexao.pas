unit TextoPadrao.Model.Conexao;

interface

uses
  TextoPadrao.Model.Conexao.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, System.SysUtils, vcl.Forms, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TConexao = class(TInterfacedObject, iConexao)
  private
    FConexao: TFDConnection;
  public
    function Conectar(): TFDconnection;
    constructor Create;
    destructor Destroy; override;
    class function New(): iConexao;
end;

implementation

 { TConexao }

function TConexao.Conectar: TFDconnection;
begin
  Result := FConexao;
end;

constructor TConexao.Create;
begin
  FConexao := TFDConnection.Create(nil);
  FConexao.Params.DriverID := 'sqlite';
  FConexao.Params.Database := ExtractFileDir(Application.ExeName) + '\TextoPadrao.db';
  FConexao.Connected := True;
end;

destructor TConexao.Destroy;
begin
  FConexao.Connected := False;
  FreeAndNil(FConexao);
  inherited;
end;

class function TConexao.New():iConexao;
begin
  Result := Self.Create;
end;

end.
