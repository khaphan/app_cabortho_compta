unit EditEcritures_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DOAEditTBL_Frm, Oracle, Data.DB,
  OracleData, CMENavigat, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, Statlbl, Pxnmedit, Pxedit, Pxdtedit, LookUdlg;

type
  TFrmEditEcritures = class(TFrmDOAEditTBL)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edDEcrit: TPXDateEdit;
    edCheqNum: TPXIntegerEdit;
    edLibelle: TEdit;
    edDebit: TPXFloatEdit;
    edNumCpte: TEdit;
    OracleSession1: TOracleSession;
    O_qryID: TFloatField;
    O_qryDECRIT: TDateTimeField;
    O_qryCHEQNUM: TFloatField;
    O_qryLIBELLE: TWideStringField;
    O_qryNUMCPTE: TWideStringField;
    O_qryETAT: TWideStringField;
    Lookup: TLookupDialog;
    qryF1: TOracleDataSet;
    Label6: TLabel;
    edCredit: TPXFloatEdit;
    O_qryDEBIT: TFloatField;
    O_qryCREDIT: TFloatField;
    O_qryMONTANT: TFloatField;
    Label7: TLabel;
    Label8: TLabel;
    txtTotalDB: TLabel;
    txtTotalCR: TLabel;
    qryTotal: TOracleQuery;
    procedure edNumCpteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edLibelleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function GetMontantIsNull: boolean;
    function GetMontantIsCorrect: Boolean;
    { Déclarations privées }
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

    procedure CheckData (var CheqNum:Variant);
  protected
    function GetMontant:Extended;
    procedure SetMontant(value:Extended);

    procedure RefreshTotal;

    property Montant:Extended read GetMontant write SetMontant;
    property MontantIsNull:boolean read GetMontantIsNull;
    property MontantIsCorrect:Boolean read GetMontantIsCorrect;
  public
    { Déclarations publiques }
    Decompte_id:Integer;
  end;

var
  FrmEditEcritures: TFrmEditEcritures;

implementation

{$R *.dfm}

{ TFrmEditEcritures }
//------------------------------------------------------------------------------
procedure TFrmEditEcritures.CallDeleteStoredProc;
//------------------------------------------------------------------------------
begin
  inherited;
  O_OraProc.CallProcedure('Compta.pkgEcriture.ecriture_delete',[O_Qry.FieldByName('id').asInteger]);
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.ChangeQuery;
//------------------------------------------------------------------------------
begin
  inherited;
  O_Qry.SetVariable('Decompte_id',Decompte_id);
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.CheckData (var CheqNum:Variant);
//------------------------------------------------------------------------------
begin
  if edDEcrit.Text='' then
    raise exception.Create('Veuillez saisir une date d''opération');

  if edLibelle.Text='' then
    raise Exception.Create('Veuillez saisir un libellé');

  if MontantIsNull then
    raise Exception.Create('Veuillez saisir un montant (en débit ou en crédit)');

  if edCheqNum.text='' then  CheqNum:=Null
  else CheqNum:=edCheqNum.Number;

end;

//------------------------------------------------------------------------------
function TFrmEditEcritures.CallInsertStoredProc: variant;
//------------------------------------------------------------------------------
var
  CheqNum:Variant;
begin
  CheckData(CheqNum);
  //function ecriture_add(pdecompte_id number,pdecrit date,pcheqnum  number, plibelle varchar2,pnumcpte varchar2,pMontant number) return number;
  result:=O_oraProc.CallIntegerFunction('compta.pkgEcriture.ecriture_add',
          [Decompte_id,edDEcrit.Date,CheqNum,edLibelle.Text,
           edNumCpte.Text,Montant
          ]);

end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.CallUpdateStoredProc;
//------------------------------------------------------------------------------
var
  CheqNum:Variant;

begin
  inherited;
  CheckData(CheqNum);
  //procedure ecriture_update(pid number,pdecrit date,pcheqnum  number, plibelle varchar2,pnumcpte varchar2,pMontant number);
  O_OraProc.CallProcedure('compta.pkgEcriture.ecriture_update',
      [O_qry.FieldByName('Id').AsInteger,edDEcrit.Date,CheqNum,edLibelle.Text,
       edNumCpte.Text,Montant]);
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.ClearFields;
//------------------------------------------------------------------------------
begin
  inherited;
  edDEcrit.Text:='';
  edCheqNum.Text:='';
  edDebit.Text:='';
  edCredit.Text:='';
  edLibelle.Text:='';
  edNumCpte.Text:='';
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.edLibelleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//------------------------------------------------------------------------------
var
  dref : TDateTime;

begin
  inherited;
  if (key=VK_F1) and (Shift=[]) then
    begin
      qryF1.Close;
      qryF1.SQL.Text:='select LIBELLE,MONTANT,NUMCPTE '+
                      'from table(pkgecrituretable.LastEcrit(:libelle,150,:dref)) '+
                      'Order by 1,2';
      qryF1.DeleteVariables;
      qryF1.DeclareAndSet('libelle',otString,edLibelle.Text+'%');
      if edDEcrit.Text='' then
        qryF1.DeclareAndSet('dref',otDate,date)
      else
        qryF1.DeclareAndSet('dref',otDate,edDEcrit.date);

      qryF1.Open;
      qryF1.FieldByName('Libelle').DisplayWidth:=40;
      LookUp.Width:=600;
      if LookUp.Execute then
        begin
          edLibelle.Text:=qryF1.FieldByName('Libelle').AsString;
          if MontantIsNull then
            Montant:=qryF1.FieldByName('Montant').AsFloat;
          if edNumCpte.Text='' then
            edNumCpte.Text:=qryF1.FieldByName('NumCpte').AsString;
        end;
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.edNumCpteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//------------------------------------------------------------------------------
begin
  if (Key=VK_F1) and (Shift=[]) then
    begin
      qryF1.Close;
      qryF1.SQL.Text:='SELECT NUMCPTE,LIBELLE FROM COMPTA.CPTE '+
                      'WHERE NUMCPTE like :numcpte '+
                      'order by NUMCPTE';
      qryF1.DeleteVariables;
      qryF1.DeclareAndSet('numcpte',otString,edNumCpte.Text+'%');
      qryF1.Open;
      Lookup.Width:=300;
      if Lookup.Execute then
        edNumCpte.Text:=qryF1.FieldByName('numcpte').AsString;
    end;

end;

//------------------------------------------------------------------------------
function TFrmEditEcritures.GetMontant: Extended;
//------------------------------------------------------------------------------
begin
  if MontantIsNull then
    raise Exception.Create('Veuillez saisir un Montant (en débit ou en crédit)');

  if not MontantIsCorrect then
     raise Exception.Create('Veuillez ne pas saisir à la fois un montant en débit et un montant en crédit');
  if edDebit.Text<>'' then
    result:=-edDebit.Number
  else
    result:=edCredit.Number;
end;

//------------------------------------------------------------------------------
function TFrmEditEcritures.GetMontantIsCorrect: Boolean;
//------------------------------------------------------------------------------
begin
  result:=not((edDebit.Text<>'') and (edCredit.Text<>''));
end;

//------------------------------------------------------------------------------
function TFrmEditEcritures.GetMontantIsNull: boolean;
//------------------------------------------------------------------------------
begin
  result:=(edDebit.Text='') and (edCredit.Text='');

end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.LockFieldsOnBrowse;
//------------------------------------------------------------------------------
begin
  inherited;
  edDEcrit.Enabled:=True;
  edCheqNum.Enabled:=True;
  edDebit.Enabled:=True;
  edCredit.Enabled:=True;
  edLibelle.Enabled:=True;
  edNumCpte.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.LockFieldsOnEdit;
//------------------------------------------------------------------------------
begin
  inherited;
  edDEcrit.Enabled:=True;
  edCheqNum.Enabled:=True;
  edDebit.Enabled:=True;
  edCredit.Enabled:=True;
  edLibelle.Enabled:=True;
  edNumCpte.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.LockFieldsOnInactive;
//------------------------------------------------------------------------------
begin
  inherited;
  edDEcrit.Enabled:=False;
  edCheqNum.Enabled:=False;
  edDebit.Enabled:=False;
  edCredit.Enabled:=False;
  edLibelle.Enabled:=False;
  edNumCpte.Enabled:=False;
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.LockFieldsOnInsert;
//------------------------------------------------------------------------------
begin
  inherited;
  edDEcrit.Enabled:=True;
  edCheqNum.Enabled:=True;
  edDebit.Enabled:=True;
  edCredit.Enabled:=True;
  edLibelle.Enabled:=True;
  edNumCpte.Enabled:=True;
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.RefreshTotal;
//------------------------------------------------------------------------------
begin
  qryTotal.Close;
  qryTotal.SetVariable('decompte_id',decompte_id);
  qryTotal.Execute;
  if qryTotal.Eof then
    begin
      txtTotalDB.Caption:='';
      txtTotalCR.Caption:='';
    end
  else
    begin
      txtTotalDB.caption:=FormatFloat('### ### ##0.00',qryTotal.FieldAsFloat('debit'));
      txtTotalCR.caption:=FormatFloat('### ### ##0.00',qryTotal.FieldAsFloat('credit'));
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.SetFields;
//------------------------------------------------------------------------------
begin
  inherited;
  edDEcrit.date:=O_qry.FieldByName('DEcrit').AsDateTime;
  if O_qry.FieldByName('CheqNum').IsNull then edCheqNum.Text:=''
  else edCheqNum.Number:=O_qry.FieldByName('CheqNum').AsInteger;
  edNumCpte.Text:=O_qry.FieldByName('Numcpte').AsString;
  edLibelle.Text:=O_qry.FieldByName('Libelle').AsString;
  Montant:=O_qry.FieldByName('Montant').AsExtended;
  RefreshTotal;
end;

//------------------------------------------------------------------------------
function TFrmEditEcritures.SetFocusOnInsert: TWinControl;
//------------------------------------------------------------------------------
begin
  result:=edDecrit;
end;

//------------------------------------------------------------------------------
function TFrmEditEcritures.SetKeyName: string;
//------------------------------------------------------------------------------
begin
  result:='id';
end;

//------------------------------------------------------------------------------
procedure TFrmEditEcritures.SetMontant(value: Extended);
//------------------------------------------------------------------------------
begin
  if Value>0 then
    begin
      edCredit.Number:=Value;
      edDebit.Text:='';
    end
  else if Value<0 then
    begin
      edCredit.Text:='';
      edDebit.Number:=-Value;
    end
  else
    begin
      edCredit.Text:='';
      edDebit.Text:='';
    end;
end;

end.
