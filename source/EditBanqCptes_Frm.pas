unit EditBanqCptes_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DOAEditTBL_Frm, Oracle, Data.DB,
  OracleData, CMENavigat, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, Statlbl, Pxedit;

type
  TFrmEditBanqCptes = class(TFrmDOAEditTBL)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edCode: TEdit;
    edLibelle: TEdit;
    edCodeBanq: TPxEdit;
    edCodeGuichet: TPxEdit;
    edNumCompte: TPxEdit;
    edCleRIB: TPxEdit;
    procedure edFieldChange(Sender: TObject);
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
  FrmEditBanqCptes: TFrmEditBanqCptes;

implementation

{$R *.dfm}

{ TFrmEditBanqCptes }
//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.CallDeleteStoredProc;
//------------------------------------------------------------------------------
begin
  inherited;
  raise Exception.Create('Not implemented');
end;

//------------------------------------------------------------------------------
function TFrmEditBanqCptes.CallInsertStoredProc: variant;
//------------------------------------------------------------------------------
begin
  checkData;
  result:=O_OraProc.CallIntegerFunction('compta.pkgBanqCpte.BanqCpte_add',
    [edCode.Text,edLibelle.Text,edCodeBanq.Text,edCodeGuichet.Text,edNumCompte.Text,edCleRIB.Text]);
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.CallUpdateStoredProc;
//------------------------------------------------------------------------------
begin
  inherited;
  checkData;
  O_OraProc.CallProcedure('compta.pkgBanqCpte.BanqCpte_update',
    [O_qry.FieldByName('id').AsInteger,
    edCode.Text,edLibelle.Text,edCodeBanq.Text,edCodeGuichet.Text,edNumCompte.Text,edCleRIB.Text]);
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.CheckData;
//------------------------------------------------------------------------------
begin
  if edCode.Text='' then
    raise Exception.Create('Code BanqCpte obligatoire');
  if edCodeBanq.Text='' then
    raise Exception.Create('code banque obligatoire');
  if edCodeGuichet.Text='' then
    raise Exception.Create('code guichet obligatoire');
  if edNumCompte.Text='' then
    raise Exception.Create('N° de compte obligatoire');
  if edCleRIB.Text='' then
    raise Exception.Create('Clé RIB obligatoire');
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.ClearFields;
//------------------------------------------------------------------------------
begin
  inherited;
  edCode.Text:='';
  edLibelle.Text:='';
  edCodeBanq.Text:='';
  edCodeGuichet.Text:='';
  edNumCompte.Text:='';
  edCleRIB.Text:='';
end;

procedure TFrmEditBanqCptes.edFieldChange(Sender: TObject);
begin
  inherited;

end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.LockFieldsOnBrowse;
//------------------------------------------------------------------------------
begin
  inherited;
  edCode.enabled:=True;
  edLibelle.enabled:=True;
  edCodeBanq.enabled:=True;
  edCodeGuichet.enabled:=True;
  edNumCompte.enabled:=True;
  edCleRIB.enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.LockFieldsOnEdit;
//------------------------------------------------------------------------------
begin
  inherited;
  edCode.enabled:=True;
  edLibelle.enabled:=True;
  edCodeBanq.enabled:=True;
  edCodeGuichet.enabled:=True;
  edNumCompte.enabled:=True;
  edCleRIB.enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.LockFieldsOnInactive;
//------------------------------------------------------------------------------
begin
  inherited;
  edCode.enabled:=False;
  edLibelle.enabled:=False;
  edCodeBanq.enabled:=False;
  edCodeGuichet.enabled:=False;
  edNumCompte.enabled:=False;
  edCleRIB.enabled:=False;
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.LockFieldsOnInsert;
//------------------------------------------------------------------------------
begin
  inherited;
  edCode.enabled:=True;
  edLibelle.enabled:=True;
  edCodeBanq.enabled:=True;
  edCodeGuichet.enabled:=True;
  edNumCompte.enabled:=True;
  edCleRIB.enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TFrmEditBanqCptes.SetFields;
//------------------------------------------------------------------------------
begin
  inherited;
  edCode.Text:=O_qry.FieldByName('code').AsString;
  edLibelle.Text:=O_qry.FieldByName('Libelle').AsString;;
  edCodeBanq.Text:=O_qry.FieldByName('CodeBanq').AsString;;
  edCodeGuichet.Text:=O_qry.FieldByName('codeguichet').AsString;;
  edNumCompte.Text:=O_qry.FieldByName('numcompte').AsString;;
  edCleRIB.Text:=O_qry.FieldByName('clerib').AsString;;
end;

//------------------------------------------------------------------------------
function TFrmEditBanqCptes.SetFocusOnInsert: TWinControl;
//------------------------------------------------------------------------------
begin
  result:=edCode;
end;

//------------------------------------------------------------------------------
function TFrmEditBanqCptes.SetKeyName: string;
//------------------------------------------------------------------------------
begin
  result:='ID';
end;

end.
