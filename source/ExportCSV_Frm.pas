unit ExportCSV_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DOAStd_Frm, Oracle, Vcl.StdCtrls,
  Pxedit, Pxdtedit, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, OracleData, LookUdlg;

type
  TFrmExportCSV = class(TFrmDOAStd)
    Panel1: TPanel;
    Label1: TLabel;
    edPeriode: TPXDateEdit;
    btExportRecette: TButton;
    btEXportDepense: TButton;
    qry: TOracleQuery;
    Label2: TLabel;
    Label3: TLabel;
    txtTotalDebit: TLabel;
    txtTotalCredit: TLabel;
    spbInfoTotal: TSpeedButton;
    Label4: TLabel;
    edBanqCpte: TEdit;
    LookupDialog: TLookupDialog;
    qryF1: TOracleDataSet;
    procedure btExportRecetteClick(Sender: TObject);
    procedure btEXportDepenseClick(Sender: TObject);
    procedure edPeriodeChange(Sender: TObject);
    procedure spbInfoTotalClick(Sender: TObject);
    procedure edBanqCpteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
    function ValueAsString(fldname:String):String;

    procedure ExportRecette(const banqcpte:string; d:TDateTime; csv:TStrings);
    procedure ExportDepense(const banqcpte:string; d:TdateTime; csv:TStrings);

  public
    { Déclarations publiques }
  end;

var
  FrmExportCSV: TFrmExportCSV;

implementation
uses ClipBrd;
const
  format_depense='"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'+
                 #9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'+
                 #9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"';
  format_recette='"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"'#9'"%s"';

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmExportCSV.btEXportDepenseClick(Sender: TObject);
//------------------------------------------------------------------------------
var
  banqCpte:String;
  d:TDateTime;
  csv:TStrings;
begin
  inherited;
  if edBanqCpte.Text='' then
    raise Exception.Create('Veuillez saisir un compte bancaire');
  banqCpte:=edBanqCpte.Text;
  if edPeriode.Text='' then
    raise exception.Create('Veuillez saisir une période');
  d:=edPeriode.date;
  csv:=TStringList.Create;
  try
    ExportDepense(banqcpte,d,csv);
    // copie du CSV dans le clipboard;
    clipbrd.Clipboard.AsText:=csv.Text;
    messageDlg('Les dépenses de la période '+formatDateTime('dd.mm.yyyy',d)+' sont copiées',
                mtInformation,[mbOk],0);
  finally
    csv.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmExportCSV.btExportRecetteClick(Sender: TObject);
//------------------------------------------------------------------------------
var
  banqCpte:String;
  d:TDateTime;
  csv:TStrings;
begin
  inherited;
  if edBanqCpte.Text='' then
    raise Exception.Create('Veuillez saisir un compte bancaire');
  banqcpte:=edBanqCpte.Text;
  if edPeriode.Text='' then
    raise exception.Create('Veuillez saisir une période');
  d:=edPeriode.date;
  csv:=TStringList.Create;
  try
    ExportRecette(banqcpte,d,csv);
    // copie du CSV dans le clipboard;
    clipbrd.Clipboard.AsText:=csv.Text;
    messageDlg('Les recettes de la période '+formatDateTime('dd.mm.yyyy',d)+' sont copiées',
                mtInformation,[mbOk],0);
  finally
    csv.Free;
  end;
end;


//------------------------------------------------------------------------------
procedure TFrmExportCSV.edBanqCpteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//------------------------------------------------------------------------------
begin
  inherited;
  if(key=vk_f1) and (shift=[]) then
    begin
      qryF1.Close;
      qryF1.DeleteVariables;
      qryF1.SQL.Text:='select code,libelle from banqcpte where code like :code';
      qryF1.DeclareAndSet('code',otString,edBanqCpte.Text+'%');
      if lookupDialog.Execute then
        edBanqCpte.Text:=qryF1.FieldByName('Code').AsString;
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmExportCSV.edPeriodeChange(Sender: TObject);
//------------------------------------------------------------------------------
begin
  inherited;
  if txtTotalDebit.caption<>'' then begin
    txtTotalDebit.Caption:='';
    txtTotalCredit.Caption:='';
  end;


end;

//------------------------------------------------------------------------------
procedure TFrmExportCSV.ExportDepense(const banqcpte:string; d: TdateTime; csv: TStrings);
//------------------------------------------------------------------------------
var
  line:String;

begin
  qry.Close;
  qry.SQL.Text:='select ddepense,depense_lib,depense_banque,null depense_caisse, '+
                'prelpers,tvarecup,salaire,chargesal,tva,taxepro,entretien,tel,honoraire_ne,primeass, '+
                'voiture,deplace,urssaf,reunica,fmpcampi,cipav,repas,bureau,equipement,loyers,edf,copro,finance '+
                'from table(pkgexportcsvtable.ExportDecompte(:banqcpte,:d)) '+
                'where depense_line is not null';
  qry.DeleteVariables;
  qry.DeclareAndSet('banqcpte',otString,banqcpte);
  qry.DeclareAndSet('d',otDate,d);
  qry.Execute;
  csv.Clear;
  while not qry.EOF do
    begin
      line:=format(format_depense,
                   [formatDateTime('dd/mm/yyyy',qry.FieldAsDate('ddepense')),
                    qry.fieldAsString('depense_lib'),
                    ValueAsString('depense_banque'),
                    ValueAsString('depense_caisse'),
                    ValueAsString('prelpers'),
                    ValueAsString('tvarecup'),
                    ValueAsString('salaire'),
                    ValueAsString('chargesal'),
                    ValueAsString('tva'),
                    ValueAsString('taxepro'),
                    ValueAsString('entretien'),
                    ValueAsString('tel'),
                    ValueAsString('honoraire_ne'),
                    ValueAsString('primeass'),
                    ValueAsString('voiture'),
                    ValueAsString('deplace'),
                    ValueAsString('urssaf'),
                    ValueAsString('reunica'),
                    ValueAsString('fmpcampi'),
                    ValueAsString('cipav'),
                    ValueAsString('repas'),
                    ValueAsString('bureau'),
                    ValueAsString('equipement'),
                    ValueAsString('loyers'),
                    ValueAsString('edf'),
                    ValueAsString('copro'),
                    ValueAsString('finance')]);
      csv.Add(line);
      //ShowMessage(line);
      qry.Next;
    end;

end;


//------------------------------------------------------------------------------
procedure TFrmExportCSV.ExportRecette(const banqcpte:string; d: TDateTime; csv: TStrings);
//------------------------------------------------------------------------------
var
  line:String;

begin
  qry.Close;
  qry.SQL.Text:='select drecette,recette_lib,recette_banque,honoraire_tva,honoraire,recettediv,apport '+
                'from table(pkgexportcsvtable.ExportDecompte(:banqcpte,:d)) '+
                'where recette_line is not null ';
  qry.DeleteVariables;
  qry.DeclareAndSet('banqcpte',otString,banqcpte);
  qry.DeclareAndSet('d',otDate,d);
  qry.Execute;
  csv.Clear;
  while not qry.EOF do
    begin
      line:=format(format_recette,
                   [formatDateTime('dd/mm/yyyy',qry.FieldAsDate('drecette')),
                    qry.fieldAsString('recette_lib'),
                    ValueAsString('recette_banque'),
                    ValueAsString('honoraire_tva'),
                    ValueAsString('recettediv'),
                    ValueAsString('apport')]);
      csv.Add(line);
      //ShowMessage(line);
      qry.Next;
    end;

end;

//------------------------------------------------------------------------------
procedure TFrmExportCSV.spbInfoTotalClick(Sender: TObject);
//------------------------------------------------------------------------------
var
  banqCpte:String;
  d: TDateTime;

begin
  inherited;
  if edBanqCpte.Text='' then
    raise Exception.Create('Veuillez saisir un compte bancaire');
  banqcpte:=edBanqCpte.Text;
  if edPeriode.Text='' then
    raise exception.Create('Veuillez saisir une période');
  d:=edPeriode.date;
  qry.Close;
  qry.SQL.Text:='select sum(depense_banque) totaldebit,sum(recette_banque) totalcredit '+
                'from table(pkgexportcsvtable.ExportDecompte(:banqCpte,:d))';
  qry.DeleteVariables;
  qry.DeclareAndSet('banqcpte',otString,banqCpte);
  qry.DeclareAndSet('d',otDate,d);
  qry.Execute;
  txtTotalDebit.Caption:=FormatFloat('### ### ##0.00',qry.FieldAsFloat('totaldebit'));
  txtTotalCredit.Caption:=FormatFloat('### ### ##0.00',qry.FieldAsFloat('totalcredit'));
end;

//------------------------------------------------------------------------------
function TFrmExportCSV.ValueAsString(fldname: String): String;
//------------------------------------------------------------------------------
begin
  if qry.FieldIsNull(fldName) then result:=''
  else result:=qry.FieldAsString(fldName);
end;

end.
