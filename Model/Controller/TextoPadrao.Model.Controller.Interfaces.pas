unit TextoPadrao.Model.Controller.Interfaces;

interface

uses
  TextoPadrao.Model.Entidades.TextoPadrao, System.Generics.Collections;

type
  iControllerTextoPadrao = interface
    ['{38CECA36-1F39-4B01-A49E-9502B5A494BE}']
    function RetornarTextoPadraoBanco: TObjectList<TTextoPadrao>;
    function RetornarTextoPadraoBancoFiltro(pFiltro: string): TObjectList<TTextoPadrao>;
  end;


implementation

end.
