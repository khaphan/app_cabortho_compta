inherited FrmExportCSV: TFrmExportCSV
  Caption = 'Export des donn'#233'es CSV'
  ClientHeight = 165
  ClientWidth = 338
  ExplicitWidth = 354
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 338
    Height = 98
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 129
      Height = 16
      Caption = 'P'#233'riode d'#233'compte'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 78
      Height = 16
      Caption = 'Total D'#233'dit'
    end
    object Label3: TLabel
      Left = 16
      Top = 70
      Width = 82
      Height = 16
      Caption = 'Total Cr'#233'dit'
    end
    object txtTotalDebit: TLabel
      Left = 136
      Top = 48
      Width = 100
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
    end
    object txtTotalCredit: TLabel
      Left = 136
      Top = 70
      Width = 100
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
    end
    object spbInfoTotal: TSpeedButton
      Left = 280
      Top = 56
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333336633
        3333333333333FF3333333330000333333364463333333333333377F33333333
        00003333333E66433333333333337F37F3333333000033333333E66333333333
        33337FF7F3333333000033333333333333333333333337733333333300003333
        3333446333333333333333FF3333333300003333333666433333333333333777
        F333333300003333333E66433333333333337F37F333333300003333333E6664
        3333333333337F37F3333333000033333333E6664333333333337F337F333333
        0000333333333E6664333333333337F337F3333300003333344333E666433333
        333F337F337F3333000033336664333E664333333377F337F337F33300003333
        E66433366643333337F37FFF7337F33300003333E66644466663333337F33777
        3337F333000033333E66666666333333337FF333333733330000333333EE666E
        E333333333377FFFFF733333000033333333EEE3333333333333377777333333
        0000}
      NumGlyphs = 2
      OnClick = spbInfoTotalClick
    end
    object edPeriode: TPXDateEdit
      Left = 180
      Top = 17
      Width = 121
      Height = 24
      TabOrder = 0
      Text = ''
      OnChange = edPeriodeChange
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
      DateFormat = 'dd.mm.yy'
    end
  end
  object btExportRecette: TButton
    Left = 32
    Top = 112
    Width = 105
    Height = 41
    Caption = 'Export Recette'
    TabOrder = 1
    WordWrap = True
    OnClick = btExportRecetteClick
  end
  object btEXportDepense: TButton
    Left = 180
    Top = 112
    Width = 105
    Height = 41
    Caption = 'Export D'#233'pense'
    TabOrder = 2
    WordWrap = True
    OnClick = btEXportDepenseClick
  end
  object qry: TOracleQuery
    Optimize = False
    Left = 144
    Top = 112
  end
end
