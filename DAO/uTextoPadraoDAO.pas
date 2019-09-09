unit uTextoPadraoDAO;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Win.IEInterfaces,
  StrUtils,  Data.DB, Datasnap.DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, ZDbcIntfs,  System.Classes, System.Rtti, System.TypInfo,
  System.Variants, uCRUD, uTEditHelper, TextoPadrao.Model.Entidades.TextoPadrao, uCadastroHelper;

type
  TTextoPadraoDAO = class

  private
  const
  CONSULTAR_TEXTO_PADRAO = 'Select * from TextoPadrao ';
    class function RetornarInsert(pObjeto: TTextoPadrao): string; static;
    class function RetornarUpdate(pObjeto: TTextoPadrao): string; static;

  const
  CONSULTAR_TEXTO_PADRAO_POR_FILTRO = 'Select * from TextoPadrao where %s';

  const
  INSERE_TEXTO = 'insert into TextoPadrao (%s) values (%s)';

  const
  ATUALIZA_TEXTO = 'update TextoPadrao set %s where id=%s';

  const
    EXCLUIR_TEXTO = 'Delete from TextoPadrao where id=%s';

public

  class function CarregarTextoPadrao():TObjectList<TTextoPadrao>;
  class function CarregarTextoPadraoFiltro(pFiltro: string):TObjectList<TTextoPadrao>;
  class procedure GravarTextoPadrao(pObjeto: TTextoPadrao);
  class procedure Excluir(pID: string);

end;

implementation

{ TTextoPadraoDAO }

class function TTextoPadraoDAO.CarregarTextoPadrao: TObjectList<TTextoPadrao>;
begin
  Result := TCRUD<TTextoPadrao>.Select(CONSULTAR_TEXTO_PADRAO);
end;

class function TTextoPadraoDAO.CarregarTextoPadraoFiltro(pFiltro: string): TObjectList<TTextoPadrao>;
begin
  Result := TCRUD<TTextoPadrao>.Select(
    Format(CONSULTAR_TEXTO_PADRAO_POR_FILTRO, [pFiltro]));
end;

class procedure TTextoPadraoDAO.Excluir(pID: string);
begin
  TCRUD<TTextoPadrao>.Delete(
    Format(EXCLUIR_TEXTO, [QuotedStr(pID)]));
end;


class function TTextoPadraoDAO.RetornarInsert(pObjeto: TTextoPadrao):string;
var
  context: TRttiContext;
  tipo: TRttiType;
  props: TArray<TRttiProperty>;
  prop: TRttiProperty;
  lCampo, lValor: string;
begin
  context := TRttiContext.Create;
  tipo := context.GetType(pObjeto.ClassInfo);
  props := tipo.GetProperties;

  for prop in props do
    begin
      if (prop.Name <> 'ID') then
      begin
        lCampo := lCampo + prop.Name + ', ';
        lValor := lValor + QuotedStr((prop.GetValue(pObjeto).ToString))+', ';
      end;
    end;

    lCampo := Copy(lCampo, 0, Length(lCampo)-2);
    lValor := Copy(lValor, 0, Length(lValor)-2);

  Result := Format(INSERE_TEXTO, [lCampo, lValor]);
end;


class function TTextoPadraoDAO.RetornarUpdate(pObjeto: TTextoPadrao):string;
var
  context: TRttiContext;
  tipo: TRttiType;
  props: TArray<TRttiProperty>;
  prop: TRttiProperty;
  lComplemento: string;
begin
  context := TRttiContext.Create;
  tipo := context.GetType(pObjeto.ClassInfo);
  props := tipo.GetProperties;

  for prop in props do
    begin
      if (prop.Name <> 'ID') then
      begin
        lComplemento := lComplemento + prop.Name + ' = ' +
          QuotedStr((prop.GetValue(pObjeto).ToString))+', ';
      end;
    end;
    lComplemento := Copy(lComplemento, 0, Length(lComplemento)-2);

  Result := Format(ATUALIZA_TEXTO, [lComplemento, QuotedStr(IntToStr(pObjeto.ID))]);
end;


class procedure TTextoPadraoDAO.GravarTextoPadrao(pObjeto: TTextoPadrao);
begin
  if (pObjeto.ID = 0) then
    begin
      TCadastroHelper.GravarUltimoCodigo(pObjeto.Codigo,'Texto');
      TCRUD<TTextoPadrao>.Insert(RetornarInsert(pObjeto));
    end
  else
    begin
      TCRUD<TTextoPadrao>.Update(RetornarUpdate(pObjeto));
    end;
end;
end.
