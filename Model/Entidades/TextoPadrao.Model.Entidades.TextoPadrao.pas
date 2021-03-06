unit TextoPadrao.Model.Entidades.TextoPadrao;

interface

uses
  System.TypInfo, System.Rtti, System.Classes, System.SysUtils;

type
  TTextoPadrao = class (TPersistent)

protected
  FID: Integer;
  FCodigo: string;
  FDescricao: string;
  FTexto: string;

published
  property ID: Integer read FID write FID;
  property Codigo: string read FCodigo write FCodigo;
  property Descricao: string read FDescricao write FDescricao;
  property Texto: string read FTexto write FTexto;

  end;

implementation

end.
