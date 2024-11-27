program CabOrthoCompta;

uses
  Vcl.Forms,
  DOAMain_Frm in '..\..\..\ref\source\DOAMain_Frm.pas' {FrmDOAMain},
  ComptaMain_frm in '..\source\ComptaMain_frm.pas' {FrmComptaMain},
  EditDecomptes_frm in '..\source\EditDecomptes_frm.pas' {frmEditDecomptes},
  PHK_Frm in '..\..\..\ref\source\PHK_Frm.pas' {FrmPHK},
  DOAEditTBL_Frm in '..\..\..\ref\source\DOAEditTBL_Frm.pas' {FrmDOAEditTBL},
  EditEcritures_frm in '..\source\EditEcritures_frm.pas' {FrmEditEcritures},
  DOAStd_Frm in '..\..\..\ref\source\DOAStd_Frm.pas' {FrmDOAStd},
  ExportCSV_Frm in '..\source\ExportCSV_Frm.pas' {FrmExportCSV},
  FRMLOGIN in '..\..\..\base\source\FRMLOGIN.PAS' {frmConnect},
  LOGIN in '..\..\..\base\source\LOGIN.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmComptaMain, FrmComptaMain);
  Application.CreateForm(TfrmConnect, frmConnect);
  Application.Run;
end.
