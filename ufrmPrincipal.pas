unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uTEditHelper,
  System.Generics.Collections, TextoPadrao.Model.Entidades.TextoPadrao, TextoPadrao.Model.DAO.TextoPadrao,
   ufrmCadastro,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.StrUtils,

  TextoPadrao.Model.Controller.TextoPadrao,
  TextoPadrao.Model.Controller.Interfaces,
  TextoPadrao.Model.Controller.Cadastro.Interfaces,
  TextoPadrao.Model.Controller.Cadastro;

type
  TfrmPrincipal = class(TForm)
    cbTipoPesquisa: TComboBox;
    edtTrecho: TEdit;
    lvPrincipal: TListView;
    mmPrincipal: TMemo;
    lblTipo: TLabel;
    lblTrecho: TLabel;
    btnAdd: TButton;
    btnEditar: TButton;
    btnRemover: TButton;
    btnCopiar: TButton;
    imgSobre: TImage;
    procedure FormShow(Sender: TObject);
    procedure lvPrincipalClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure lvPrincipalDblClick(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure edtTrechoChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lvPrincipalEnter(Sender: TObject);
    procedure lvPrincipalExit(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure edtTrechoDblClick(Sender: TObject);
    procedure imgSobreClick(Sender: TObject);
    procedure edtTrechoKeyPress(Sender: TObject; var Key: Char);
    procedure lvPrincipalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mmPrincipalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FListaTextoPadraoCompleto: TObjectList<TTextoPadrao>;
    FController: iControllerTextoPadrao;
    FControllerCadastro: iControllerCadastro;
    procedure AtualizarGrid;
    procedure PrepararGrid;
    function PreencherObjeto(pObj: TTextoPadrao): TTextoPadrao;
    procedure MostrarTela;
    procedure BloquearBotoes(pSim: Boolean=True);
    procedure Pesquisar;
    procedure PreencherGrid(pLista: TobjectList<TTextoPadrao>);
    function RetornarFiltro: string;
    procedure CopiarMemo;
    procedure PreencherMemo;
    procedure SomenteNumero(pCampo: tEdit; var pKey: Char);
    function GetBuildInfo(Prog: string): string;
    procedure CriarColuna(pTitulo, palinhamento: string; pTamanho: Integer;
      pAutoSize: Boolean=false);
    function RetornarAlinhamento(pAlinhamento: string): TAlignment;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnAddClick(Sender: TObject);
var
  lTela: TfrmCadastro;
begin
  lTela := TfrmCadastro.Create(nil);
  try
    lTela.MostrarTela;
  finally
    lTela.Free;
  end;
  AtualizarGrid;
  BloquearBotoes();
end;

procedure TfrmPrincipal.btnCopiarClick(Sender: TObject);
begin
  CopiarMemo;
end;

procedure TfrmPrincipal.CopiarMemo;
begin
  mmPrincipal.SelectAll;
  mmPrincipal.copytoclipboard;
  mmPrincipal.SelStart := 0;
end;

procedure TfrmPrincipal.btnEditarClick(Sender: TObject);
begin
  MostrarTela;
end;

procedure TfrmPrincipal.btnRemoverClick(Sender: TObject);
begin
  if Application.MessageBox('Confirma excluir o cadastro?',
      'Confirmação', MB_YESNO + MB_ICONQUESTION) = ID_YES then
   begin
    FControllerCadastro.ExcluirCadastroTextoPadrao(lvPrincipal.Items[lvPrincipal.Selected.Index].Caption);
    AtualizarGrid;
   end;
end;

procedure TfrmPrincipal.edtTrechoChange(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmPrincipal.edtTrechoDblClick(Sender: TObject);
begin
  (Sender as TEdit).Clear;
end;

procedure TfrmPrincipal.edtTrechoKeyPress(Sender: TObject; var Key: Char);
begin
  if cbTipoPesquisa.ItemIndex = 0 then
    SomenteNumero(edtTrecho, Key);
end;

procedure TfrmPrincipal.SomenteNumero(pCampo :tEdit; var pKey: Char);
begin
  if not (CharInSet(pKey, ['0'..'9',#7,#8])) then
    begin
      pKey := #0;
    end;
end;

procedure TfrmPrincipal.Pesquisar;
begin
  mmPrincipal.Lines.Clear;
  PreencherGrid(FController.RetornarTextoPadraoBancoFiltro(RetornarFiltro));
  BloquearBotoes();
end;

function TfrmPrincipal.RetornarFiltro:string;
begin
  if (edtTrecho.IsEmpty) then
  begin
    Result := 'Descricao like ''%'' ';
    Exit;
  end;

  case cbTipopesquisa.ItemIndex of
    0: Result := ' Codigo = ' + edtTrecho.Text;
    1: Result := ' Descricao like ''%'+ edtTrecho.Text + '%'' ';
    2: Result := ' Texto like ''%' + edtTrecho.Text + '%''';
  end;
end;


procedure TfrmPrincipal.MostrarTela;
var
  lTela: TfrmCadastro;
  lTexto : TTextoPadrao;
begin
  lTela := TfrmCadastro.Create(nil);
  lTexto := TTextoPadrao.Create;

  try
    lTexto := PreencherObjeto(lTexto);
    lTela.MostrarTela(lTexto);
  finally
    lTela.Free;
    lTexto.Free;
  end;

  AtualizarGrid;
end;

function TfrmPrincipal.PreencherObjeto(pObj: TTextoPadrao):TTextoPadrao;
var
  lSelecionado: Integer;
begin
  lSelecionado := 0;

  if Assigned(lvPrincipal.Selected) then
    lSelecionado := lvPrincipal.Selected.Index;

  pObj.ID := StrToInt(lvPrincipal.Items[lSelecionado].Caption);
  pObj.Codigo := lvPrincipal.Items[lSelecionado].SubItems[0];
  pObj.Descricao := lvPrincipal.Items[lSelecionado].SubItems[1];
  pObj.Texto := lvPrincipal.Items[lSelecionado].SubItems[2];

  Result := pObj;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FController := TControllerTextoPadrao.new;
  FControllerCadastro := TControllerCadastro.New;

  ReportMemoryLeaksOnShutdown := True;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Application.Terminate;
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If ((key = #13) and (not(ActiveControl.ClassType = TMemo))) then
    Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
    end;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
  edtTrecho.Focar;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  FListaTextoPadraoCompleto := FController.RetornarTextoPadraoBanco;
  AtualizarGrid;
  edtTrecho.focar;
  BloquearBotoes();
end;

procedure TfrmPrincipal.imgSobreClick(Sender: TObject);
var
  lVersao, lmensagem: string;
begin
  lVersao := GetBuildInfo(ExtractFileName(Application.ExeName));

  lmensagem := 'Bem vindo ao aplicativo de Textos Padrões!' +#13+#13+
               'Versão: ' +(lVersao)+#13+#13+
               'Este aplicativo foi criado pelo '+#13+
               'Wallace Ferreira da Silva'+#13+#13+
               'Com o intuito de otimizar a digitação de pareceres'+#13+
               ' com textos padrões'+#13+#13+
               'Agradeço pela utilização!';

  MessageBox(Handle, PChar(lMensagem), 'Sobre', MB_OK + MB_ICONINFORMATION);
end;



function TfrmPrincipal.GetBuildInfo(Prog: string): string;
var
 VerInfoSize: DWORD;
 VerInfo: Pointer;
 VerValueSize: DWORD;
 VerValue: PVSFixedFileInfo;
 Dummy: DWORD;
 V1, V2, V3, V4: Word;
begin
 try
   VerInfoSize := GetFileVersionInfoSize(PChar(Prog), Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);
   with (VerValue^) do
   begin
     V1 := dwFileVersionMS shr 16;
     V2 := dwFileVersionMS and $FFFF;
     V3 := dwFileVersionLS shr 16;
     V4 := dwFileVersionLS and $FFFF;
   end;
   FreeMem(VerInfo, VerInfoSize);
   Result := Format('%d.%d.%d.%d', [v1, v2, v3, v4]);
 except
   Result := '1.0.0';
 end;
end;

procedure TfrmPrincipal.BloquearBotoes(pSim: Boolean=True);
begin
  btnEditar.Enabled := not pSim;
  btnRemover.Enabled := not pSim;
end;


procedure TfrmPrincipal.lvPrincipalClick(Sender: TObject);
begin
  PreencherMemo;
end;

procedure TfrmPrincipal.PreencherMemo;
var
  lSelecionado: Integer;
begin
  mmPrincipal.Clear;

  if lvPrincipal.Items.Count > 0 then
  begin
    if Assigned(lvPrincipal.Selected) then
      lSelecionado := lvPrincipal.Selected.Index
    else
      lSelecionado := 0;

    mmPrincipal.Lines.Add(lvPrincipal.Items[lSelecionado].SubItems[2]);
    BloquearBotoes(false);
  end;
end;


procedure TfrmPrincipal.lvPrincipalDblClick(Sender: TObject);
begin
  MostrarTela;
end;

procedure TfrmPrincipal.lvPrincipalEnter(Sender: TObject);
begin
  if lvPrincipal.Items.Count > 0 then
    begin
      lvPrincipal.SetFocus;
      lvPrincipal.Items.Item[0].Focused := True;
      lvPrincipal.Items.Item[0].Selected := True;
      PreencherMemo;
      CopiarMemo;
    end
  else
    begin
      MessageBox(Handle, 'Texto não encontrado, verifique!',
                         'Atenção!', MB_OK + MB_ICONINFORMATION);
      edtTrecho.setfocus;
    end;
end;

procedure TfrmPrincipal.lvPrincipalExit(Sender: TObject);
begin
  if lvPrincipal.Items.Count > 0 then
    begin
      CopiarMemo;
      lvPrincipal.Items.Item[0].Focused := false;
      lvPrincipal.Items.Item[0].Selected := false;
    end;
end;




procedure TfrmPrincipal.lvPrincipalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if ((key = VK_UP) or (Key = VK_DOWN)) then
  PreencherMemo;
end;

procedure TfrmPrincipal.mmPrincipalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    Application.Minimize;
end;

procedure TfrmPrincipal.AtualizarGrid;
begin
  PreencherGrid(FController.RetornarTextoPadraoBanco);
  BloquearBotoes();
  mmPrincipal.Lines.Clear;
  edtTrecho.Clear;
  edtTrecho.Focar;
end;

procedure TfrmPrincipal.PreencherGrid(pLista: TobjectList<TTextoPadrao>);
var
  i: integer;
  lItem: TListItem;
begin
  if pLista <> nil then
    begin
      PrepararGrid;
      for I := 0 to pLista.Count-1 do
        begin
          lItem := lvPrincipal.Items.Add;
          lItem.Caption := pLista.Items[i].ID.ToString;
          lItem.SubItems.Add(pLista.Items[i].Codigo);
          lItem.SubItems.Add(pLista.Items[i].Descricao);
          lItem.SubItems.Add(pLista.Items[i].Texto);
        end;
    end;
end;


procedure TfrmPrincipal.PrepararGrid;
begin
  lvPrincipal.Columns.Clear;
  lvPrincipal.Items.Clear;

  CriarColuna('ID', 'Esquerda', 0);
  CriarColuna('Código', 'Direita', 50);
  CriarColuna('Descrição', 'Esquerda', 200);
  CriarColuna('Texto', 'Esquerda', 10, True);

  lvPrincipal.Column[3].Width := lvPrincipal.Width -
                                 lvPrincipal.Column[1].Width -
                                 lvPrincipal.Column[2].Width - 22;
end;

procedure TfrmPrincipal.CriarColuna(pTitulo, palinhamento: string; pTamanho:Integer; pAutoSize: Boolean=False);
var
  lColuna: TListColumn;
begin
  lColuna := lvPrincipal.Columns.Add;
  lColuna.Caption := pTitulo;
  lColuna.Alignment := RetornarAlinhamento(palinhamento);
  lColuna.Width := pTamanho;
  lColuna.AutoSize := pAutoSize;
end;

function TfrmPrincipal.RetornarAlinhamento(pAlinhamento: string):TAlignment;
begin
  case ansiindexstr(pAlinhamento, ['Esquerda', 'Centro', 'Direita']) of
    0: result := taLeftJustify;
    1: Result := taCenter;
    2: Result := taRightJustify;
  else
      Result := taLeftJustify;
  end;
end;
end.
