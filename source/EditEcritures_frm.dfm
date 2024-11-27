inherited FrmEditEcritures: TFrmEditEcritures
  Caption = 'Edition des '#233'critures'
  ClientHeight = 478
  ClientWidth = 868
  ExplicitWidth = 884
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 15
  inherited Bevel1: TBevel
    Width = 868
    ExplicitWidth = 771
  end
  inherited pnGrid: TPanel
    Left = 0
    Width = 868
    Height = 287
    ExplicitLeft = 0
    ExplicitWidth = 868
    ExplicitHeight = 287
    inherited gd: TDBGrid
      Width = 866
      Height = 252
      Columns = <
        item
          Expanded = False
          FieldName = 'DECRIT'
          Title.Caption = 'D. Op'#233'r.'
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHEQNUM'
          Title.Caption = 'N'#176' ch'#232'que'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DEBIT'
          Title.Alignment = taRightJustify
          Title.Caption = 'D'#233'bit'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CREDIT'
          Title.Alignment = taRightJustify
          Title.Caption = 'Cr'#233'dit'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LIBELLE'
          Title.Caption = 'Libell'#233
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMCPTE'
          Title.Caption = 'Compte'
          Width = 100
          Visible = True
        end>
    end
    inherited pnSrch: TPanel
      Width = 866
      Visible = False
      ExplicitWidth = 866
    end
  end
  inherited pnEdit: TPanel
    Top = 320
    Width = 868
    Height = 158
    Align = alBottom
    ExplicitTop = 320
    ExplicitWidth = 868
    ExplicitHeight = 158
    object Label1: TLabel [0]
      Left = 8
      Top = 52
      Width = 43
      Height = 15
      Caption = 'D. Op'#233'r'
    end
    object Label2: TLabel [1]
      Left = 208
      Top = 52
      Width = 55
      Height = 15
      Caption = 'N'#176' ch'#232'que'
    end
    object Label3: TLabel [2]
      Left = 6
      Top = 100
      Width = 29
      Height = 15
      Caption = 'D'#233'bit'
    end
    object Label4: TLabel [3]
      Left = 8
      Top = 76
      Width = 38
      Height = 15
      Caption = 'Libell'#233
    end
    object Label5: TLabel [4]
      Left = 400
      Top = 101
      Width = 55
      Height = 15
      Caption = 'Compte(s)'
    end
    object Label6: TLabel [5]
      Left = 208
      Top = 101
      Width = 35
      Height = 15
      Caption = 'Cr'#233'dit'
    end
    object Label7: TLabel [6]
      Left = 6
      Top = 132
      Width = 48
      Height = 15
      Caption = 'Total DB'
    end
    object Label8: TLabel [7]
      Left = 208
      Top = 132
      Width = 48
      Height = 15
      Caption = 'Total CR'
    end
    object txtTotalDB: TLabel [8]
      Left = 64
      Top = 132
      Width = 121
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
    end
    object txtTotalCR: TLabel [9]
      Left = 273
      Top = 132
      Width = 121
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
    end
    object edDEcrit: TPXDateEdit
      Left = 64
      Top = 48
      Width = 121
      Height = 23
      TabOrder = 1
      Text = ''
      OnChange = edFieldChange
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
      DateFormat = 'dd.mm.yy'
    end
    object edCheqNum: TPXIntegerEdit
      Left = 275
      Top = 48
      Width = 121
      Height = 23
      TabOrder = 2
      OnChange = edFieldChange
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
    object edLibelle: TEdit
      Left = 64
      Top = 72
      Width = 567
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 3
      OnChange = edFieldChange
      OnKeyUp = edLibelleKeyUp
    end
    object edDebit: TPXFloatEdit
      Left = 64
      Top = 96
      Width = 121
      Height = 23
      TabOrder = 4
      OnChange = edFieldChange
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
    object edNumCpte: TEdit
      Left = 467
      Top = 97
      Width = 164
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 6
      OnChange = edFieldChange
      OnKeyUp = edNumCpteKeyUp
    end
    object edCredit: TPXFloatEdit
      Left = 273
      Top = 97
      Width = 121
      Height = 23
      TabOrder = 5
      OnChange = edFieldChange
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
  end
  inherited O_qry: TOracleDataSet
    SQL.Strings = (
      'select e.id,e.decrit,e.cheqnum,e.libelle,'
      'decode( sign(e.montant),-1,-e.Montant,null) debit,'
      'decode( sign(e.montant),1,e.montant,0,e.Montant,Null) credit,'
      'e.Montant,'
      'Ecriture_displayNumCpte(e.id) NUMCPTE,e.etat'
      'from ecriture e'
      'where decompte_id=:decompte_id'
      'order by e.id')
    Variables.Data = {
      0400000001000000180000003A004400450043004F004D005000540045005F00
      49004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000900000004000000490044000100000000000C000000440045004300
      5200490054000100000000000E00000043004800450051004E0055004D000100
      000000000E0000004C004900420045004C004C00450001000000000008000000
      45005400410054000100000000000E0000004E0055004D004300500054004500
      0100000000000A000000440045004200490054000100000000000C0000004300
      520045004400490054000100000000000E0000004D004F004E00540041004E00
      5400010000000000}
    Session = OracleSession1
    object O_qryID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object O_qryDECRIT: TDateTimeField
      FieldName = 'DECRIT'
    end
    object O_qryCHEQNUM: TFloatField
      FieldName = 'CHEQNUM'
    end
    object O_qryLIBELLE: TWideStringField
      FieldName = 'LIBELLE'
      Size = 100
    end
    object O_qryNUMCPTE: TWideStringField
      FieldName = 'NUMCPTE'
      Size = 4000
    end
    object O_qryETAT: TWideStringField
      FieldName = 'ETAT'
      Size = 1
    end
    object O_qryDEBIT: TFloatField
      FieldName = 'DEBIT'
      DisplayFormat = '### ##0.00'
    end
    object O_qryCREDIT: TFloatField
      FieldName = 'CREDIT'
      DisplayFormat = '### ##0.00'
    end
    object O_qryMONTANT: TFloatField
      FieldName = 'MONTANT'
    end
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
  object Lookup: TLookupDialog
    LookupTable = qryF1
    Top = 225
    Left = 624
    Caption = 'Aide'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
  end
  object qryF1: TOracleDataSet
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000700000004000000490044000100000000000C000000440045004300
      5200490054000100000000000E00000043004800450051004E0055004D000100
      000000000E0000004C004900420045004C004C0045000100000000000E000000
      4D004F004E00540041004E005400010000000000080000004500540041005400
      0100000000000E0000004E0055004D004300500054004500010000000000}
    Session = OracleSession1
    Left = 648
    Top = 184
  end
  object qryTotal: TOracleQuery
    SQL.Strings = (
      'select sum(decode(sign(montant),-1,-montant,0)) debit,'
      '       sum(decode(sign(montant),-1,0,montant)) credit'
      'from ecriture'
      'where decompte_id=:decompte_id')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A004400450043004F004D005000540045005F00
      49004400030000000000000000000000}
    Left = 544
    Top = 137
  end
end
