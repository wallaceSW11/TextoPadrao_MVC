unit uCRUD;

interface

uses
  System.Generics.Collections, System.Rtti,
  System.SysUtils,
  System.Classes, Data.DB, Datasnap.DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, ZDbcIntfs, Vcl.Dialogs, uFactoryConnection, System.TypInfo,
  Winapi.Windows;


type
  TCRUD<T:Class> = class
  private
    class function IniciarConsulta(pComando: string):TZQuery;
    class function ConsultaValida(pQuery: TZQuery; pComando: string):Boolean;
    class function RetornarListaObjetoPreenchido(pQuery: TZQuery): TObjectList<T>; static;

  public
    class function Select(pComando: string):Tobjectlist<T>;
    class function SelectObj(pComando: string):TObject;
    class function Insert(pComando: string): Boolean;
    class function SelectSimples(pComando: string): string;
    class procedure Delete(pComando: string);
    class function Update(pComando: string): Boolean;
    class function SelectIfExists(pComando: string):Boolean;



  end;

implementation

{ TCRUD<T> }

class function TCRUD<T>.IniciarConsulta(pComando: string):TZQuery;
var
  lQuery : TZQuery;
begin
  lQuery := TZQuery.Create(nil);
  lQuery.Connection := TFactoryConnection.Conectar;
  lQuery.Connection.Connected := True;
  lQuery.Close;
  lQuery.SQL.Add(pComando);
  Result := lQuery;
end;



class function TCRUD<T>.Select(pComando: string):Tobjectlist<T>;
var
  lQuery : TZQuery;
begin
  lQuery := IniciarConsulta(pComando);

  if not ConsultaValida(lQuery, pComando) then
    Result := nil;

   Result := RetornarListaObjetoPreenchido(lquery);
end;

class function TCRUD<T>.ConsultaValida(pQuery: TZQuery; pComando: string):Boolean;
begin
  Result := False;

  try
    pQuery.Open;
  except
    on e:Exception do
        showmessage('N�o foi poss�vel realizar a consulta.' +#13+#13+
                    'Falha no Comando: ' +#13+#13+
                     pComando +#13+#13+
                    ' Mensagem Original: ' +#13+ E.Message);
  end;

  if pQuery.RecordCount <> 0 then
    Result := True;
end;


class function TCRUD<T>.RetornarListaObjetoPreenchido(pQuery: TZQuery): TObjectList<T>;
var
  lQuery : TZQuery;
  ctx: TRttiContext;
  tipo: TRttiType;
  tipoInstancia: TRttiInstanceType;
  lObj: TObject;
  props: TArray<TRttiProperty>;
  prop: TRttiProperty;
  lLista : Tobjectlist<T>;
begin
  tipo := ctx.GetType(TypeInfo(T));
  tipoInstancia:= (Ctx.FindType(Tipo.QualifiedName) as TRttiInstanceType);
  props := tipo.GetProperties;

  llista  := Tobjectlist<T>.Create;

  try
   lQuery.First;
    while not lQuery.Eof do
    begin
      lObj := Tipoinstancia.MetaclassType.Create;

      for prop in props do
        SetPropValue(lObj, prop.Name, lQuery.FieldByName(prop.Name).Value);

      llista.Add(lObj);
      lQuery.Next;
    end;
  finally
    lquery.Connection.Connected := false;
    lquery.Free;
  end;

  Result := lLista;
end;


class function TCRUD<T>.SelectObj(pComando: string):TObject;
var
  lQuery : TZQuery;
  ctx: TRttiContext;
  tipo: TRttiType;
  tipoInstancia: TRttiInstanceType;
  lObj: TObject;
  props: TArray<TRttiProperty>;
  prop: TRttiProperty;
  lLista : Tobjectlist<T>;
begin
  lQuery := IniciarConsulta(pComando);

  if not ConsultaValida(lQuery, pComando) then
    Result := nil;

  tipo := ctx.GetType(TypeInfo(T));
  tipoInstancia:= (Ctx.FindType(Tipo.QualifiedName) as TRttiInstanceType);
  props := tipo.GetProperties;

  try
    lObj := Tipoinstancia.MetaclassType.Create;

    for prop in props do
      SetPropValue(lObj, prop.Name, lQuery.FieldByName(prop.Name).Value);
  finally
    lquery.Connection.Connected := false;
    lquery.Free;
  end;
   Result := lobj;
end;



class function TCRUD<T>.SelectIfExists(pComando: string): Boolean;
var
  lQuery: TZQuery;
begin
  lQuery := IniciarConsulta(pComando);
  try
    try
      lQuery.Open;
    except
      on e:Exception do
        showmessage('N�o foi poss�vel realizar a consulta.' +#13+#13+
                    'Falha no Comando: ' +#13+#13+
                    pComando +#13+#13+
                    ' Mensagem Original: ' +#13+ E.Message);
    end;

    Result := (lquery.RecordCount >= 1);
  finally
    lQuery.Close;
  end;
end;




class function TCRUD<T>.SelectSimples(pComando: string): string;
var
  lQuery: TZQuery;
begin
  lQuery := IniciarConsulta(pComando);
  try
    try
      lQuery.Open;
    except
      on e:Exception do
        ShowMessage('Falha na consulta ' + E.ClassName+
                    ' error raised, with message : '+E.Message);
    end;

    if (lquery.RecordCount=0) then
      Result := ''
    else
      result := lquery.fields[0].Value;

  finally
    lQuery.Close;
  end;
end;



class procedure TCRUD<T>.Delete(pComando: string);
var
  lQuery: TZQuery;
begin
  lQuery := IniciarConsulta(pComando);
  try
    try
      lQuery.ExecSQL;
    except
      on e:Exception do
        showmessage('N�o foi poss�vel apagar o cadastro.' +#13+#13+
                    'Falha no Comando: ' +#13+#13+
                    pComando +#13+#13+
                    ' Mensagem Original: ' +#13+ E.Message);
    end;
  finally
    lQuery.Close;
  end;
end;

class function TCRUD<T>.Insert(pComando: string): Boolean;
var
  lQuery: TZQuery;
begin
  lQuery := IniciarConsulta(pComando);
  try
    try
      lQuery.ExecSQL;
    except
      on e:Exception do
        showmessage('N�o foi poss�vel gravar os dados.' +#13+#13+
                    'Falha no Comando: ' +#13+#13+
                    pComando +#13+#13+
                    ' Mensagem Original: ' +#13+ E.Message);
    end;
  finally
    lQuery.Close;
  end;
  Result := True;
end;


class function TCRUD<T>.Update(pComando: string): Boolean;
var
  lQuery: TZQuery;
begin
  lQuery := IniciarConsulta(pComando);
  try
    try
      lQuery.ExecSQL;
    except
      on e:Exception do
       showmessage('N�o foi poss�vel gravar os dados.' +#13+#13+
                    'Falha no Comando: ' +#13+#13+
                    pComando +#13+#13+
                    ' Mensagem Original: ' +#13+ E.Message);
    end;
  finally
    lQuery.Close;
  end;
  Result := True;
end;
end.
