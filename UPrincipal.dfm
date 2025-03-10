object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Desafio WK - Interfaces'
  ClientHeight = 276
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object EdtNome: TLabeledEdit
    Left = 10
    Top = 32
    Width = 178
    Height = 23
    EditLabel.Width = 96
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome do produto'
    TabOrder = 0
    Text = ''
  end
  object EdtPreco: TLabeledEdit
    Left = 194
    Top = 32
    Width = 79
    Height = 23
    EditLabel.Width = 30
    EditLabel.Height = 15
    EditLabel.Caption = 'Pre'#231'o'
    TabOrder = 1
    Text = ''
    OnKeyPress = EdtPrecoKeyPress
  end
  object BtnInserir: TBitBtn
    Left = 367
    Top = 32
    Width = 75
    Height = 24
    Caption = 'Inserir'
    TabOrder = 3
    OnClick = BtnInserirClick
  end
  object EdtTotal: TLabeledEdit
    Left = 402
    Top = 248
    Width = 121
    Height = 23
    Alignment = taRightJustify
    EditLabel.Width = 25
    EditLabel.Height = 15
    EditLabel.Caption = 'Total'
    ReadOnly = True
    TabOrder = 6
    Text = ''
  end
  object BtnRemover: TBitBtn
    Left = 448
    Top = 32
    Width = 75
    Height = 24
    Caption = 'Remover'
    TabOrder = 4
    OnClick = BtnRemoverClick
  end
  object EdtDesconto: TLabeledEdit
    Left = 279
    Top = 32
    Width = 79
    Height = 23
    EditLabel.Width = 71
    EditLabel.Height = 15
    EditLabel.Caption = 'Desconto (%)'
    TabOrder = 2
    Text = ''
    OnKeyPress = EdtDescontoKeyPress
  end
  object SgrProdutos: TStringGrid
    Left = 10
    Top = 64
    Width = 513
    Height = 163
    ColCount = 3
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 5
  end
end
