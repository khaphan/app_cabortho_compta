inherited FrmComptaMain: TFrmComptaMain
  Caption = 'Cabortho : Gestion Comptable'
  PixelsPerInch = 96
  TextHeight = 15
  inherited mnMenu: TMainMenu
    object mnuGestion: TMenuItem [1]
      Caption = 'Gestion'
      object mnuEditDecomptes: TMenuItem
        Caption = 'Saisie des D'#233'comptes'
        OnClick = mnuEditDecomptesClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuEditBanqCpte: TMenuItem
        Caption = 'Gestion des Comptes Bancaires'
        OnClick = mnuEditBanqCpteClick
      end
    end
    object mnuExport: TMenuItem [2]
      Caption = 'Export'
      OnClick = mnuExportClick
    end
  end
  inherited oraSession: TOracleSession
    LogonUsername = 'compta'
    LogonPassword = 'hippie'
    LogonDatabase = 'XE'
    Connected = True
  end
  inherited Login: TDOAUniqueUserLogin
    Appli = 'COMPTA'
    Session = oraSession
    Left = 464
  end
end
