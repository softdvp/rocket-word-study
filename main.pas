(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Math, Vcl.Graphics,
  DateUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, System.Generics.Collections, Data.Db,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, JclFileUtils, JvTimer, ACS_Classes, NewACDSAudio, ACS_Vorbis, ShellFileSupport,
  Vcl.AppEvnts, JvExComCtrls, JvComCtrls, JvTabBar, JvPageList, JvExControls, UITypes,
  Vcl.Imaging.pngimage, ACS_DXAudio;

type

  TStudyMode=(FullStudy, FrontStudy, BackStudy);

  TMainForm = class(TForm)
    mnuMain: TMainMenu;
    Dictionary1: TMenuItem;
    Mode1: TMenuItem;
    Options1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    alMain: TActionList;
    actDict: TAction;
    actOptions: TAction;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    imgMain: TImageList;
    actLearn: TAction;
    ToolButton3: TToolButton;
    sbMain: TStatusBar;
    ToolButton4: TToolButton;
    actRepeat: TAction;
    actStudy: TAction;
    actStop: TAction;
    ToolButton5: TToolButton;
    actRepetition: TAction;
    tmrTimeout: TJvTimer;
    tmrPause: TJvTimer;
    viOgg: TVorbisIn;
    dsOut: TDSAudioOut;
    Continue1: TMenuItem;
    Repeat1: TMenuItem;
    apeMain: TApplicationEvents;
    tmrSleep: TJvTimer;
    plMain: TJvPageList;
    pge1: TJvStandardPage;
    pge2: TJvStandardPage;
    pnlOk: TPanel;
    btnOk: TButton;
    pnlMain: TPanel;
    lblWord: TLabel;
    lblTranslate: TLabel;
    lblTranscript: TLabel;
    Panel1: TPanel;
    llStudy: TLinkLabel;
    llRepeat: TLinkLabel;
    llDict: TLinkLabel;
    llSettings: TLinkLabel;
    tmrMain: TJvTimer;
    ToolButton6: TToolButton;
    actSound: TAction;
    actStudyOmitted: TAction;
    StudyOmitWordsAgain1: TMenuItem;
    actSpritz: TAction;
    Spritz1: TMenuItem;
    tmrPass: TTimer;
    llStudyAgain: TLinkLabel;
    Image1: TImage;
    actLearned: TAction;
    ppMain: TPopupMenu;
    Markwordaslearned1: TMenuItem;
    tmrEnableActn: TTimer;
    procedure actDictExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
    procedure actRepeatExecute(Sender: TObject);
    procedure tmrMainTimer(Sender: TObject);
    procedure actLearnExecute(Sender: TObject);
    procedure actStudyExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actStopExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actRepetitionExecute(Sender: TObject);
    procedure tmrPauseTimer(Sender: TObject);
    procedure tmrTimeoutTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure pnlMainClick(Sender: TObject);
    procedure btnOkKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure apeMainShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: Vcl.Controls.THintInfo);
    procedure apeMainDeactivate(Sender: TObject);
    procedure tmrSleepTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure llStudyLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure llRepeatLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure llDictLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure llSettingsLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure ToolButton6Click(Sender: TObject);
    procedure actSoundExecute(Sender: TObject);
    procedure tmrPassTimer(Sender: TObject);
    procedure actStudyOmittedExecute(Sender: TObject);
    procedure llStudyAgainLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure dsOutDone(Sender: TComponent);
    procedure actLearnedExecute(Sender: TObject);
    procedure actLearnedUpdate(Sender: TObject);
    procedure ppMainPopup(Sender: TObject);
    procedure ppMainClose(Sender: TObject);
    procedure tmrStudiedTimer(Sender: TObject);
    procedure tmrEnableActnTimer(Sender: TObject);
    procedure dsOutProgress(Sender: TComponent);
  private
    Countdown, NextLevel, MaxLevel: integer;
    FullStudyMode, isCountdown, isProcess, isAbort,
    isTimeout, isPause, isFrontShown, isPassed, isStudied: boolean;

    IDList: TList<Integer>;
    WordList:TStringList;

    StudyState, fStudiedAll,
    fChecked, fTotal, fStudied,
    fStudying, fErrors, PronounceWord:integer;

    LastTranslation:string;

    procedure SetDictionary(s:string);
    procedure SetStudiedAll(v:integer);
    procedure SetChecked(v:integer);
    procedure SetTotal(v:integer);
    procedure SetStudied(v:integer);
    procedure SetStudying(v:integer);
    procedure SetErrors(v:integer);

    procedure StartCountdown;
    procedure ShowCountdown(i: integer);
    procedure StartStudy;
    procedure RunCountdown;
    procedure ShowFullCard(Query: TFDQuery);
    procedure ShowWord(Query: TFDQuery);
    procedure ShowTranslate(Query: TFDQuery);
    procedure ShowTranscript(Query: TFDQuery);
    procedure StudyFullCard;
    procedure StudyOneSide;
    procedure ClearCard;
    procedure SetStudyNextLevel(Query: TFDQuery);
    procedure StudyFrontCard(Query: TFDQuery);
    procedure Run;
    procedure Stop;
    procedure RepeatOneSide;
    function RandomId: integer;
    procedure RepeatFrontBack(Query: TFDQuery);
    procedure ResetStats(Query: TFDQuery);
    procedure SetRepeatNextLevel(Query: TFDQuery);
    procedure StudyBackCard(Query: TFDQuery);

  public
    SoundBusy: boolean;
    property Dictionary:string write SetDictionary;
    property Total:integer write SetTotal;
    property Checked:integer write SetChecked;
    property StudiedAll:integer read fStudiedAll write SetStudiedAll;
    property Studied:integer read fStudied write SetStudied;
    property Studying:integer read fStudying write SetStudying;
    property Errors:integer read fErrors write SetErrors;
    procedure Pronounce(word:string);
    procedure PronounceWords(words: string);

    procedure SetMainPanel;
    procedure NextCard;
    function TranslByNum(s:string; n:integer):string;
end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses options, dictionaries, dmmain, about, stoprepeat, stopstudy, allstudy,
  passstudy;

procedure TMainForm.actDictExecute(Sender: TObject);
begin
  frmDict.ShowModal
end;

procedure TMainForm.actLearnedExecute(Sender: TObject);
var
  Id, Idx:integer;
begin
  with dm do
  begin
    if plMain.ActivePageIndex=0 then
    begin
      isStudied:=true;
      (btnOk.Action as TAction).Enabled:=true;

      if btnOk.Action=actStudy then
      begin
        if FullStudyMode then
        begin
          tmrPass.Enabled:=false;
          btnOk.Action.Execute;
        end
        else
        begin
          qrStudy.Edit;
          qrStudy['STATE']:=g_Studied;
          qrStudy['REPEATWORD']:=0;
          qrStudy['REPEATTRANS']:=0;
          qrStudy.Post;

          if IDList.Count>0 then
          begin
            Id:=qrStudy['ID'];
            Idx:=IDList.IndexOf(ID);
            if(Idx>=0) then
              IDList.Delete(Idx);
          end;
          btnOk.Action.Execute;
        end;
      end
      else
      if btnOk.Action=actRepetition then
      begin
          tmrTimeout.Enabled:=false;
          tmrPause.Enabled:=false;

          qrRepeat.Edit;
          qrRepeat['STATE']:=g_Studied;
          qrRepeat['REPEATWORD']:=0;
          qrRepeat['REPEATTRANS']:=0;
          qrRepeat.Post;

          if IDList.Count>0 then
          begin
            Id:=qrRepeat['ID'];
            Idx:=IDList.IndexOf(ID);
            if(Idx>=0) then
              IDList.Delete(Idx);
          end;
          btnOk.Action.Execute;
      end;
    end;
  end;

end;

procedure TMainForm.actLearnedUpdate(Sender: TObject);
begin
  actLearned.Enabled:=(btnOk.Action<>nil) and (plMain.ActivePageIndex=0);
(*  if (btnOk.Action<>nil) and (plMain.ActivePageIndex=0) then
    Self.PopupMenu:=ppMain
  else
    Self.PopupMenu:=nil;*)
end;

procedure TMainForm.actLearnExecute(Sender: TObject);
var
  t:integer;
begin
  with dm do
  begin

    qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE=0';
    qrMisc.Open;

    if qrMisc['CNT']=0 then
    begin
      //ShowMessage('All words are studied!');

      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE='+
        IntToStr(g_Passed);
      qrMisc.Open;

      if qrMisc['CNT']>0 then
      begin
        dlgPassStudy.ShowModal;
        exit;
      end;

      dlgAllStudy.ShowModal;
      exit;
    end;
  end;

  StudyState:=0;
  IsAbort:=false;
  t:=dm.qrOptions['OMITTIME']*1000;
  tmrPass.Interval:=t;
  StartStudy;
end;

procedure TMainForm.actOptionsExecute(Sender: TObject);
begin
  frmOptions.ShowModal;
end;

procedure TMainForm.actRepeatExecute(Sender: TObject);
begin

  with dm do
  begin
    qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE<>'+IntToStr(g_Studied);
    qrMisc.Open;

    if qrMisc['CNT']=0 then
    begin
      ShowMessage('All words are studied and repeated!'+#13#10+'Please select another dictionary');
      exit;
    end;

    qrRepeat.ParamByName('DICTID').AsInteger:=qrOptions['DICTIONARY'];
    qrRepeat.Open;

    if not qrRepeat.Eof then
    begin
      IsAbort:=false;
      plMain.ActivePageIndex:=0;
      StartCountdown;
    end
    else
    begin
      Stop;
      with dlgStopRepeat do
      begin
        Caption:='There are not any words to repeat';
        ShowModal;
      end;
    end;
  end;
end;

procedure TMainForm.StartStudy;
begin
  if IsAbort then exit;

  case StudyState of
    1: StudyFullCard;
    0, 2:StudyOneSide;
    3: begin
         isAbort:=true;
         Stop;
         with dlgStopStudy do
         begin
           ShowModal;
         end;
       end;
  end;

end;

procedure TMainForm.StartCountdown;
begin
  isCountdown:=true;
  pnlMain.PopupMenu:=nil;
  Countdown:=dm.qrOptions.FieldByName('COUNTDOWN').AsInteger;
  actDict.Enabled:=false;
  actOptions.Enabled:=false;
  actLearn.Enabled:=false;
  actStudyOmitted.Enabled:=false;
  actRepeat.Enabled:=false;
  actStop.Enabled:=true;

  ShowCountdown(Countdown);
  tmrMain.Interval:=1000;
  tmrMain.Enabled:=true;
end;

procedure TMainForm.tmrEnableActnTimer(Sender: TObject);
var
  Actn:TAction;
begin
  tmrEnableActn.Enabled:=false;

  Actn:=(btnOk.Action as TAction);

  if Actn<>nil then
  begin
    Actn.Enabled:=true;

    if not IsStudied then
    begin
      if (Actn=actStudy) and FullStudyMode then
        tmrPass.Enabled:=true;

      if Actn=actRepetition then
      begin
        if not isTimeout then
          tmrTimeout.Enabled:=true;

        if not isPause  then
          tmrPause.Enabled:=true;
      end;
    end;
  end;

  isStudied:=false;
end;

procedure TMainForm.tmrMainTimer(Sender: TObject);
begin
  if isCountdown then
  begin
    RunCountdown;
    exit;
  end;

  tmrMain.Enabled:=false;
  pnlMain.PopupMenu:=ppMain;

  if not isAbort then
    RepeatOneSide;
end;

procedure TMainForm.tmrPassTimer(Sender: TObject);
begin
  isPassed:=true;
  tmrPass.Enabled:=false;
  actStudy.Execute;
end;

procedure TMainForm.tmrPauseTimer(Sender: TObject);
begin
  isPause:=true;
  tmrPause.Enabled:=false;
end;

procedure TMainForm.tmrSleepTimer(Sender: TObject);
begin
  tmrSleep.Enabled:=false;
end;

procedure TMainForm.tmrStudiedTimer(Sender: TObject);
begin
  btnOk.Action.Execute;
end;

procedure TMainForm.tmrTimeoutTimer(Sender: TObject);
begin
  isTimeout:=true;
  tmrTimeout.Enabled:=false;
  ClearCard;
  ShowFullCard(dm.qrRepeat);
end;

procedure TMainForm.ToolButton6Click(Sender: TObject);
begin
  dm.qrTest.ExecSql;
end;

function TMainForm.TranslByNum(s: string; n: integer): string;
var
  Splitted:TStringList;
  num: integer;
begin

  Splitted:=TStringList.Create;

  try
    ExtractStrings([';',','],[], PChar(s), Splitted);

    if Splitted.Count=0 then 
    begin
      Result:='';
    end
    else
    begin
      num:=min(Splitted.Count, n);
      if num<1 then num:=1;
      
      Result:=Splitted[num-1];
    end;
  finally
    Splitted.Free;
  end;
end;

procedure TMainForm.SetTotal(v: integer);
begin
  fTotal:=v;
  sbMain.Panels[3].Text:=IntToStr(v);
end;

procedure TMainForm.ShowCountdown(i:integer);
begin
  lblWord.Caption:='Countdown started:  '+IntToStr(i+1);
end;

function TMainForm.RandomId:integer;
var
  Idx, Id:integer;
begin
  if IdList.Count>0 then
  begin
    Randomize;
    Idx:=Random(IdList.Count);
    Id:=IdList[Idx];
    Result:=Id;
  end
  else
    Result:=-1;
end;

procedure TMainForm.ResetStats;
var
  tm, lvl: Variant;
  Times, MaxMistakes, Mistakes: integer;
begin
  MaxMistakes:=dm.qrOptions['MISTAKES'];
  Mistakes:=Query['MISTAKE'];

  Query.Edit;

  if Mistakes>=MaxMistakes then
  begin
    if Query['STATE']<>g_Studied then
      Query['STATE']:=1;
    Query['MISTAKE']:=0;
    lvl:=1;
  end
  else begin
    lvl:=Query['STATE'];
    Query['MISTAKE']:=Mistakes+1;
  end;

  tm:=dm.qrLevels.Lookup('ID', 1, 'TIMES');

  if (VarType(tm)<>varNull) and (VarType(tm)<>varEmpty)then
  begin
    Times:=tm;

    Query['REPEATWORD']:=Times;
    Query['REPEATTRANS']:=Times;
    Query['DATETIME']:=Now;
    Errors:=Errors+1;
  end;

  Query.Post;
end;

procedure TMainForm.StudyFullCard;
begin
  with dm do
  begin
    if qrOptions.FieldByName('DICTIONARY').AsInteger=0 then
    begin
      ShowMessage('Please click menu item Dictionary and select a dictionary');
      exit
    end;

    qrStudy.ParamByName('DICTID').AsInteger:=qrOptions['DICTIONARY'];
    qrStudy.ParamByName('STATE').AsInteger:=0;
    qrStudy.ParamByName('LIMIT').AsInteger:=qrOptions.FieldByName('WORDS').AsInteger;

    Studying:=qrOptions.FieldByName('WORDS').AsInteger;
    Studied:=0;
    Errors:=0;

    qrStudy.Open;

    if not qrStudy.Eof then
    begin
      FullStudyMode:=true;
      btnOk.Action:=actStudy;
      Run;
      tmrPass.Enabled:=false;
      tmrPass.Enabled:=true;
      ClearCard;
      ShowFullCard(qrStudy)
    end
    else
    begin
      Stop;
      Inc(StudyState);
      StartStudy;
    end;
  end
end;

procedure TMainForm.SetStudying(v: integer);
begin
  fStudying:=v;
  sbMain.Panels[5].Text:=IntToStr(v);
end;

procedure TMainForm.RepeatOneSide;
var
  Id, CurLevel: integer;

begin
  Run;
  btnOk.Action:=actRepetition;

  with dm do
  begin
    IdList.Clear;

    Studying:=0;
    Studied:=0;
    Errors:=0;

    tmrPause.Interval:=qrOptions['INACTIVETIME']*1000;
    tmrTimeout.Interval:=qrOptions['TIMEANSWER']*1000;

    isTimeout:=false;
    isPause:=false;

    if qrOptions.FieldByName('DICTIONARY').AsInteger=0 then
    begin
      ShowMessage('Please click menu item Dictionary and select a dictionary');
      exit
    end;

    qrRepeat.ParamByName('DICTID').AsInteger:=qrOptions['DICTIONARY'];
    qrRepeat.Open;

    if not qrRepeat.Eof then
    begin
      repeat
        Id:=qrRepeat['Id'];
        IdList.Add(Id);
        qrRepeat.Next;
      until qrRepeat.Eof;

      IdList.Sort;
      Studying:=IdList.Count;
      Studied:=0;
      Errors:=0;

      Id:=RandomId;

      if Id>=0 then
      begin
        qrRepeat.Locate('ID', Id);
        qrMaxLevel.Open;
        MaxLevel:= qrMaxLevel['MAXID'];
        qrMaxLevel.Close;
        CurLevel:=qrRepeat['STATE'];

        if CurLevel=MaxLevel then
          CurLevel:=g_Studied   //Studied
        else CurLevel:=CurLevel+1;

        NextLevel:=CurLevel;
        RepeatFrontBack(qrRepeat)
      end;
    end
    else
    begin
      Stop;

      with dlgStopRepeat do
      begin
        Caption:='There are not any words to repeat';
        ShowModal;
      end;
    end;
  end;
end;

procedure TMainForm.StudyOneSide;
var
  Id, DictId:integer;
begin
  Run;

  FullStudyMode:=false;
  btnOk.Action:=actStudy;

  with dm do
  begin
    IdList.Clear;

    if qrOptions.FieldByName('DICTIONARY').AsInteger=0 then
    begin
      ShowMessage('Please click menu item Dictionary and select a dictionary');
      exit
    end;

    DictId:=qrOptions['DICTIONARY'];
    qrStudy.ParamByName('DICTID').AsInteger:=DictId;
    qrStudy.ParamByName('STATE').AsInteger:=g_learning;
    qrStudy.ParamByName('LIMIT').AsInteger:=100000;
    qrStudy.Open;

    if not qrStudy.Eof then
    begin
      repeat
        Id:=qrStudy['Id'];
        IdList.Add(Id);
        qrStudy.Next;
      until qrStudy.Eof;

      IdList.Sort;

      Studying:=IdList.Count;
      Studied:=0;
      Errors:=0;

      Id:=RandomId;


      if Id>=0 then
      begin
        qrStudy.Locate('ID', Id);
        isFrontShown:=true;
        StudyFrontCard(qrStudy);
    end;
    end
    else
    begin
      Stop;
      Inc(StudyState);
      StartStudy;
    end;

  end;
end;

procedure TMainForm.RepeatFrontBack;
var
  timest, timesw: integer;
begin
  timest:=Query['REPEATTRANS'];
  timesw:=Query['REPEATWORD'];

  if (timest>=timesw) then
  begin
    ClearCard;
    ShowTranslate(Query)
  end
  else
    if timesw>0 then
    begin
      ClearCard;
      ShowTranscript(Query);
      ShowWord(Query);
    end
    else
      ShowMessage('Error: REPEATTRANS=0 and REPEATWORD=0');

  tmrTimeout.Enabled:=true;
  tmrPause.Enabled:=true;
end;

procedure TMainForm.StudyFrontCard;
var
  timest, timesw: integer;
begin
  try
    if isAbort then exit;
    if not Query.Active then exit;

    pnlMain.Color:=clWindow;
    timest:=Query['REPEATTRANS'];
    timesw:=Query['REPEATWORD'];

    if (timest>=timesw) then
    begin
      ClearCard;
      ShowTranslate(Query)
    end
    else
    begin
      if timesw>0 then
      begin
        ClearCard;
        ShowTranscript(Query);
        ShowWord(Query);
      end
      else
        ShowMessage('Error: REPEATTRANS=0 and REPEATWORD=0');
    end;
  except
  on E: Exception do
    ShowMessage('StudyFrontCard: '+E.Message);
  end;
end;

procedure TMainForm.StudyBackCard;
var
  timest, timesw: integer;
begin
  try
    if isAbort then exit;
    if not Query.Active then exit;

    pnlMain.Color:=clInfoBk;

    timest:=Query['REPEATTRANS'];
    timesw:=Query['REPEATWORD'];

    if (timest>=timesw) then
    begin
      ClearCard;
      ShowTranscript(Query);
      ShowWord(Query);
    end
    else
    begin
      if timesw>0 then
      begin
        ClearCard;
        ShowTranslate(Query)
      end
      else
        ShowMessage('Error: REPEATTRANS=0 and REPEATWORD=0');
    end;
  except on E: Exception do
    ShowMessage('StudyBackCard: '+E.Message);
  end;
end;

procedure TMainForm.SetRepeatNextLevel;
var
  timest, timesw:integer;
  Lvl: Variant;
  Time, Times: integer;
  TimeUnit: string;
  NowDate, NewDate:TDateTime;
begin
  timest:=Query['REPEATTRANS'];
  timesw:=Query['REPEATWORD'];

  Query.Edit;

  if (timest>=timesw) then
  begin
    Dec(timest);
    Query['REPEATTRANS']:=timest;
  end
  else
  begin
    Dec(timesw);
    Query['REPEATWORD']:=timesw;
  end;

  if (timesw=0) and (timest=0) then
  begin
    Studied:=Studied+1;

    if NextLevel=g_Studied then
    begin
      StudiedAll:=StudiedAll+1;

      Query['STATE']:=g_Studied;
      Query['REPEATWORD']:=0;
      Query['REPEATTRANS']:=0;
      Query['DATETIME']:=NULL;
    end
    else
    begin
      if Query['STATE']<>g_Studied then
        Query['STATE']:=NextLevel;
      lvl:=dm.qrLevels.Lookup('ID', NextLevel, 'TIME; TIMEUNIT; TIMES');

      if (VarType(lvl)<>varNull) and (VarType(lvl)<>varEmpty)then
      begin
        Time:=lvl[0];
        TimeUnit:=lvl[1];
        Times:=lvl[2];

        NowDate:=Now;

        if TimeUnit='min' then
          NewDate:=IncMinute(NowDate, Time)
        else
          NewDate:=IncDay(NowDate, Time);

        Query['REPEATWORD']:=Times;
        Query['REPEATTRANS']:=Times;
        Query['DATETIME']:=NewDate;
      end
      else
        ShowMessage('Error: Level record ID= '+IntToStr(NextLevel)+' was not found');
    end;
  end;

  Query.Post;
end;

procedure TMainForm.SetStudied(v: integer);
begin
  fStudied:=v;
  sbMain.Panels[4].Text:=IntToStr(v);
end;

procedure TMainForm.SetStudiedAll(v: integer);
begin
  fStudiedAll:=v;
  sbMain.Panels[1].Text:=IntToStr(v);
end;

procedure TMainForm.SetStudyNextLevel;
var
  Lvl: Variant;
  Time, Times, TimesW, TimesT: integer;
  TimeUnit: string;
  NowDate, NewDate:TDateTime;
begin
  timest:=Query['REPEATTRANS'];
  timesw:=Query['REPEATWORD'];

  Query.Edit;

  if (timest>=timesw) then
  begin
    Dec(timest);
    Query['REPEATTRANS']:=timest;
  end
  else
  begin
    Dec(timesw);
    Query['REPEATWORD']:=timesw;
  end;

  if (timesw=0) and (timest=0) then
  begin
    Studied:=Studied+1;
    if Query['STATE']<>g_Studied then
      Query['STATE']:=NextLevel;
    lvl:=dm.qrLevels.Lookup('ID', NextLevel, 'TIME; TIMEUNIT; TIMES');

    if (VarType(lvl)<>varNull) and (VarType(lvl)<>varEmpty)then
    begin
      Time:=lvl[0];
      TimeUnit:=lvl[1];
      Times:=lvl[2];

      NowDate:=Now;

      if TimeUnit='min' then
        NewDate:=IncMinute(NowDate, Time)
      else
        NewDate:=IncDay(NowDate, Time);

      Query['REPEATWORD']:=Times;
      Query['REPEATTRANS']:=Times;
      Query['DATETIME']:=NewDate;
    end
    else
      ShowMessage('Error: Level record ID= '+IntToStr(NextLevel)+' was not found');
  end;

  Query.Post;

end;

procedure TMainForm.SetChecked(v: integer);
begin
  fChecked:=v;
  sbMain.Panels[2].Text:=IntToStr(v);
end;

procedure TMainForm.SetDictionary(s: string);
begin
  sbMain.Panels[0].Text:=s;
end;

procedure TMainForm.SetErrors(v: integer);
begin
  fErrors:=v;
  sbMain.Panels[6].Text:=IntToStr(v);
end;

procedure TMainForm.ClearCard;
begin
  lblWord.Caption:='';
  lblTranscript.Caption:='';
  lblTranslate.Caption:='';
end;

procedure TMainForm.dsOutDone(Sender: TComponent);
var
  w:string;
begin
  SoundBusy:=false;
  Inc(PronounceWord);
  if PronounceWord<WordList.Count then
  begin
    w:=trim(WordList[PronounceWord]);
    Pronounce(w);
  end
  else
  begin
    PronounceWord:=0;
    WordList.Clear
  end;
end;

procedure TMainForm.dsOutProgress(Sender: TComponent);
begin
  Application.ProcessMessages
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  Stop;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  actStop.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  IDList:=TList<integer>.Create;
  WordList := TStringList.Create;

  Caption := Caption + ' - ver.' + GetBuildInfoAsString;

  {$IFDEF DEBUG}
  Caption :='DEBUG';
  {$ENDIF}

  SetMainPanel;
  plMain.ActivePageIndex:=0;
end;

procedure TMainForm.SetMainPanel;
begin
  with dm do
  begin
    if not qrDict.Eof then
    begin
      Dictionary:=qrDict['NAME'];

      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID';
      qrMisc.Params[0].AsInteger:=qrDict['ID'];
      qrMisc.Open;
      Total:=qrMisc['CNT'];

      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1';
      qrMisc.Params[0].AsInteger:=qrDict['ID'];
      qrMisc.Open;
      Checked:=qrMisc['CNT'];

      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE='
        +IntToStr(g_Studied);
      qrMisc.Params[0].AsInteger:=qrDict['ID'];
      qrMisc.Open;
      StudiedAll:=qrMisc['CNT'];
    end;

    Studied:=0;
    Studying:=0;
    Errors:=0;

  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  IDList.Free;
  WordList.Free;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=32 then
    btnOk.Action.Execute;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
(*  if Key=#32 then
    btnOk.Action.Execute;*)
end;

procedure TMainForm.llDictLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  actDict.Execute;
end;

procedure TMainForm.llRepeatLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  actRepeat.Execute;
end;

procedure TMainForm.llSettingsLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  actOptions.Execute;
end;

procedure TMainForm.llStudyAgainLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  actStudyOmitted.Execute;
end;

procedure TMainForm.llStudyLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  actLearn.Execute;
end;

procedure TMainForm.actSoundExecute(Sender: TObject);
begin
  if not SoundBusy then
    PronounceWords(LastTranslation);
end;

procedure TMainForm.actStopExecute(Sender: TObject);
begin
  isAbort:=true;
  isPause:=true;
  Stop;
end;

procedure TMainForm.apeMainDeactivate(Sender: TObject);
begin
  isPause:=true;
end;

procedure TMainForm.apeMainShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: Vcl.Controls.THintInfo);

const
    Hints : array[0..6] of string =
    ('Selected dictionary', 'Words studied total', 'Words selected to study',
      'Total words in the dictionary','Studied/repeated now', 'Studying/repeating now',
       'Errors');
var
  r: TRect;
  idx: integer;
begin
  if (HintInfo.HintControl = sbMain) AND (NOT sbMain.SimplePanel) then
  begin
    r := sbMain.ClientRect;
    r.Right := sbMain.Panels[0].Width;
    //locate over what panel the mouse is
    for idx := 0 to sbMain.Panels.Count-1 do
    begin
      if r.Right > HintInfo.CursorPos.X then
      begin
        HintInfo.CursorRect := r;
        //provide custom hint for the panel under the mouse
        HintStr := Hints[idx];
        Exit;
      end;
      OffsetRect(r, sbMain.Panels[idx].Width, 0) ;
      if idx<sbMain.Panels.Count-1 then
        r.Right:=r.Left+sbMain.Panels[idx+1].Width;
    end;
  end;
end;

procedure TMainForm.btnOkKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#32 then
    btnOk.Action.Execute;
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

procedure TMainForm.NextCard;
var
  LastColor:integer;
begin

  ClearCard;
  LastColor:=pnlMain.Color;
  pnlMain.Color:=clSilver;
  Application.ProcessMessages;

  tmrSleep.Enabled:=false;
  tmrSleep.Interval:=100;
  tmrSleep.Enabled:=true;

  while tmrSleep.Enabled do
  begin
    Application.ProcessMessages;
  end;

  pnlMain.Color:=LastColor;
end;

procedure TMainForm.actStudyExecute(Sender: TObject);
var
  Id, Idx: integer;
begin
  tmrPass.Enabled:=false;

  with dm do
  begin
    if FullStudyMode then
    begin
      qrStudy.Edit;

      if isStudied then
      begin
        qrStudy['STATE']:=g_Studied;
        qrStudy['REPEATWORD']:=1;
        qrStudy['REPEATTRANS']:=1;
      end;

      if not isPassed then
      begin
        if not IsStudied then
          qrStudy['STATE']:=g_Learning
      end
      else
      begin
        isPassed:=false;
        if not IsStudied then
          qrStudy['STATE']:=g_Passed;
      end;

      if not isStudied then
      begin
        qrStudy['REPEATWORD']:=qrOptions['SHOWTIMES'];
        qrStudy['REPEATTRANS']:=qrOptions['SHOWTIMES'];
      end
      else
      begin
        qrStudy['REPEATWORD']:=0;
        qrStudy['REPEATTRANS']:=0;
      end;

      qrStudy.Post;
      fdcRws.Commit;
      fdcRws.StartTransaction;

      qrStudy.Next;

      if qrStudy.Eof then
      begin
        Stop;
        Inc(StudyState);
        StartStudy;
      end
      else
      begin
        tmrPass.Enabled:=false;
        tmrPass.Enabled:=true;
        ClearCard;
        ShowFullCard(qrStudy);
      end;
    end //if FullStudyMode
    else
    begin
      tmrPause.Enabled:=false;
      isPause:=false;

      if isFrontShown and not isStudied then
      begin
        StudyBackCard(qrStudy);
        isFrontShown:=false;
        exit;
      end;

      isFrontShown:=true;
      NextLevel:=1;
      SetStudyNextLevel(qrStudy);

      fdcRWS.Commit;
      fdcRWS.StartTransaction;

      if qrStudy['STATE']<>g_learning then
      begin  //Remove from Random List

        if IDList.Count>0 then
        begin
          Id:=qrStudy['ID'];
          Idx:=IDList.IndexOf(ID);
          if(Idx>=0) then
            IDList.Delete(Idx);
        end;
      end;

      Id:=RandomId;

      if Id<0 then
      begin
        Stop;
        Inc(StudyState);
        StartStudy
      end
      else
      begin
        qrStudy.Locate('ID', Id);
        NextCard;
        StudyFrontCard(qrStudy)
      end
    end;
  end;
end;

procedure TMainForm.actStudyOmittedExecute(Sender: TObject);
begin
  with dm do
  begin
    qrStudyPassed.ParamByName('ID').AsInteger:=qrOptions['DICTIONARY'];
    qrStudyPassed.ExecSQL;
  end;

  actLearn.Execute;
end;

procedure TMainForm.actRepetitionExecute(Sender: TObject);
var
  Id, Idx, CurLevel, OldLevel: integer;
begin
  with dm do
  begin
    tmrTimeout.Enabled:=false;
    tmrPause.Enabled:=false;

    OldLevel:=qrRepeat['STATE'];

    if not isPause then
    begin
      if not IsTimeout then
      begin
        SetRepeatNextLevel(qrRepeat);
      end
      else ResetStats(qrRepeat);

      if qrRepeat['STATE']<>OldLevel then //State changed
      begin //Remove from Random List
        if IDList.Count>0 then
        begin
          Id:=qrRepeat['ID'];
          Idx:=IDList.IndexOf(ID);
          if(Idx>=0) then
            IDList.Delete(Idx);
        end;
      end;

      fdcRWS.Commit;
      fdcRWS.StartTransaction;
    end
    else
      if qrRepeat.State in [dsEdit] then
        qrRepeat.Cancel;

    isTimeout:=false;
    isPause:=false;

    Id:=RandomId;

    if Id<0 then
    begin
        Stop;
        with dlgStopRepeat do
        begin
          Caption:='All words have been repeated!';
          ShowModal;
        end;
    end
    else
    begin
      qrRepeat.Locate('ID', Id);
      CurLevel:=qrRepeat['STATE'];

      if CurLevel=MaxLevel then
        CurLevel:=g_Studied   //Studied
      else CurLevel:=CurLevel+1;

      NextLevel:=CurLevel;
      RepeatFrontBack(qrRepeat)
    end
  end;
end;

procedure TMainForm.RunCountdown;
begin
    Dec(Countdown);
    if Countdown>=0 then
    begin
      ShowCountdown(Countdown);
    end
    else
    begin
       lblWord.Caption:='';
       isCountDown:=false;
    end;
end;

procedure TMainForm.ShowFullCard;
begin
  try
    if Query.State in [dsInactive] then exit;

    lblWord.Caption:=Query.FieldByName('WORD').AsString;
    LastTranslation:=lblWord.Caption;
    lblTranscript.Caption:='['+Query.FieldByName('TRANSCRIPTION').AsString+']';
    lblTranslate.Caption:=TranslByNum(Query.FieldByName('TRANSLATION').AsString, 1);
    if not SoundBusy then
      PronounceWords(lblWord.Caption);
  except

  on E: Exception do
    ShowMessage('ShowFullCard: '+E.Message);
  end;
end;

procedure TMainForm.ShowWord;
begin
  if Query.State in [dsInactive] then exit;

  try
    lblWord.Caption:=Query.FieldByName('WORD').AsString;
    LastTranslation:=lblWord.Caption;

    if not SoundBusy then
      PronounceWords(lblWord.Caption);
  except

  on E: Exception do
    ShowMessage('ShowWord: '+E.Message);
  end;
end;

procedure TMainForm.ShowTranslate;
begin
  if Query.State in [dsInactive] then exit;
  try
    lblWord.Caption:=TranslByNum(Query.FieldByName('TRANSLATION').AsString, 1);
  except

  on E: Exception do
    ShowMessage('ShowTranslate: '+E.Message);
  end;

end;

procedure TMainForm.ShowTranscript;
begin
  try
    lblTranscript.Caption:='['+Query.FieldByName('TRANSCRIPTION').AsString+']';
  except
  on E: Exception do
    ShowMessage('ShowTranscript: '+E.Message);
  end;

end;


procedure TMainForm.Run;
begin
  isProcess:=true;
  pnlOk.Visible:=true;
  actDict.Enabled:=false;
  actOptions.Enabled:=false;
  actLearn.Enabled:=false;
  actStudyOmitted.Enabled:=false;
  actRepeat.Enabled:=false;
  actStop.Enabled:=true;
  isTimeout:=false;
  isPause:=false;
  isAbort:=false;
  pnlMain.Color:=clInfoBk;
  plMain.ActivePageIndex:=0;
end;

procedure TMainForm.Stop;
begin
  pnlMain.Color:=clInfoBk;
  isProcess:=false;
  pnlOk.Visible:=false;
  actDict.Enabled:=true;
  actOptions.Enabled:=true;
  actLearn.Enabled:=true;
  actStudyOmitted.Enabled:=true;
  actRepeat.Enabled:=true;
  actStop.Enabled:=false;

  tmrPause.Enabled:=false;
  tmrTimeout.Enabled:=false;
  tmrPass.Enabled:=false;

  isTimeout:=false;
  isPause:=false;
  isCountdown:=false;

  ClearCard;
  btnOk.Action:=nil;
  plMain.ActivePageIndex:=1;

  with dm do
  begin
    if qrRepeat.State in [dsEdit] then
      if not isPause then
        qrRepeat.Post
      else
        qrRepeat.Cancel;

    if qrStudy.State in [dsEdit] then
      if not isPause then
        qrStudy.Post
      else
        qrStudy.Cancel;

    if qrRepeat.Active then
      qrRepeat.Close;

    if qrStudy.Active then
      qrStudy.Close;

     fdcRWS.Commit;
     fdcRWS.StartTransaction;

  end;
end;

procedure TMainForm.pnlMainClick(Sender: TObject);
begin
  if btnOk.Action<>nil then
    btnOk.Action.Execute;
end;

procedure TMainForm.PronounceWords(words: string);
var
  w:string;
begin
  ExtractStrings([' ',',','-','?'], [], PChar(words), WordList);

  try
    w:=trim(WordList[PronounceWord]);
    Pronounce(w);
  finally
  end;
end;

procedure TMainForm.ppMainClose(Sender: TObject);
begin
  tmrEnableActn.Enabled:=true
end;

procedure TMainForm.ppMainPopup(Sender: TObject);
var
  Actn:TAction;
begin
  Actn:=(btnOk.Action as TAction);

  if Actn<>nil then
  begin

    if (Actn=actStudy) and FullStudyMode then
      tmrPass.Enabled:=false;

    if Actn=actRepetition then
    begin
      if not isTimeout then
        tmrTimeout.Enabled:=false;

      if not isPause  then
        tmrPause.Enabled:=false;
    end;

    Actn.Enabled:=false;
  end;
end;

procedure TMainForm.Pronounce;
var
  Path, FN: string;
begin
  with dm do
  begin
    if dsOut.Status = tosPlaying then exit;

    if qrOptions.FieldByName('PRONOUNCE').AsBoolean then
    begin
      Path:=qrOptions.FieldByName('SOUNDLIB').AsString;

      if JclFileUtils.PathIsAbsolute(Path) then
          Path:=IncludeTrailingPathDelimiter(PathSearchAndQualify(qrOptions.FieldByName('SOUNDLIB').AsString))
      else Path:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+Path);
      FN:=Path+word+'.ogg';

      if FileExists(FN) then
      begin
        viOgg.FileName:=FN;

        if not SoundBusy then
        begin
          SoundBusy:=true;
          dsOut.Run;
        end;
      end
      else
      begin
        PronounceWord:=0;
        WordList.Clear
      end;
    end;
  end;
end;

end.


