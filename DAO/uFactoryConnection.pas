unit uFactoryConnection;

interface

  uses
    System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, ZDbcIntfs, StrUtils;

type
  TFactoryConnection = class
    class function Conectar():TZConnection;
  end;

implementation

uses
  Vcl.Forms;

class function TFactoryConnection.Conectar;
var
  lConexao : TZConnection;
begin
  lConexao := TZConnection.Create(nil);
  lConexao.Database := ExtractFileDir(Application.ExeName) + '\TextoPadrao.s3db';
  lConexao.Protocol := 'sqlite';
  lConexao.LoginPrompt := False;
  lConexao.TransactIsolationLevel := tiReadCommitted;
  result := lConexao;
end;
end.

