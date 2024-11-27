inherited frmEditDecomptes: TfrmEditDecomptes
  Caption = 'Edition des D'#233'comptes'
  ClientHeight = 507
  ClientWidth = 683
  ExplicitWidth = 699
  ExplicitHeight = 546
  PixelsPerInch = 96
  TextHeight = 15
  inherited Bevel1: TBevel
    Width = 683
    ExplicitWidth = 683
  end
  inherited pnGrid: TPanel
    Left = 0
    Width = 683
    Height = 375
    ExplicitLeft = 0
    ExplicitWidth = 683
    ExplicitHeight = 375
    inherited gd: TDBGrid
      Width = 681
      Height = 340
      Columns = <
        item
          Expanded = False
          FieldName = 'PERIODE_LIB'
          Title.Caption = 'P'#233'riode'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LIBELLE'
          Title.Caption = 'Libell'#233
          Width = 502
          Visible = True
        end>
    end
    inherited pnSrch: TPanel
      Width = 681
      Visible = False
      ExplicitWidth = 681
    end
  end
  inherited pnEdit: TPanel
    Top = 408
    Width = 683
    Height = 99
    Align = alBottom
    ExplicitTop = 408
    ExplicitWidth = 683
    ExplicitHeight = 99
    object Label1: TLabel [0]
      Left = 8
      Top = 38
      Width = 78
      Height = 15
      Caption = 'Date d'#233'compte'
    end
    object Label2: TLabel [1]
      Left = 8
      Top = 67
      Width = 38
      Height = 15
      Caption = 'Libell'#233
    end
    object spbEditEcritures: TSpeedButton [2]
      Left = 488
      Top = 16
      Width = 93
      Height = 22
      Caption = 'Ecritures'
      OnClick = spbEditEcrituresClick
    end
    object edPeriode: TPXDateEdit
      Left = 92
      Top = 34
      Width = 121
      Height = 23
      TabOrder = 1
      Text = ''
      OnChange = edFieldChange
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
      DateFormat = 'dd.mm.yy'
    end
    object edLibelle: TEdit
      Left = 92
      Top = 63
      Width = 489
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 2
      OnChange = edFieldChange
    end
  end
  inherited O_qry: TOracleDataSet
    SQL.Strings = (
      'select id,periode,libelle,to_char(periode,'#39'MM-YYYY'#39') periode_lib'
      'from compta.decompte'
      'order by periode desc')
    QBEDefinition.QBEFieldDefs = {
      050000000400000004000000490044000100000000000E000000500045005200
      49004F00440045000100000000000E0000004C004900420045004C004C004500
      0100000000001600000050004500520049004F00440045005F004C0049004200
      010000000000}
    Session = OracleSession1
  end
  inherited O_OraProc: TOraclePackage
    Session = OracleSession1
  end
  object OracleSession1: TOracleSession
    DesignConnection = True
    LogonUsername = 'compta'
    LogonPassword = 'hippie'
    LogonDatabase = 'XE'
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Connected = True
    Left = 456
    Top = 201
  end
end
