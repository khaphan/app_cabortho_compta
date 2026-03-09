inherited FrmEditBanqCptes: TFrmEditBanqCptes
  Caption = 'Gestion des Comptes Bancaires'
  ClientHeight = 414
  ClientWidth = 824
  ExplicitWidth = 840
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 15
  inherited Bevel1: TBevel
    Width = 824
  end
  inherited pnGrid: TPanel
    Left = 0
    Width = 824
    Height = 231
    inherited gd: TDBGrid
      Width = 822
      Height = 196
      Columns = <
        item
          Expanded = False
          FieldName = 'CODE'
          Title.Caption = 'BanqCpte'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LIBELLE'
          Title.Caption = 'Libell'#233
          Width = 150
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CODEBANQ'
          Title.Alignment = taCenter
          Title.Caption = 'Banque'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CODEGUICHET'
          Title.Alignment = taCenter
          Title.Caption = 'Guichet'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMCOMPTE'
          Title.Caption = 'N'#176' Compte'
          Width = 150
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CleRIB'
          Title.Alignment = taCenter
          Title.Caption = 'cl'#233' RIB'
          Width = 50
          Visible = True
        end>
    end
    inherited pnSrch: TPanel
      Width = 822
      Visible = False
    end
  end
  inherited pnEdit: TPanel
    Top = 264
    Width = 824
    Height = 150
    Align = alBottom
    ExplicitTop = 264
    ExplicitWidth = 624
    ExplicitHeight = 150
    object Label1: TLabel [0]
      Left = 6
      Top = 41
      Width = 27
      Height = 15
      Caption = 'Code'
    end
    object Label2: TLabel [1]
      Left = 128
      Top = 41
      Width = 38
      Height = 15
      Caption = 'Libell'#233
    end
    object Label3: TLabel [2]
      Left = 6
      Top = 87
      Width = 71
      Height = 15
      Caption = 'Code Banque'
    end
    object Label4: TLabel [3]
      Left = 112
      Top = 87
      Width = 73
      Height = 15
      Caption = 'Code Guichet'
    end
    object Label5: TLabel [4]
      Left = 212
      Top = 87
      Width = 41
      Height = 15
      Caption = 'Compte'
    end
    object Label6: TLabel [5]
      Left = 344
      Top = 87
      Width = 44
      Height = 15
      Caption = 'Cl'#233' RIB'
    end
    inherited nav: TCMENavigator
      Width = 233
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbEdit, nbPost, nbCancel]
      ExplicitWidth = 233
    end
    object edCode: TEdit
      Left = 6
      Top = 58
      Width = 116
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = edFieldChange
    end
    object edLibelle: TEdit
      Left = 128
      Top = 58
      Width = 393
      Height = 23
      TabOrder = 2
      OnChange = edFieldChange
    end
    object edCodeBanq: TPxEdit
      Left = 6
      Top = 110
      Width = 70
      Height = 23
      TabOrder = 3
      OnChange = edFieldChange
      PicString = '#####'
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
    object edCodeGuichet: TPxEdit
      Left = 112
      Top = 108
      Width = 70
      Height = 23
      TabOrder = 4
      OnChange = edFieldChange
      PicString = '#####'
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
    object edNumCompte: TPxEdit
      Left = 212
      Top = 108
      Width = 120
      Height = 23
      TabOrder = 5
      OnChange = edFieldChange
      PicString = '*!'
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
    object edCleRIB: TPxEdit
      Left = 344
      Top = 108
      Width = 30
      Height = 23
      TabOrder = 6
      OnChange = edFieldChange
      PicString = '##'
      DlgIncomplete = 'Votre Saisie est Incompl'#232'te'
      DlgError = 'Votre Saisie est Erron'#233'e'
    end
  end
  inherited O_qry: TOracleDataSet
    SQL.Strings = (
      'select id,code,libelle,codebanq,codeguichet,numcompte,clerib '
      'from banqcpte'
      'order by 2')
  end
end
