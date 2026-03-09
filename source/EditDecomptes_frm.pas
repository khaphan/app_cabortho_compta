unit EditDecomptes_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DOAEditTBL_Frm, Vcl.StdCtrls, Pxedit,
  Pxdtedit, Oracle, Data.DB, OracleData, CMENavigat, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Buttons, Statlbl, LookUdlg;

type
  TfrmEditDecomptes = class(TFrmDOAEditTBL)
    Label1: TLabel;
    Label2: TLabel;
    edPeriode: TPXDateEdit;
    edLibelle: TEdit;
    OracleSession1: TOracleSession;
    spbEditEcritures: TSpeedButton;
    Label3: TLabel;
    edBanqCpte: TEdit;
    qryF1: TOracleDataSet;
    LookupDlg: TLookupDialog;
    Label4: TLabel;
    edSrchBanqCpte: TEdit;
//    procedure edFieldChange(Sender: TObject);
    procedure spbEditEcrituresClick(Sender: TObject);
    procedure edBanqCpteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edFieldChange(Sender: TObject);
    procedure edSrchBanqCpteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
    procedure CheckData;

  protected
    function SetKeyName:string; override;
    procedure SetFields; override;
    procedure ClearFields; override;
    procedure LockFieldsOnInactive; override;
    procedure LockFieldsOnBrowse; override;
    procedure LockFieldsOnEdit; override;
    procedure LockFieldsOnInsert; override;
    function CallInsertStoredProc : variant; override;
    procedure CallUpdateStoredProc; override;
    procedure CallDeleteStoredProc; override;

    function SetFocusOnInsert:TWinControl; override;

    procedure ChangeQuery; override;
  public
    { Déclarations publiques }
  end;

var
  frmEditDecomptes: TfrmEditDecomptes;

implementation
uses EditEcritures_frm;

{$R *.dfm}

{ TFrmDOAEditTBL2 }
//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.CallDeleteStoredProc;
//------------------------------------------------------------------------------
begin
  inherited;
  O_OraProc.CallProcedure('compta.pkgDecompte.decompte_delete',[O_qry.FieldByName('ID').AsInteger]);
end;

//------------------------------------------------------------------------------
function TfrmEditDecomptes.CallInsertStoredProc: variant;
//------------------------------------------------------------------------------
begin
  CheckData;
  result:=O_OraProc.CallIntegerFunction('compta.pkgDecompte.decompte_add',
    [edBanqCpte.Text,edPeriode.date,edLibelle.Text])
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.CallUpdateStoredProc;
//------------------------------------------------------------------------------
begin
  inherited;
  CheckData;
  O_OraProc.CallProcedure('compta.pkgDecompte.decompte_update',
    [O_qry.FieldByName('ID').AsInteger,edPeriode.date,edLibelle.Text]);
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.ChangeQuery;
//------------------------------------------------------------------------------
begin
  inherited;
  O_qry.Close;
  O_qry.DeleteVariables;
  O_qry.SQL.Text:='select d.id,bc.Code banqcpte,periode,d.libelle,to_char(d.periode,''MM-YYYY'') periode_lib '+
                  'from compta.decompte d, compta.BanqCpte bc '+
                  'where bc.id=d.banqCpte_id ';
  if edSrchBanqCpte.Text<>'' then
    begin
      O_qry.SQL.Add('and bc.code like :code');
      O_qry.DeclareAndSet('code',otString,edSrchBanqCpte.Text+'%');
    end;
  O_qry.SQL.Add('order by 3 desc,2');
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.CheckData;
//------------------------------------------------------------------------------
var
  dd,mm,yy:Word;
  mois:String;
begin
  if edBanqCpte.Text='' then
    raise Exception.Create('Compte Bancaire obligatoire');

  if edPeriode.Text='' then
    raise exception.Create('Veuillez définir la periode du décompte');
  if edLibelle.Text='' then
    begin
      decodeDate(edPeriode.date,yy,mm,dd);

      case mm of
        1 : mois:='Janvier';
        2 : mois:='Février';
        3 : mois:='Mars';
        4 : mois:='Avril';
        5 : mois:='Mai';
        6 : mois:='Juin';
        7 : mois:='Juillet';
        8 : mois:='Août';
        9 : mois:='Septembre';
        10 : mois:='Octobre';
        11 : mois:='Novembre';
        12 : mois:='Décembre';
      end;

      edLibelle.Text:='Décompte de '+mois+' '+IntToStr(YY);
    end;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.ClearFields;
//------------------------------------------------------------------------------
begin
  inherited;
  edBanqCpte.Text:='';
  edPeriode.Text:='';
  edLibelle.Text:='';
end;
//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.edBanqCpteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//------------------------------------------------------------------------------
begin
  inherited;
  if (key=vk_F1) and (shift=[]) then
    begin
      qryF1.Close;
      qryF1.DeleteVariables;
      qryF1.SQL.Text:='SELECT code BanqCpte,Libelle from compta.BanqCpte '+
                      'where code like :code order by 1';
      qryF1.DeclareAndSet('code',otString,edBanqCpte.Text+'%');
      qryF1.Open;
      if LookupDlg.Execute then
        edBanqCpte.Text:=qryF1.FieldByName('BanqCpte').AsString;
    end;
end;

procedure TfrmEditDecomptes.edFieldChange(Sender: TObject);
begin
  inherited;

end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.edSrchBanqCpteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//------------------------------------------------------------------------------
begin
  inherited;
  if (key=vk_F1) and (shift=[]) then
    begin
      qryF1.Close;
      qryF1.DeleteVariables;
      qryF1.SQL.Text:='SELECT code BanqCpte,Libelle from compta.BanqCpte '+
                      'where code like :code order by 1';
      qryF1.DeclareAndSet('code',otString,edSrchBanqCpte.Text+'%');
      qryF1.Open;
      if LookupDlg.Execute then
        edSrchBanqCpte.Text:=qryF1.FieldByName('BanqCpte').AsString;
    end;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnBrowse;
//------------------------------------------------------------------------------
begin
  inherited;
  edBanqCpte.Enabled:=False;
  edPeriode.Enabled:=True;
  edLibelle.Enabled:=True;
  spbEditEcritures.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnEdit;
//------------------------------------------------------------------------------
begin
  inherited;
  edBanqCpte.Enabled:=False;
  edPeriode.Enabled:=True;
  edLibelle.Enabled:=True;
  spbEditEcritures.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnInactive;
//------------------------------------------------------------------------------
begin
  inherited;
  edBanqCpte.Enabled:=False;
  edPeriode.Enabled:=False;
  edLibelle.Enabled:=False;
  spbEditEcritures.Enabled:=False;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnInsert;
//------------------------------------------------------------------------------
begin
  inherited;
  edBanqCpte.Enabled:=True;
  edPeriode.Enabled:=True;
  edLibelle.Enabled:=True;
  spbEditEcritures.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.SetFields;
//------------------------------------------------------------------------------
begin
  inherited;
  edBanqCpte.Text:=O_qry.FieldByName('banqcpte').AsString;
  edPeriode.date:=O_qry.FieldByName('periode').AsDateTime;
  edLibelle.Text:=O_qry.FieldByName('Libelle').AsString;
end;

//------------------------------------------------------------------------------
function TfrmEditDecomptes.SetFocusOnInsert: TWinControl;
//------------------------------------------------------------------------------
begin
  result:=edPeriode;
end;

//------------------------------------------------------------------------------
function TfrmEditDecomptes.SetKeyName: string;
//------------------------------------------------------------------------------
begin
  result:='ID';
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.spbEditEcrituresClick(Sender: TObject);
//------------------------------------------------------------------------------
begin
  inherited;
  if self.TblStatus in [dsEdit,dsInsert] then
    nav.BtnClick(cmeNavigat.nbPost);

  with TFrmEditEcritures.create(self) do
    try
      Decompte_id:=self.qry.FieldByName('Id').AsInteger;
      ChangeOracleSession(self.Osession);
      ShowModal;

    finally
      Free;
    end;
end;

end.
