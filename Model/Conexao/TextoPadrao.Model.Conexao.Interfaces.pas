unit TextoPadrao.Model.Conexao.Interfaces;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  iConexao = interface
    ['{F94D6DB5-4B2F-49EF-BABB-59901315C31F}']
    function Conectar(): TFDconnection;
  end;

  iQuery = interface
    ['{5B165409-AD76-4996-AD17-8EEF51CC191F}']
    function Query(pComando: string): TFDQuery;
    function ExecSQL(pComando: string): Boolean;
    function SelectSimples(pComando: string):string;
  end;

implementation

end.
