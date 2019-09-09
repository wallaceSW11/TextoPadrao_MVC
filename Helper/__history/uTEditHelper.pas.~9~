unit uTEditHelper;

interface

uses
  vcl.stdCtrls, SysUtils, Data.DB, Vcl.Grids, Vcl.DBGrids, System.Variants;

type
  TDoubleHelper = record helper for double
    function ValorMonetario: string;
    function VlMonetario: string;
    function ToString: string;

  end;


type
  TEditHelper = class helper for TEdit

  public
    function IsEmpty:Boolean;
    procedure Focar;
    function ValidarNumero:Double;
    function IsValid:Boolean;
    function Float:Double;
    function Zerado:string;
    function ZeradoComVirgula:string;

  end;




implementation

{ TEditHelper }

function TEditHelper.Float: Double;
begin
  Result := StrToFloat(Self.Text);
end;

procedure TEditHelper.Focar;
begin
  if (Self.CanFocus) then
  begin
    Self.SetFocus;
    Self.SelectAll;
  end;
end;

function TEditHelper.IsEmpty:Boolean;
begin
 Result := Trim(Self.Text).IsEmpty;
end;


function TEditHelper.IsValid: Boolean;
begin
  Result := Trim(Self.Text) <> '';
end;

function TEditHelper.ValidarNumero;
var
  lValor:Variant;
begin
  lValor := Self.Text;

  if ((lValor = null) or (lValor = '')) then
    Result := 0
  else
    Result := StrToFloat(Self.Text);
end;



function TEditHelper.Zerado: string;
begin
  Self.Text := '0';
end;

function TEditHelper.ZeradoComVirgula: string;
begin
  Self.Text := '0,00';
end;

function TDoubleHelper.ValorMonetario: string;
begin
  result := FormatFloat('0.00', Self);
end;


function TDoubleHelper.VlMonetario: string;
begin
  result := StringReplace(FloatToStr(Self), ',','.', [rfReplaceAll, rfIgnoreCase]);
end;


function TDoubleHelper.ToString: string;
begin
  result := floattostr(self);
end;


end.
