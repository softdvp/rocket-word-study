(*
		This Source Code Form is subject to the terms of the MIT
		License.

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit dmmain;

//Regular expressions to export CSV files.
// \t?(?:(?:"((?:[^"]|"")*)")|([^\t]*))
// (\t|\t\s)*?(.*?)(\t|$)

//[^(\t]+(?:\([^)]+\)){0,2}[^)\t]*
//[^,]+\((?:[^()]{0,}|(?R))*\)|[^(,\n]+  -  PCRE



{$IFDEF DEBUG}
{$DEFINE TEST}
{$ENDIF}

interface

uses
  System.SysUtils, System.Classes, Forms, Dialogs, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, JvCsvData, FireDAC.Phys.MSAccDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSAcc, JvTimer;

const
  QCQ = #39#44#39;
  QC  = #39#44;
  CQ  = #44#39;
  C   = #44;
  Q   = #39;

  rs_MyAppPublisher='Rocket Technologies';
  rs_MyAppName='Rocket Word Study';


  {$IFDEF TEST}
  db_file='test.db';
  {$ELSE}
  db_file='rws.db';
  {$ENDIF}

  g_MsClickSound='mouseclick.ogg';

  g_Learning=100;
  g_Studied=101;
  g_Passed=102;

type
  Tdm = class(TDataModule)
    fdLink: TFDPhysSQLiteDriverLink;
    fdcRWS: TFDConnection;
    qrDict: TFDQuery;
    dsDict: TDataSource;
    qrWords: TFDQuery;
    dsWords: TDataSource;
    qrDicImport: TFDQuery;
    qrWordImport: TFDQuery;
    qrOptions: TFDQuery;
    qrLevels: TFDQuery;
    dsOptions: TDataSource;
    dsLevels: TDataSource;
    qrSelectWords: TFDQuery;
    qrStudy: TFDQuery;
    qrRepeat: TFDQuery;
    qrMaxLevel: TFDQuery;
    qrMisc: TFDQuery;
    qrTest: TFDQuery;
    qrStudyPassed: TFDQuery;
    qrExport: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure dsWordsDataChange(Sender: TObject; Field: TField);
    procedure qrWordsAfterScroll(DataSet: TDataSet);
    procedure qrOptionsAfterDelete(DataSet: TDataSet);
    procedure qrOptionsAfterPost(DataSet: TDataSet);
    procedure qrLevelsAfterDelete(DataSet: TDataSet);
    procedure qrLevelsAfterPost(DataSet: TDataSet);
    procedure qrDictAfterDelete(DataSet: TDataSet);
    procedure qrDictAfterPost(DataSet: TDataSet);
    procedure qrWordsAfterDelete(DataSet: TDataSet);
    procedure qrWordsAfterPost(DataSet: TDataSet);
    procedure fdcRWSAfterCommit(Sender: TObject);
    procedure fdcRWSAfterRollback(Sender: TObject);
    procedure qrDictBeforeScroll(DataSet: TDataSet);
    procedure qrDictAfterScroll(DataSet: TDataSet);
  private
     OldFilter:string;
  public
    CurrDict, CurrWord: integer;
    DoPron:boolean;
    isTransChanged:boolean;
    function GetLastInsertRowID: Int64;
    procedure CommitRetaining;
    procedure RollbackRetaining;
  end;

var
  dm: Tdm;
  g_Commondocs: string;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ShellFileSupport, dictionaries, main;

{$R *.dfm}
procedure Tdm.CommitRetaining;
begin
  fdcRWS.Commit;
  fdcRWS.StartTransaction;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  db:string;
begin
  if fdcRWS.Connected=true
  then begin
    ShowMessage('DB connected!');
    Application.Terminate;
  end
  else
  begin
    g_Commondocs := Get_Special_Folder(CSIDL_COMMON_DOCUMENTS)
    + '\' + rs_MyAppPublisher + '\' + rs_MyAppName + '\';

    db := db_file;

    if not FileExists(db) then
      db:=g_Commondocs+db_file;

    fdcRWS.Params.Database:=db;
    fdcRWS.Connected:=true;
    fdcRWS.StartTransaction;

    qrDict.Open;
    qrWords.Open;
    qrOptions.Open;
    qrLevels.Open;

    CurrDict:=qrOptions.FieldByName('DICTIONARY').AsInteger;
    CurrWord:=qrOptions.FieldByName('LASTWORD').AsInteger;

    qrDict.Locate('ID', CurrDict,[]);

    if Trim(qrOptions.FieldByName('SoundLib').AsString)='' then
    begin
      qrOptions.Edit;
      qrOptions['SoundLib']:='\English(US)';
      qrOptions.Post;
    end;
  end;
end;

procedure Tdm.dsWordsDataChange(Sender: TObject; Field: TField);
begin
(*
  if frmDict<>Nil then
    frmDict.dbgWordsCellClick(Nil);*)
end;

procedure Tdm.fdcRWSAfterCommit(Sender: TObject);
begin
  isTransChanged:=false;

  if (frmDict.btnApply<>Nil)  then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.fdcRWSAfterRollback(Sender: TObject);
begin
  isTransChanged:=false;

  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

function Tdm.GetLastInsertRowID: Int64;
begin
  Result := Int64(fdcRWS.GetLastAutoGenValue(''));
end;

procedure Tdm.qrDictAfterDelete(DataSet: TDataSet);
begin
  isTransChanged:=true;
  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrDictAfterPost(DataSet: TDataSet);
begin
  isTransChanged:=true;
  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrDictAfterScroll(DataSet: TDataSet);
begin
  if frmDict<>nil then
  begin
    frmDict.edFilter.Text:=OldFilter;
    frmDict.SetFilter;
  end;
end;

procedure Tdm.qrDictBeforeScroll(DataSet: TDataSet);
begin
  if frmDict<>nil then
  begin
    OldFilter:=trim(frmDict.edFilter.Text);
    frmDict.edFilter.Text:='';

    frmDict.SetFilter;
  end;
end;

procedure Tdm.qrLevelsAfterDelete(DataSet: TDataSet);
begin
  isTransChanged:=true;
  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrLevelsAfterPost(DataSet: TDataSet);
begin
  isTransChanged:=true;
  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrOptionsAfterDelete(DataSet: TDataSet);
begin
  isTransChanged:=true;
  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrOptionsAfterPost(DataSet: TDataSet);
begin
  isTransChanged:=true;
  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrWordsAfterDelete(DataSet: TDataSet);
begin
  isTransChanged:=true;

  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrWordsAfterPost(DataSet: TDataSet);
begin
  isTransChanged:=true;

  if frmDict<>Nil then
    frmDict.btnApply.Enabled:=isTransChanged;
end;

procedure Tdm.qrWordsAfterScroll(DataSet: TDataSet);
begin
  if (frmDict<>nil) and frmDict.Active then
  with frmDict do
  begin
    if DoPron then
      Scroll
    else
    begin

      tmrSelectWord.Enabled:=false;
      tmrSelectWord.Enabled:=true;
    end;
  end;

end;

procedure Tdm.RollbackRetaining;
begin
  fdcRWS.Rollback;
  fdcRWS.StartTransaction;
end;

end.
