object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Texto Padr'#227'o'
  ClientHeight = 494
  ClientWidth = 700
  Color = clBtnFace
  Constraints.MinHeight = 533
  Constraints.MinWidth = 716
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    700
    494)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTipo: TLabel
    Left = 10
    Top = 7
    Width = 24
    Height = 13
    Caption = 'Tipo:'
  end
  object lblTrecho: TLabel
    Left = 161
    Top = 4
    Width = 37
    Height = 13
    Caption = 'Trecho:'
  end
  object imgSobre: TImage
    Left = 667
    Top = 461
    Width = 25
    Height = 25
    Hint = 'Clique aqui.'
    Anchors = [akRight, akBottom]
    ParentShowHint = False
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000330000
      003308030000000D7FC0180000000467414D410000B18F0BFC61050000013550
      4C5445000000BA2227B72126BA2227BA2227BA2227BA2227BA2227BA2227BA22
      27BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA
      2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227
      BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA22
      27BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA
      2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227
      BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA22
      27BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA
      2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227BA2227
      BA2227BA2227BA2227BA2227BA2227BA2227BA2227FFFFFF39E204A900000065
      74524E53000000011F517893A4A93E96DF0665D7DC13AB1433E047F3F7684360
      CAC60B05B0361DFD07EC2AFB66B2049AC14C2744B1FEE9E1F620B75F1B45D152
      E31C10DDB48E836E94BEAA9D6F63EDD6398146C9F409BD4F8D7E75917C4AD40C
      87031872E4585973FAEA5F796200000001624B4744662CD4D925000002814944
      415478DAAD965B6B13511080CF74D3D624A63626044BBD945282A82F16FA2212
      A42228982894B6C46AD57FA6142FA4B686285E0BC1D8EA43A4FA6295B4522D5E
      30BD0489AD5AB3597776B7C99E9DB3495C9D87C9660EDFEE9999736606D8DF0B
      FC2746024D144DE40618A915205EFD7B43517EC9B5191FC090F52D094529DA33
      E0F20E8A1C185F2F29368C1F06ECDC9E8055211384B3F6B14A2A2B022604B15A
      014E2979C2849AA2ACA6DC29E72D4C508AB13A92925738C6EF22BE243C6A5E4F
      713E950A2606FC24620F6089B17D70828B5E41A932CD97C84EA616517743BFD9
      78E57785F1493495E9056DB9E798D9382E17B798B661EAF1931CEA4030C2599F
      BE351869FB1065A6614E5DD97FC41298EFB2CE784644A17D8EF7A1CF6ABDB6A1
      33DE73F5525395EBEB1A23B9E38D33C9351919D765BAF442DDD76121F42A8B0C
      494E66074056F61D828302666E0699968BBCF50DCC94B58708842973751399D6
      51DE3A3F1F864C099F8E775366710A996D17E8CAC41AEAD019BA32F61319F779
      BAF2FE316AC131641F1ED97D67E921EA937BECBE63F507E5E37DD4A21DE8FE58
      E3666481B1035D9D767113ECFAF33DBC5CA73B2862E447700E16D2A8A3BB048C
      7E0E04E7ED6B4A55100B51C4386FF45C2FC36D5507DAFB29639C6B7A7F562751
      0FEC146C6DEBFE907B5AB8857AB09D22957B4AEAC1B704EAE136CA54EA01A93B
      C59BA8E3E9E8CBB0975BC8CD56EA8E3545F9BB5A6B1BC9ED76F1FB33D5375247
      7FC018FE8C02349BCD5C1D658126BE5EBFDEEB0678D7C377CE64596F5CFFD017
      1CF51F477DCE513F75D4B7EDE783DC33DBF940155FE7173A87747CAA3187A0A8
      F38EC7E45772A3EEBCA363BD2DD9C874247334D3B739DBC85CD5803861FE00FC
      6BC4349FD1E1B90000002574455874646174653A63726561746500323031392D
      30332D31395431323A31373A32392B30313A30309C99EB740000002574455874
      646174653A6D6F6469667900323031392D30332D31395431323A31373A32392B
      30313A3030EDC453C80000001974455874536F6674776172650041646F626520
      496D616765526561647971C9653C0000000049454E44AE426082}
    Proportional = True
    ShowHint = True
    Transparent = True
    OnClick = imgSobreClick
  end
  object cbTipoPesquisa: TComboBox
    Left = 10
    Top = 23
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 0
    Text = 'Descri'#231#227'o'
    Items.Strings = (
      'C'#243'digo'
      'Descri'#231#227'o'
      'Texto')
  end
  object edtTrecho: TEdit
    Left = 161
    Top = 23
    Width = 500
    Height = 21
    Hint = 
      'Digite o texto a ser perquisado ou clique 2x para limpar o texto' +
      'p.'
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = edtTrechoChange
    OnDblClick = edtTrechoDblClick
    OnKeyPress = edtTrechoKeyPress
  end
  object lvPrincipal: TListView
    Left = 10
    Top = 50
    Width = 651
    Height = 158
    Anchors = [akLeft, akTop, akRight]
    Columns = <>
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnClick = lvPrincipalClick
    OnDblClick = lvPrincipalDblClick
    OnEnter = lvPrincipalEnter
    OnExit = lvPrincipalExit
    OnKeyUp = lvPrincipalKeyUp
  end
  object mmPrincipal: TMemo
    Left = 10
    Top = 214
    Width = 651
    Height = 273
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 3
    OnKeyDown = mmPrincipalKeyDown
  end
  object btnAdd: TButton
    Left = 667
    Top = 50
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '+'
    TabOrder = 4
    OnClick = btnAddClick
  end
  object btnEditar: TButton
    Left = 667
    Top = 81
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'E'
    TabOrder = 5
    OnClick = btnEditarClick
  end
  object btnRemover: TButton
    Left = 667
    Top = 112
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '-'
    TabOrder = 6
    OnClick = btnRemoverClick
  end
  object btnCopiar: TButton
    Left = 667
    Top = 214
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'C'
    TabOrder = 7
    OnClick = btnCopiarClick
  end
end
