unit ComptaMain_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DOAMain_Frm, login, Oracle, Profile,
  Vcl.Menus;

type
  TFrmComptaMain = class(TFrmDOAMain)
    mnuEditDecomptes: TMenuItem;
    mnuExport: TMenuItem;
    mnuGestion: TMenuItem;
    N3: TMenuItem;
    mnuEditBanqCpte: TMenuItem;
    procedure mnuEditDecomptesClick(Sender: TObject);
    procedure mnuExportClick(Sender: TObject);
    procedure mnuEditBanqCpteClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure LockAllMenuBeforeConnect; override;
    procedure UnlockMenuOnSuccessfulConnect; override;
    procedure LockMenuOnUnsuccessfulConnect; override;
    //procedure SetRights; override;
    //procedure SetMenusFroIni; override;
    procedure LoadProfile (Profile:TProfile); override;

  end;

var
  FrmComptaMain: TFrmComptaMain;

implementation
uses EditBanqCptes_Frm,EditDecomptes_frm,ExportCSV_Frm;
{$R *.dfm}

{ TFrmComptaMain }
//------------------------------------------------------------------------------
procedure TFrmComptaMain.LoadProfile(Profile: TProfile);
//------------------------------------------------------------------------------
begin
  inherited;
  if oraSession.Connected then oraSession.LogOff;
  Profile.FileName:=ChangeFileExt(ParamStr(0),'.ini');
  with Profile do begin
    Section:='Oracle';
    Entry:='Databasename';
    login.DatabaseName:=Text;
    Entry:='dbUserName';
    login.dbUser:=Text;
    Entry:='dbPassword';
    login.dbPassword:=Text;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmComptaMain.LockAllMenuBeforeConnect;
//------------------------------------------------------------------------------
begin
  inherited;
  mnuEditDecomptes.Enabled:=False;
end;

//------------------------------------------------------------------------------
procedure TFrmComptaMain.LockMenuOnUnsuccessfulConnect;
//------------------------------------------------------------------------------
begin
  inherited;
  mnuEditDecomptes.Enabled:=False;
end;

//------------------------------------------------------------------------------
procedure TFrmComptaMain.mnuEditBanqCpteClick(Sender: TObject);
//------------------------------------------------------------------------------

begin
  inherited;
  with TFrmEditBanqCptes.Create(self) do
    try
      ChangeOracleSession(self.oraSession);
      ShowModal;
    finally
      Free;
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmComptaMain.mnuEditDecomptesClick(Sender: TObject);
//------------------------------------------------------------------------------
begin
  inherited;
  with TFrmEditDecomptes.Create(self) do
    try
      ChangeOracleSession(self.oraSession);
      ShowModal;
    finally
      Free;
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmComptaMain.mnuExportClick(Sender: TObject);
//------------------------------------------------------------------------------
begin
  inherited;
  with TFrmExportCSV.Create(self) do
    try
      ChangeOracleSession(self.oraSession);
      ShowModal;
    finally
      Free;
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmComptaMain.UnlockMenuOnSuccessfulConnect;
//------------------------------------------------------------------------------
begin
  inherited;
  mnuEditDecomptes.Enabled:=True;
end;

end.
