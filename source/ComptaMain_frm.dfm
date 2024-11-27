inherited FrmComptaMain: TFrmComptaMain
  Caption = 'Cabortho : Gestion Comptable'
  PixelsPerInch = 96
  TextHeight = 15
  inherited mnMenu: TMainMenu
    object mnuEditDecomptes: TMenuItem [1]
      Caption = 'Saisie des D'#233'comptes'
      OnClick = mnuEditDecomptesClick
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
