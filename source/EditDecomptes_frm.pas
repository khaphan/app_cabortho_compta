unit EditDecomptes_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DOAEditTBL_Frm, Vcl.StdCtrls, Pxedit,
  Pxdtedit, Oracle, Data.DB, OracleData, CMENavigat, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Buttons, Statlbl;

type
  TfrmEditDecomptes = class(TFrmDOAEditTBL)
    Label1: TLabel;
    Label2: TLabel;
    edPeriode: TPXDateEdit;
    edLibelle: TEdit;
    OracleSession1: TOracleSession;
    spbEditEcritures: TSpeedButton;
//    procedure edFieldChange(Sender: TObject);
    procedure spbEditEcrituresClick(Sender: TObject);
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
    [edPeriode.date,edLibelle.Text])
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
procedure TfrmEditDecomptes.CheckData;
//------------------------------------------------------------------------------
var
  dd,mm,yy:Word;
  mois:String;
begin
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
  edPeriode.Text:='';
  edLibelle.Text:='';
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnBrowse;
//------------------------------------------------------------------------------
begin
  inherited;
  edPeriode.Enabled:=True;
  edLibelle.Enabled:=True;
  spbEditEcritures.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnEdit;
//------------------------------------------------------------------------------
begin
  inherited;
  edPeriode.Enabled:=True;
  edLibelle.Enabled:=True;
  spbEditEcritures.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnInactive;
//------------------------------------------------------------------------------
begin
  inherited;
  edPeriode.Enabled:=False;
  edLibelle.Enabled:=False;
  spbEditEcritures.Enabled:=False;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.LockFieldsOnInsert;
//------------------------------------------------------------------------------
begin
  inherited;
  edPeriode.Enabled:=True;
  edLibelle.Enabled:=True;
  spbEditEcritures.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TfrmEditDecomptes.SetFields;
//------------------------------------------------------------------------------
begin
  inherited;
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
