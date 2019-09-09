unit ufrmCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TextoPadrao.Model.DAO.TextoPadrao, TextoPadrao.Model.Entidades.TextoPadrao,
  TextoPadrao.Model.Controller.Cadastro.Interfaces, TextoPadrao.Model.Controller.Cadastro;

type
  TfrmCadastro = class(TForm)
    edtID: TEdit;
    edtDescricao: TEdit;
    edtCodigo: TEdit;
    mmTexto: TMemo;
    btnOK: TButton;
    btnCancelar: TButton;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FControllerCadastro : iControllerCadastro;
    function RetornarIDTexto: Integer;
    procedure LimparCampos;
    procedure SalvarTexto;
    { Private declarations }
  public
    { Public declarations }

  procedure MostrarTela(pObjeto: TTextoPadrao); overload;
  procedure MostrarTela(); overload;
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}

{ TfrmCadastro }

procedure TfrmCadastro.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastro.btnOKClick(Sender: TObject);
begin
  SalvarTexto;
end;


procedure TfrmCadastro.SalvarTexto;
var
  lTexto: TTextoPadrao;
begin
  lTexto := TTextoPadrao.Create;

  try
    lTexto.ID := RetornarIDTexto;
    lTexto.Codigo := edtCodigo.Text;
    lTexto.Descricao := edtDescricao.Text;
    lTexto.Texto := mmTexto.Text;
    FControllerCadastro.GravarTextoPadrao(lTexto);
  finally
    FreeAndNil(lTexto);
  end;

  if edtID.Text = EmptyStr then
    LimparCampos;

  Close;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
  FControllerCadastro := TControllerCadastro.New;
end;

procedure TfrmCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_ESCAPE) then
    Close;

  if (Key = VK_F10 ) then
    SalvarTexto;
end;

procedure TfrmCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If ((key = #13) and (not(ActiveControl.ClassType = TMemo))) then
    Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
    end;
end;

procedure TfrmCadastro.LimparCampos;
begin
  edtID.Clear;
  edtCodigo.Clear;
  edtDescricao.Clear;
  mmTexto.Lines.Clear;

  edtCodigo.Text := FControllerCadastro.RetornarProximoCodigo;
  edtDescricao.SetFocus;

  Abort;
end;

function TfrmCadastro.RetornarIDTexto:Integer;
begin
  Result := 0;

  if edtID.Text <> EmptyStr then
    Result := StrToInt(edtID.Text);
end;

procedure TfrmCadastro.MostrarTela(pObjeto: TTextoPadrao);
begin
  if pObjeto <> nil then
  begin
    edtID.Text := IntToStr(pObjeto.ID);
    edtCodigo.Text := pObjeto.Codigo;
    edtDescricao.Text := pObjeto.Descricao;
    mmTexto.Lines.Add(pObjeto.Texto);
  end;

  Self.ShowModal;
end;

procedure TfrmCadastro.MostrarTela;
begin
  edtCodigo.Text := FControllerCadastro.RetornarProximoCodigo;
  Self.ShowModal;
end;

end.