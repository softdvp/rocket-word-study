(*
		This Source Code Form is subject to the terms of the MIT
		License.

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit dictionaries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes, Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,FireDAC.Stan.Param, IOUtils,
  Vcl.DBCtrls, System.ImageList, Vcl.ImgList, RegularExpressions, JvDialogs,
  Vcl.ExtDlgs, Vcl.ComCtrls, Ex_Grid, Ex_DBGrid, System.Actions, Vcl.ActnList, ACS_DXAudio,
  JvComponentBase, JvAppHotKey;

const
  IsChecked : array[Boolean] of Integer =
      (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
  CtrlState: array [boolean] of integer =
     (DFCS_BUTTONCHECK,DFCS_BUTTONCHECK
      or DFCS_CHECKED);


type
  TfrmDict = class(TForm)
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnClose: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    RadioGroup1: TRadioGroup;
    rbAll: TRadioButton;
    rbSelected: TRadioButton;
    rbNotSelected: TRadioButton;
    Panel4: TPanel;
    btnSelectAll: TButton;
    btnUselectAll: TButton;
    btnApply: TButton;
    Label1: TLabel;
    edFilter: TEdit;
    imgDict: TImageList;
    sbSound: TSpeedButton;
    dlgExport: TSaveTextFileDialog;
    dlgImport: TOpenTextFileDialog;
    sbDict: TStatusBar;
    Panel5: TPanel;
    btnImport: TButton;
    btnExport: TButton;
    btnDelAllDict: TButton;
    btnDelStats: TButton;
    dbgWords: TDBGridView;
    actDict: TActionList;
    dbgDict: TDBGridView;
    btnDel: TBitBtn;
    sbDel: TSpeedButton;
    Panel6: TPanel;
    lbTranscript: TLabel;
    tmrSelectWord: TTimer;
    btnClear: TBitBtn;
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
    procedure btnApplyClick(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure CloseDict;
    procedure edFilterChange(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnUselectAllClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure sbSoundClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDelAllDictClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure dbgDictCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDelStatsClick(Sender: TObject);
    procedure dbgWordsCheckClick(Sender: TObject; Cell: TGridCell);
    procedure dbgWordsGetCheckState(Sender: TObject; Cell: TGridCell;
      var CheckState: TCheckBoxState);
    procedure dbgWordsCellClick(Sender: TObject; Cell: TGridCell;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgWordsCellAcceptCursor(Sender: TObject; Cell: TGridCell;
      var Accept: Boolean);
    procedure dbgWordsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgWordsDblClick(Sender: TObject);
    procedure hkSoundHotKey(Sender: TObject);
    procedure dbgDictColEnter(Sender: TObject);
    procedure dbgDictKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDictCellAcceptCursor(Sender: TObject; Cell: TGridCell;
      var Accept: Boolean);
    procedure sbDelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SetFilter;
    procedure tmrSelectWordTimer(Sender: TObject);
    procedure dbgWordsHeaderClick(Sender: TObject; Section: TGridHeaderSection);
    procedure dbgWordsGetSortDirection(Sender: TObject;
      Section: TGridHeaderSection; var SortDirection: TGridSortDirection);

  private
    LastWord : string;
    toClose:boolean;
    FSortColumn:integer;
    FSortDirection: TGridSortDirection;
    function GetWordFilterStr: string;
    function GetSelectedFilter: string;
    procedure SelectWords(Sel: boolean);
    procedure ImportRwsFile;
    procedure ImportCvsFile;
    procedure ExportRwsFile(Sl:TStringList; delimiter:char);
    procedure ExportCvsFile(Sl:TStringList; delimiter:char);
    function GetTranslationFilterStr: string;
    procedure CheckedNum;
    procedure RowNo;
    { Private declarations }
  public
    { Public declarations }
    procedure Scroll;
  end;

var
  frmDict: TfrmDict;

implementation

{$R *.dfm}

uses dmmain, main;

procedure TfrmDict.btnApplyClick(Sender: TObject);
begin
  with dm do
  begin
    if qrWords.State in [dsInsert, dsEdit]  then
      qrWords.Post;

    CurrDict:=qrDict.FieldByName('ID').AsInteger;
    CurrWord:=qrWords.FieldByName('ID').AsInteger;

    qrOptions.Edit;
    qrOptions.FieldByName('DICTIONARY').AsInteger :=CurrDict;
    qrOptions.FieldByName('LASTWORD').AsInteger := CurrWord;
    qrOptions.Post;

    MainForm.SetMainPanel;
    CommitRetaining;
    toClose:=true;
  end;
end;

procedure TfrmDict.btnOkClick(Sender: TObject);
begin
  btnApplyClick(Sender);
end;

procedure TfrmDict.CloseDict;
var
  DlgResult: TModalResult;
begin
  if dm.isTransChanged then
  begin
    DlgResult:=MessageDlg('Would you like to save the changes?', mtConfirmation, [mbNo, mbYes, mbCancel], 0, mbCancel);

    case DlgResult of
      mrYes:btnApplyClick(nil);
      mrNo:
        with dm do
        begin
          if qrWords.State in [dsInsert, dsEdit]  then
            qrWords.Cancel;
          if qrDict.State in [dsInsert, dsEdit]  then
            qrDict.Cancel;

          RollbackRetaining;

          CurrDict:=qrDict.FieldByName('ID').AsInteger;
          CurrWord:=qrWords.FieldByName('ID').AsInteger;

          qrOptions.Edit;
          qrOptions.FieldByName('DICTIONARY').AsInteger := CurrDict;
          qrOptions.FieldByName('LASTWORD').AsInteger := CurrWord;
          qrOptions.Post;

          MainForm.SetMainPanel;
          CommitRetaining;

          qrDict.Refresh;
          qrWords.Refresh;

          toClose:=true;
        end;

      mrCancel:toClose:=false;
    end
  end
  else
  with dm do
  begin
    CurrDict:=qrDict.FieldByName('ID').AsInteger;
    CurrWord:=qrWords.FieldByName('ID').AsInteger;

    qrOptions.Edit;
    qrOptions.FieldByName('DICTIONARY').AsInteger := CurrDict;
    qrOptions.FieldByName('LASTWORD').AsInteger := CurrWord;
    qrOptions.Post;

    MainForm.SetMainPanel;
    CommitRetaining;

    qrDict.Refresh;
    qrWords.Refresh;

    toClose:=true;
  end;
end;

procedure TfrmDict.btnClearClick(Sender: TObject);
begin
  edFilter.Text:='';
end;

procedure TfrmDict.btnDelClick(Sender: TObject);
begin

  if MessageDlg('Would you like to delete the dictionary?', mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
    with dm do
    begin
      qrMisc.SQL.Text:='DELETE FROM WORDS WHERE DICTID=:ID';
      qrMisc.ParamByName('ID').AsString:=qrDict.FieldByName('ID').AsString;
      qrMisc.ExecSQL;

      qrDict.Delete;
    end;
end;

procedure TfrmDict.btnDelStatsClick(Sender: TObject);
begin
  if MessageDlg('Do you want to clear the statistics of dictioanary?',
    mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
    with dm do
    begin
      qrMisc.SQL.Text:='UPDATE WORDS SET STATE=0, DATETIME=NULL, REPEATWORD=0, REPEATTRANS=0, MISTAKE=0'+
        ' WHERE DICTID=:ID';
      qrMisc.ParamByName('ID').AsInteger:=qrDict['ID'];
      qrMisc.ExecSQL;

      btnOk.Enabled:=true;
      btnApply.Enabled:=true;
    end;
end;

procedure TfrmDict.ExportCvsFile;
var
  s, s1, s2, Res:string;
begin
  with dm do
  begin
    try
      qrExport.Open;

      while not qrExport.Eof do
      begin
        s:=qrExport['WORD'];
        s1:=qrExport.FieldByName('TRANSCRIPTION').AsString;
        s2:=qrExport['TRANSLATION'];
        Res:=s+delimiter+s1+delimiter+s2;

        Sl.Add(Res);

        qrExport.Next
      end;
    finally
      qrExport.Close
    end;
  end;
end;

procedure TfrmDict.ExportRwsFile;
var
  s, s1, s2, Res:string;
begin
  with dm do
  begin
    try
      qrExport.Open;

      while not qrExport.Eof do
      begin
        s:=qrExport['WORD'];
        s1:=qrExport['TRANSLATION'];
        s2:=qrExport.FieldByName('TRANSCRIPTION').AsString;
        Res:=s+delimiter+s1;

        if s2<>'' then Res:=Res+delimiter+s2;

        Sl.Add(Res);

        qrExport.Next
      end;
    finally
      qrExport.Close;
    end;
  end;
end;

procedure TfrmDict.btnExportClick(Sender: TObject);
var
  FileName:string;
  EncIndex: Integer;
  Encoding: TEncoding;
  Sl: TStringList;
  EncodingArray: array[0..5] of TEncoding;
begin
  dlgExport.Title:='Export dictionary '+dm.qrDict['NAME'];
  dlgExport.FileName:=dm.qrDict['NAME'];

  if dlgExport.Execute then
  begin
    Filename := dlgExport.FileName;

    if FileExists(Filename) then
      if MessageDlg('File already exists. Rewrite it?',
        mtConfirmation, [mbNo, mbYes], 0, mbYes)=mrNo then exit;

    Sl:=TStringList.Create;

    try
      try

        case dlgExport.FilterIndex of
          1: ExportRwsFile(Sl, #9);
          2: ExportCvsFile(Sl, '|');
          3: ExportRwsFile(Sl, '|');
        end;

        (*
        UTF-8
        UTF-7
        Unicode
        ANSI
        Big Endian Unicode
        ASCII
        *)

        EncodingArray[0]:= TEncoding.UTF8;
        EncodingArray[1]:= TEncoding.UTF7;
        EncodingArray[2]:= TEncoding.Unicode;
        EncodingArray[3]:= TEncoding.ANSI;
        EncodingArray[4]:= TEncoding.BigEndianUnicode;
        EncodingArray[5]:= TEncoding.ASCII;

        EncIndex := dlgExport.EncodingIndex;
        Encoding := EncodingArray[EncIndex];

        if dlgExport.FilterIndex=3 then
          Encoding:=TEncoding.Unicode;

        Sl.SaveToFile(FileName, Encoding);

      except

      end;

    finally
      Sl.Free;
    end;
  end;
end;

procedure TfrmDict.ImportRwsFile;
var
  SS, Splitted:TStringList;
  LastDictID: LargeInt;
  s, s1, s2, fn: string;
  i:integer;
  NextS, SQL:String;
  Encoding : TEncoding;
  EncIndex : Integer;
  EncodingArray: array[0..5] of TEncoding;
begin
  SS:=TStringList.Create;
  Splitted:=TStringList.Create;

  (*
  UTF-8
  UTF-7
  Unicode
  ANSI
  Big Endian Unicode
  ASCII
  *)

  EncodingArray[0]:= TEncoding.UTF8;
  EncodingArray[1]:= TEncoding.UTF7;
  EncodingArray[2]:= TEncoding.Unicode;
  EncodingArray[3]:= TEncoding.ANSI;
  EncodingArray[4]:= TEncoding.BigEndianUnicode;
  EncodingArray[5]:= TEncoding.ASCII;

  EncIndex := dlgImport.EncodingIndex;
  Encoding := EncodingArray[EncIndex];

  try
    try
      SS.LoadFromFile(dlgImport.FileName, Encoding);

      with dm do
      begin
        qrWords.DisableControls;
        qrDict.DisableControls;

        fn:=ExtractFileName(dlgImport.FileName);
        qrDicImport.ParamByName('NAME').AsString:=ChangeFileExt(fn, '');
        qrDicImport.ExecSQL;
        LastDictID:=GetLastInsertRowID;

        for i:= 0 to SS.Count-1 do
        begin
          try
            NextS:=SS[i];

            NextS:=StringReplace(NextS, '''', 'ʹ', [rfReplaceAll, rfIgnoreCase]);
            NextS:=StringReplace(NextS, '"', '""', [rfReplaceAll, rfIgnoreCase]);

            Splitted.Clear;

            ExtractStrings([#9],[], PChar(NextS), Splitted);

            if Splitted.Count<2 then continue;

            s:=Splitted[0];
            s1:=Splitted[1];

            if Splitted.Count>2 then
              s2:=Splitted[2]
            else s2:=' ';

            if (trim(s1)<>'') then
            begin
              SQL:='INSERT INTO WORDS(DICTID, WORD, TRANSLATION, TRANSCRIPTION) VALUES (:DICTID, ":WORD", ":TRANSLATION", ":TRANSCRIPTION")';
              SQL:=StringReplace(SQL, ':DICTID', IntToStr(LastDictID), []);
              SQL:=StringReplace(SQL, ':WORD', s,[]);
              SQL:=StringReplace(SQL, ':TRANSLATION', s1, []);
              SQL:=StringReplace(SQL, ':TRANSCRIPTION', s2, []);
              qrWordImport.ExecSql(SQL);
            end;
          except
          end;
        end;

        qrDict.Refresh;
        qrDict.Locate('ID', LastDictID,[]);
        qrOptions.Edit;
        qrOptions.FieldByName('DICTIONARY').AsInteger:=LastDictID;
        qrOptions.Post;
        qrWords.EnableControls;
        qrDict.EnableControls;
      end;

    except

    end;

  finally
    SS.Free;
    Splitted.Free;
  end;
end;

procedure TfrmDict.ImportCvsFile;
var
  SS, Splitted:TStringList;
  LastDictID: LargeInt;
  s, s1, s2, fn: string;
  i:integer;
  NextS, SQL:String;
  Encoding : TEncoding;
  EncIndex : Integer;
  EncodingArray: array[0..5] of TEncoding;

begin
  SS:=TStringList.Create;
  Splitted:=TStringList.Create;

  (*
  UTF-8
  UTF-7
  Unicode
  ANSI
  Big Endian Unicode
  ASCII
  *)

  EncodingArray[0]:= TEncoding.UTF8;
  EncodingArray[1]:= TEncoding.UTF7;
  EncodingArray[2]:= TEncoding.Unicode;
  EncodingArray[3]:= TEncoding.ANSI;
  EncodingArray[4]:= TEncoding.BigEndianUnicode;
  EncodingArray[5]:= TEncoding.ASCII;

  EncIndex := dlgImport.EncodingIndex;
  Encoding := EncodingArray[EncIndex];
  try
    try

      SS.LoadFromFile(dlgImport.FileName, Encoding);

      with dm do
      begin
        fn:=ExtractFileName(dlgImport.FileName);
        qrDicImport.ParamByName('NAME').AsString:=ChangeFileExt(fn, '');
        qrDicImport.ExecSQL;
        LastDictID:=GetLastInsertRowID;

        for i:= 0 to SS.Count-1 do
        begin
          try
            NextS:=SS[i];

            NextS:=StringReplace(NextS, '''', 'ʹ', [rfReplaceAll, rfIgnoreCase]);
            NextS:=StringReplace(NextS, '"', '""', [rfReplaceAll, rfIgnoreCase]);

            Splitted.Clear;

            ExtractStrings([#9, ',', '|'], [], PChar(NextS), Splitted);

            if Splitted.Count<2 then continue;

            s:=Splitted[0];
            s1:=Splitted[1];

            if Length(s1)>100 then continue;

            if Splitted.Count>2 then
              s2:=Splitted[2]
            else s2:=' ';

            if (trim(s2)<>'')  then
            begin
              SQL:='INSERT INTO WORDS(DICTID, WORD, TRANSLATION, TRANSCRIPTION) VALUES (:DICTID, ":WORD", ":TRANSLATION", ":TRANSCRIPTION")';

              SQL:=StringReplace(SQL, ':DICTID', IntToStr(LastDictID), []);
              SQL:=StringReplace(SQL, ':WORD', s,[]);
              SQL:=StringReplace(SQL, ':TRANSLATION', s2, []);
              SQL:=StringReplace(SQL, ':TRANSCRIPTION', s1, []);
              qrWordImport.ExecSql(SQL);
            end;
          except

          end;

         end;

        qrDict.Refresh;
        qrDict.Locate('ID', LastDictID,[]);
        qrOptions.Edit;
        qrOptions.FieldByName('DICTIONARY').AsInteger:=LastDictID;
        qrOptions.Post;
      end;

    except

    end;

  finally
    SS.Free;
    Splitted.Free;
  end;

end;

procedure TfrmDict.btnImportClick(Sender: TObject);
begin

  if dlgImport.Execute then
    if FileExists(dlgImport.FileName) then
    begin
      case dlgImport.FilterIndex of
      1: ImportRwsFile;
      2: ImportCvsFile;
      end;

      btnOk.Enabled:=true;
      btnApply.Enabled:=true;
    end;
end;

procedure TfrmDict.btnSelectAllClick(Sender: TObject);
begin
  if MessageDlg('Would you like to select all words?', mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
    SelectWords(true);

end;

procedure TfrmDict.btnUselectAllClick(Sender: TObject);
begin
  if MessageDlg('Would you like to deselect all words?', mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
    SelectWords(false);
end;

procedure TfrmDict.btnDelAllDictClick(Sender: TObject);
begin
  if MessageDlg('Would you like to delete all dictionaries?', mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
    with dm do
    begin
      qrMisc.SQL.Text:='DELETE FROM WORDS';
      qrMisc.ExecSQL;
      qrMisc.SQL.Text:='delete from sqlite_sequence where name=''WORDS''';
      qrMisc.ExecSQL;

      qrMisc.SQL.Text:='DELETE FROM DICTIONARIES';
      qrMisc.ExecSQL;
      qrMisc.SQL.Text:='delete from sqlite_sequence where name=''DICTIONARIES''';
      qrMisc.ExecSQL;

      qrWords.Close;
      qrWords.Open;

      qrDict.Close;
      qrDict.Open;
    end;
end;

procedure TfrmDict.dbgDictCellAcceptCursor(Sender: TObject; Cell: TGridCell;
  var Accept: Boolean);
begin
  lbTranscript.Caption:='';
  CheckedNum
end;

procedure TfrmDict.dbgDictCellClick(Column: TColumn);
begin
  with dm do
  begin
    CurrDict:=qrDict['ID'];
    CurrWord:=qrWords.FieldByName('ID').AsInteger;
  end;

  CheckedNum;
end;

procedure TfrmDict.dbgDictColEnter(Sender: TObject);
begin
  CheckedNum
end;

procedure TfrmDict.dbgDictKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CheckedNum
end;

procedure TfrmDict.CheckedNum;
begin
  with dm do
  begin
      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1';
      qrMisc.Params[0].AsInteger:=qrDict['ID'];
      qrMisc.Open;
      sbDict.Panels[0].Text:=IntToStr(qrMisc['CNT']);

      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID';
      qrMisc.Params[0].AsInteger:=qrDict['ID'];
      qrMisc.Open;
      sbDict.Panels[2].Text:=IntToStr(qrMisc['CNT']);

  end;

end;

procedure TfrmDict.RowNo;
var
  SI: TScrollInfo;
begin
  ZeroMemory(@SI,SizeOf(SI));
  SI.cbSize := SizeOf(SI);
  SI.fMask := SIF_ALL;
  GetScrollInfo(dbgWords.Handle, SB_VERT, SI);

  sbDict.Panels[1].Text:=IntToStr(SI.nPos);
end;

procedure TfrmDict.sbDelClick(Sender: TObject);
begin
  if MessageDlg('Would you like to delete the selected word?', mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
    with dm do
    begin
      qrWords.Delete;
      CheckedNum;
    end;

end;

procedure TfrmDict.dbgWordsCellAcceptCursor(Sender: TObject; Cell: TGridCell;
  var Accept: Boolean);
var
  word: string;
begin
  RowNo;
end;

procedure TfrmDict.dbgWordsCellClick(Sender: TObject; Cell: TGridCell;
  Shift: TShiftState; X, Y: Integer);
begin
  Scroll
end;

procedure TfrmDict.Scroll;
var
  word, s: string;
begin
  RowNo;
  word:=dm.qrWords.FieldByName('WORD').AsString;
  LastWord:=word;

  s:= dm.qrWords.FieldByName('TRANSCRIPTION').AsString;

  if Trim(s)<>'' then
    lbTranscript.Caption:='['+s+']'
    else lbTranscript.Caption:='';

  if (not MainForm.AudioBusy) and dbgWords.Focused then
    MainForm.StartPronounce(word);

  dm.DoPron:=false;
end;


procedure TfrmDict.dbgWordsCheckClick(Sender: TObject; Cell: TGridCell);
begin
  with dm do
  begin
    qrWords.Edit;
    qrWords['SELECTED']:=not qrWords['SELECTED'];
    qrWords.Post;
  end;

  CheckedNum;
end;

procedure TfrmDict.dbgWordsDblClick(Sender: TObject);
begin
  with dm do
  begin
    qrWords.Edit;
    qrWords['SELECTED']:=not qrWords['SELECTED'];
    qrWords.Post;

    //dbgWords.InvalidateCell(GridCell(0, Cell.Row));
  end;
end;

procedure TfrmDict.dbgWordsGetCheckState(Sender: TObject; Cell: TGridCell;
  var CheckState: TCheckBoxState);
var FieldVal:boolean;
begin
//
  FieldVal := dm.qrWords['SELECTED'];
  if Cell.Col = 0 then
  begin
    if FieldVal then
      CheckState := cbChecked
    else CheckState := cbUnchecked
  end;

end;


procedure TfrmDict.dbgWordsGetSortDirection(Sender: TObject;
  Section: TGridHeaderSection; var SortDirection: TGridSortDirection);
begin
  if Section.ColumnIndex=1 then
    SortDirection := FSortDirection;
end;

procedure TfrmDict.dbgWordsHeaderClick(Sender: TObject;
  Section: TGridHeaderSection);
begin
  if Section.ColumnIndex=1 then
  begin
    if FSortDirection=gsNone then
      FSortDirection:=gsAscending
    else FSortDirection:=gsNone;

    dbgWords.InvalidateHeader;

    with dm do
    begin
      CurrWord:=dm.qrWords['ID'];

      qrWords.Close;

      if FSortDirection=gsAscending then
        qrWords.IndexFieldNames:='WORD; TRANSLATION'
      else qrWords.IndexFieldNames:='';

      qrWords.Open;
      qrWords.Locate('ID', CurrWord, []);
    end;

    dbgWords.InvalidateGrid;
  end;

end;

procedure TfrmDict.dbgWordsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  word:string;
begin

  case Key of
    VK_Down :
    begin
      dm.DoPron:=true;
    end;

    VK_Up :
    begin
      dm.DoPron:=true;
    end;
  end;
end;

procedure TfrmDict.edFilterChange(Sender: TObject);
begin
  lbTranscript.Caption:='';
  SetFilter;
end;

procedure TfrmDict.FormActivate(Sender: TObject);
begin
  btnOk.Enabled:=false;
  CheckedNum;

  with dm do
  begin
    qrDict.Locate('ID', CurrDict,[]);
    qrWords.Locate('ID', CurrWord, []);
  end;
end;

procedure TfrmDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDict;
  btnOk.Enabled:=false;
end;

procedure TfrmDict.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CloseDict;
  CanClose:=toClose;
end;

procedure TfrmDict.FormCreate(Sender: TObject);
var CurrDir:string;
begin
  dm.qrWords.Close;
  dm.qrWords.IndexFieldNames:='';
  dm.qrWords.Open;
  dbgWords.InvalidateGrid;


  CurrDir:=GetCurrentDir;
  dlgImport.InitialDir:=CurrDir+'\Dictionaries';

  dbgWords.Columns[2].Width:=dbgWords.Width-dbgWords.Columns[0].Width-dbgWords.Columns[1].Width-40;
end;

procedure TfrmDict.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2:
      if not MainForm.AudioBusy then
        MainForm.StartPronounce(LastWord);
  end;

end;

procedure TfrmDict.rbAllClick(Sender: TObject);
begin
  SetFilter
end;

function TfrmDict.GetWordFilterStr:string;
var
  s: string;
  sz: integer;
begin
  s:=trim(edFilter.Text);

  if Trim(s)<>'' then
  begin
    sz:=length(s);
    Result:='SUBSTR(WORD, 1, '+IntToStr(sz)+')='+Q+s+Q;
  end
  else
    Result:='';
end;

procedure TfrmDict.hkSoundHotKey(Sender: TObject);
begin
(*      if not MainForm.AudioBusy then
        MainForm.StartPronounce(LastWord);*)
end;

function TfrmDict.GetTranslationFilterStr:string;
var
  s: string;
  sz: integer;
begin
  s:=trim(edFilter.Text);

  if Trim(s)<>'' then
  begin
    sz:=length(s);
    Result:='SUBSTR(TRANSLATION, 1, '+IntToStr(sz)+')='+Q+s+Q;
  end
  else
    Result:='';
end;

function TfrmDict.GetSelectedFilter:string;
begin
  if rbSelected.Checked then
    Result:='SELECTED=TRUE';
  if rbNotSelected.Checked then
    Result:='SELECTED=FALSE';
  if rbAll.Checked then
    Result:='';
end;

procedure TfrmDict.SetFilter;
var
  s, s1 :string;

  procedure SetDictFilter(f:string);
  begin
    with dm do
    begin
      if (s='') and (f='') then
        qrWords.Filtered:=false
      else
      begin
        if f='' then
        begin
          qrWords.Filter:=s;
        end
        else
          if s<>'' then
            qrWords.Filter:=s+' AND '+ f
          else
            qrWords.Filter:=f;

        qrWords.Filtered:=true;
      end;
    end;
  end;

begin
  s:=GetSelectedFilter;
  s1:=GetWordFilterStr;

  SetDictFilter(s1);

    if dm.qrWords.Eof then
    begin
      s1:=GetTranslationFilterStr;
      SetDictFilter(s1);
    end;
end;

procedure TfrmDict.tmrSelectWordTimer(Sender: TObject);
var s:string;
begin
  if not Visible then exit;

  s:= dm.qrWords.FieldByName('TRANSCRIPTION').AsString;

  tmrSelectWord.Enabled:=false;
  LastWord:=dm.qrWords.FieldByName('WORD').AsString;

  if Trim(s)<>'' then
    lbTranscript.Caption:='['+s+']'
    else lbTranscript.Caption:='';

  sbSoundClick(nil);
end;

procedure TfrmDict.sbSoundClick(Sender: TObject);
begin

  if not MainForm.AudioBusy then
    MainForm.StartPronounce(LastWord);
end;

procedure TfrmDict.SelectWords(Sel:boolean);
begin
  with dm do
  begin
    qrSelectWords.Params[0].AsBoolean:=Sel;
    qrSelectWords.ParamByName('ID').AsString:=qrDict.FieldByName('ID').AsString;

    qrWords.DisableControls;
    qrSelectWords.ExecSQL;
    qrWords.Refresh;
    qrWords.EnableControls;
    CheckedNum;
  end;
end;

end.


