(*
		This Source Code Form is subject to the terms of the MIT
		License.

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)
//{$DEFINE MOUSECLICK}
unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Math, Vcl.Graphics,
  DateUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, System.Generics.Collections, Data.Db,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, JclFileUtils, JvTimer, ACS_Classes, NewACDSAudio, ACS_Vorbis, ShellFileSupport,
  Vcl.AppEvnts, JvExComCtrls, JvComCtrls, JvTabBar, JvPageList, JvExControls, UITypes,
  Vcl.Imaging.pngimage, ACS_DXAudio, JvComponentBase, JvAppEvent, ACS_WinMedia,
  ACS_smpeg, JvgProgress, ES.BaseControls, ES.Images;

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
    tbMain: TToolBar;
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
    inOgg: TVorbisIn;
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
    actLearned: TAction;
    ppMain: TPopupMenu;
    Markwordaslearned1: TMenuItem;
    tmrEnableActn: TTimer;
    pnlSession: TPanel;
    tmrSession: TTimer;
    btnReset: TButton;
    VbMouse: TVorbisIn;
    dxOut: TDXAudioOut;
    dxMouse: TDXAudioOut;
    inMP3: TMP3In;
    tmrSlip: TTimer;
    pnlSlip: TPanel;
    lblWordS: TLabel;
    lblTranslateS: TLabel;
    lblTranscriptS: TLabel;
    tmrFlip: TTimer;
    pnlFlip: TPanel;
    tmrCountdown: TTimer;
    pge3: TJvStandardPage;
    pnlCountdown: TPanel;
    imgCountdown: TImage;
    lbCoundown: TLabel;
    imgFlip: TEsImage;
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
    procedure tmrSessionTimer(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure dxOutDone(Sender: TComponent);
    procedure tmrSlipTimer(Sender: TObject);
    procedure tmrFlipTimer(Sender: TObject);
    procedure apeMainMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure tmrCountdownTimer(Sender: TObject);
    procedure dxOutProgress(Sender: TComponent);
  private
    Countdown, NextLevel, MaxLevel: integer;
    FullStudyMode, isCountdown, isProcess, isAbort,
    isTimeout, isPause, isFrontShown, isPassed,
    isStudied, isGrip:boolean;

    IDList: TList<Integer>;
    WordList:TStringList;

    StudyState, fStudiedAll,
    fChecked, fTotal, fStudied, fRepeated,
    fStudying, fErrors, PronounceWord,
    SessionTime:integer;

    LastTranslation:string;

    Angle: real;
    TimerCount, LastCount:integer;

    bmpFront, bmpBack, bmpFlip: TBitmap;
    FrontRect, BackRect:TRect;

    procedure SetDictionary(s:string);
    procedure SetStudiedAll(v:integer);
    procedure SetChecked(v:integer);
    procedure SetTotal(v:integer);
    procedure SetStudied(v:integer);
    procedure SetRepeated(v:integer);

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
    procedure SoundMouseClick;
    procedure ClearCardS;
    procedure ShowTranslateS(Query: TFDQuery);
    procedure ShowTranscriptS(Query: TFDQuery);
    procedure ShowWordS(Query: TFDQuery);
    procedure SlipCard;
    procedure FlipCard;
    procedure ShowFullCardS(Query: TFDQuery);
    procedure PanelToBitmap(Panel: TPanel; Bitmap: TBitmap);
    procedure ProgressBar(Width, Height: integer; Ang: real);
    procedure InitCountdown;

protected
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
      message WM_ERASEBKGND;

  public
        procedure PanelToImage(Panel: TPanel; Image: TImage);

    property Dictionary:string write SetDictionary;
    property Total:integer write SetTotal;
    property Checked:integer write SetChecked;
    property StudiedAll:integer read fStudiedAll write SetStudiedAll;
    property Studied:integer read fStudied write SetStudied;
    property Repeated:integer read fRepeated write SetRepeated;
    property Studying:integer read fStudying write SetStudying;
    property Errors:integer read fErrors write SetErrors;
    procedure Pronounce(word:string);
    procedure PronounceWords;

    procedure SetMainPanel;
    function TranslByNum(s:string; n:integer):string;
    function AudioBusy:boolean;
    function CheckLearn: boolean;
    function CheckRepeat: boolean;
    function DiffTimeString(t: TDateTime): string;
    function StudyMinTime: TDateTime;
    procedure StartPronounce(words: string);

end;

var
  MainForm: TMainForm;
  g_AppName:string;

implementation

{$R *.dfm}

uses options, dictionaries, dmmain, about, stoprepeat, stopstudy, allstudy,
  passstudy;

var
  OldWindowProc : Pointer; {Variable for the old windows proc}
  MyMsg : DWord; {custom systemwide message}

function NewWindowProc(WindowHandle : hWnd;
                       TheMessage   : Cardinal;
                       ParamW       : NativeUInt;
                       ParamL       : NativeInt) : NativeInt stdcall;
begin
  if DWord(TheMessage) = MyMsg  then
  begin
   {Tell the application to restore, let it restore the form}

    SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    SetForegroundWindow(Application.Handle);

   {We handled the message - we are done}
    Result := 0;
    exit;
  end;
 {Call the original winproc}
  Result := CallWindowProc(OldWindowProc,
                           WindowHandle,
                           TheMessage,
                           ParamW,
                           ParamL);
end;

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
    qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND (STATE=0 OR STATE='
    +IntToStr(g_Learning)+')';

    qrMisc.ParamByName('ID').AsInteger:=qrOptions['DICTIONARY'];
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
    qrMisc.ParamByName('ID').AsInteger:=qrOptions['DICTIONARY'];
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

//  ShowCountdown(Countdown);
//  tmrMain.Interval:=1000;
//  tmrMain.Enabled:=true;

  tmrCountdown.Tag:=Countdown*1000;
  InitCountdown;
end;

procedure TMainForm.tmrCountdownTimer(Sender: TObject);
const
  CorrTime=100;
var
  DifAngle:real;
  Count, TickPerSec :integer;
  Tag, d: integer;
begin
  Tag:=tmrCountdown.Tag * 100 div CorrTime;
  DifAngle:=360*tmrCountdown.Interval/Tag;
  Angle:=Angle+DifAngle;
  imgCountdown.Canvas.Pen.Color:=clLime;

  ProgressBar(imgCountdown.Width, imgCountdown.Height, Angle);

  Inc(TimerCount);
  TickPerSec:=(100000 div CorrTime) div tmrCountdown.Interval;

  Count:=TimerCount div TickPerSec;

  if Count<>LastCount then
  begin
    LastCount:=Count;
    d:=Tag div 1000 - Count;
    lbCoundown.Caption:=IntToStr(d);
  end;

  if Count>=Tag div (100000 div CorrTime)  then
//  if TimerCount=tmrCountdown.Tag div tmrCountdown.Interval then
  begin
    Application.ProcessMessages;
    Sleep(300);
    lbCoundown.Caption:='';
    tmrCountdown.Enabled:=false;
    plMain.ActivePageIndex:=0;
    pnlMain.PopupMenu:=ppMain;

    if not isAbort then
      RepeatOneSide;
  end
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

procedure TMainForm.tmrFlipTimer(Sender: TObject);
var
  deltaX:integer;

begin
  deltaX:=Round(pnlFlip.Width / (tmrFlip.Tag / tmrFlip.Interval));

  if isGrip then
  begin
    FrontRect.Width:=FrontRect.Width-deltaX;

    if FrontRect.Width<=0 then
    begin
      isGrip:=false;

      FrontRect.Width:=0;
      bmpFlip.Width:=0;

      tmrFlip.Enabled:=false;
      tmrFlip.Enabled:=true;
    end
    else
    begin
      bmpFlip.Width:=FrontRect.Width;

      bmpFlip.Canvas.StretchDraw(FrontRect, bmpFront);
      imgFlip.Picture.Bitmap.Assign(bmpFlip);

    end;
  end
  else
  begin
    BackRect.Width:=BackRect.Width+deltaX;

    if BackRect.Width>=pnlMain.Width then
    begin
      tmrFlip.Enabled:=false;
      pnlMain.BringToFront;
    end
    else
    begin

      bmpFlip.Width:=BackRect.Width;

      bmpFlip.Canvas.StretchDraw(BackRect, bmpBack);
      imgFlip.Picture.Bitmap.Assign(bmpFlip);

    end;
  end;
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

procedure TMainForm.tmrSessionTimer(Sender: TObject);
var t:TDateTime;
begin
  Inc(SessionTime);
  t:=SessionTime/SecsPerDay;
  pnlSession.Caption:=FormatDateTime('hh:nn', t)+'   ';
end;

procedure TMainForm.tmrSleepTimer(Sender: TObject);
begin
  tmrSleep.Enabled:=false;
end;

procedure TMainForm.tmrSlipTimer(Sender: TObject);
var
  deltaX:integer;
begin
  deltaX:=Round(pnlSlip.Width / (tmrSlip.Tag / tmrSlip.Interval));
  pnlSlip.Left := pnlSlip.Left + deltaX;

  if pnlSlip.Left=-pnlMain.Width+deltaX then
    pnlSlip.BringToFront;

  if (pnlSlip.Left) >= 0 then
  begin
    // At the end of the timer, set the position of pnlSlip to fully cover pnlMain
    tmrSlip.Enabled := False;
    pnlSlip.Left := 0;
    pnlslip.Width:=0;
  end;

end;

procedure TMainForm.tmrStudiedTimer(Sender: TObject);
begin
  btnOk.Action.Execute;
end;

procedure TMainForm.tmrTimeoutTimer(Sender: TObject);
begin
  try
    actRepetition.Enabled:=false;
    isTimeout:=true;
    tmrTimeout.Enabled:=false;

    ClearCardS;
    ClearCard;
    ShowFullCardS(dm.qrRepeat);
    pnlSlip.Color:=pnlMain.Color;
    SlipCard;
    Application.ProcessMessages;
    ShowFullCard(dm.qrRepeat);
  finally
    actRepetition.Enabled:=true;
  end;
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

procedure TMainForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result:=0;
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
    begin
      Query['STATE']:=1;
      Query['MISTAKE']:=0;
      lvl:=1;
    end;
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
  try
    actStudy.Enabled:=false;

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
//      Studied:=0;
//      Errors:=0;

      qrStudy.Open;

      if not qrStudy.Eof then
      begin
        FullStudyMode:=true;
        btnOk.Action:=actStudy;
        Run;
        tmrPass.Enabled:=false;
        tmrPass.Enabled:=true;

        ClearCardS;
        ClearCard;
        ShowFullCardS(qrStudy);
        pnlSlip.Color:=pnlMain.Color;
        SlipCard;
        Application.ProcessMessages;
        ShowFullCard(qrStudy)
      end
      else
      begin
        Stop;
        Inc(StudyState);
        StartStudy;
      end;
    end
  finally
    actStudy.Enabled:=true
  end;
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
//    Studied:=0;
//    Errors:=0;

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
//      Studied:=0;
//      Errors:=0;

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
//      Studied:=0;
//      Errors:=0;

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
  try
    actRepetition.Enabled:=false;
    timest:=Query['REPEATTRANS'];
    timesw:=Query['REPEATWORD'];
    pnlSlip.BringToFront;

    ClearCardS;
    ClearCard;

    if (timest>=timesw) then
    begin
      ShowTranslateS(Query)
    end
    else
      if timesw>0 then
      begin
        ShowTranscriptS(Query);
        ShowWordS(Query);
      end;

    pnlSlip.Color:=pnlMain.Color;
    SlipCard;

    if (timest>=timesw) then
    begin
      ShowTranslate(Query)
    end
    else
      if timesw>0 then
      begin
        ShowTranscript(Query);
        ShowWord(Query);
      end
      else
        ShowMessage('Error: REPEATTRANS=0 and REPEATWORD=0');

    tmrTimeout.Enabled:=true;
    tmrPause.Enabled:=true;
  finally
    actRepetition.Enabled:=true;
  end;

end;

procedure TMainForm.SlipCard;
begin
  pnlSlip.Left := -pnlMain.Width;
  pnlSlip.Width := pnlMain.Width;
  tmrSlip.Enabled:=true;

  while tmrSlip.Enabled do
    Application.ProcessMessages;
end;

procedure TMainForm.StudyFrontCard;
var
  timest, timesw: integer;
begin
  try
    actStudy.Enabled:=false;
    try
      if isAbort then exit;
      if not Query.Active then exit;

      timest:=Query['REPEATTRANS'];
      timesw:=Query['REPEATWORD'];

      ClearCardS;

      if (timest>=timesw) then
      begin
        ClearCardS;
        ShowTranslateS(Query)
      end
      else
      begin
        if timesw>0 then
        begin
          ClearCardS;
          ShowTranscriptS(Query);
          ShowWordS(Query);
        end
      end;

      pnlSlip.Color:=clWindow;
      SlipCard;
      pnlMain.Color:=clWindow;

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
  finally
    actStudy.Enabled:=true;
  end;
end;

procedure TMainForm.StudyBackCard;
var
  timest, timesw: integer;
begin
  try
    actStudy.Enabled:=false;
    Application.ProcessMessages;
    try
      if isAbort then exit;
      if not Query.Active then exit;

      pnlMain.Color:=clInfoBk;

      timest:=Query['REPEATTRANS'];
      timesw:=Query['REPEATWORD'];

      if (timest>=timesw) then
      begin
        ClearCardS;
        ShowTranscriptS(Query);
        ShowWordS(Query);
      end
      else
      begin
        if timesw>0 then
        begin
          ClearCardS;
          ShowTranslateS(Query)
        end;
      end;

      FlipCard;

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

      while tmrFlip.Enabled do
        Application.ProcessMessages;

    except on E: Exception do
      ShowMessage('StudyBackCard: '+E.Message);
    end;
  finally
    actStudy.Enabled:=true;
  end;
end;


procedure TMainForm.SetRepeated(v: integer);
begin
  fRepeated:=v;
  sbMain.Panels[6].Text:=IntToStr(v);
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
    Repeated:=Repeated+1;

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
  sbMain.Panels[7].Text:=IntToStr(v);
end;

procedure TMainForm.ClearCardS;
begin
  lblWordS.Caption:='';
  lblTranscriptS.Caption:='';
  lblTranslateS.Caption:='';
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

procedure TMainForm.dxOutDone(Sender: TComponent);
var
  w:string;
begin
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

procedure TMainForm.dxOutProgress(Sender: TComponent);
begin
  Application.ProcessMessages;
end;

procedure TMainForm.FlipCard;
begin
  isGrip:=true;

  //BackRect.Width:=pnlFlip.Width;
  BackRect.Top:=0;
  BackRect.Left:=0;
  BackRect.Width:=0;
  BackRect.Height:=pnlFlip.Height;


  pnlSlip.Left:=0;
  pnlSlip.Width:=pnlMain.Width;

  pnlMain.Color:=clWindow;
  pnlSlip.Color:=clInfoBk;

//  PanelToImage(pnlMain, imgFront);
//  PanelToImage(pnlSlip, imgBack);

  PanelToBitmap(pnlMain, bmpFront);
  PanelToBitmap(pnlSlip, bmpBack);

  pnlMain.Color:=clInfoBk;

  pnlSlip.Left:=-pnlMain.Width;

  FrontRect.Left:=0;
  FrontRect.Top:=0;
  FrontRect.Width:=pnlMain.Width;
  FrontRect.Height:=pnlMain.Height;

  bmpFlip.Width:=pnlSlip.Width;

  pnlSlip.Left := -pnlMain.Width;

  pnlFlip.BringToFront;
  tmrFlip.Enabled:=true;

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
  dxOut.PrefetchData:=true;

  bmpFront:=TBitmap.Create;
  bmpBack:=TBitmap.Create;
  bmpFlip:=TBitmap.Create;

  bmpFront.Height:=pnlMain.Height;
  bmpFront.Width:=pnlMain.Width;

  pnlSlip.Top:=0;
  pnlSlip.Width := pnlMain.Width;
  pnlSlip.Height := pnlMain.Height;
  pnlSlip.BorderStyle:=bsSingle;

  pnlSlip.Left := -pnlMain.Width;

  bmpBack.Height:=pnlSlip.Height;
  bmpBack.Width:=pnlSlip.Width;

  bmpFlip.Height:=pnlFlip.Height;
  bmpFlip.Width:=pnlFlip.Width;

  FrontRect.Top:=0;
  FrontRect.Left:=0;
  FrontRect.Height:=bmpFront.Height;
  FrontRect.Width:=bmpFront.Width;

  FrontRect.Top:=0;
  FrontRect.Left:=0;
  FrontRect.Height:=bmpBack.Height;
  FrontRect.Width:=bmpBack.Width;

  lblTranscriptS.Height:=lblTranscript.Height;
  lblTranslateS.Height:=lblTranslate.Height;

  IDList:=TList<integer>.Create;
  WordList := TStringList.Create;

  Caption := g_AppName + ' - ver.' + GetBuildInfoAsString;
  SetMainPanel;
  plMain.ActivePageIndex:=0;

  pnlMain.BringToFront;

{Register a custom windows message}
  MyMsg := RegisterWindowMessage(PChar(g_AppName));
 {Set form1's windows proc to ours and remember the old window proc}
  OldWindowProc := Pointer(SetWindowLong(MainForm.Handle,
                                         GWL_WNDPROC,
                                         LongInt(@NewWindowProc)));
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
    Repeated:=0;
    Studying:=0;
    Errors:=0;

  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SetWindowLong(MainForm.Handle,
                GWL_WNDPROC,
                LongInt(OldWindowProc));
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
  if not AudioBusy then
    StartPronounce(LastTranslation);
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

procedure TMainForm.apeMainMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if Msg.Message=WM_LBUTTONDOWN then
    SoundMouseClick;
end;

procedure TMainForm.apeMainShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: Vcl.Controls.THintInfo);

const
    Hints : array[0..7] of string =
    ('Selected dictionary', 'Words studied total', 'Words selected to study',
      'Total words in the dictionary','Studied now', 'Studying/repeating now', 'Repeated now',
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

function TMainForm.AudioBusy: boolean;
begin
  Result:=dxOut.Status<>tosIdle;
end;

procedure TMainForm.btnOkKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#32 then
    btnOk.Action.Execute;
end;

procedure TMainForm.btnResetClick(Sender: TObject);
var t:TDateTime;
begin
  SessionTime:=0;
  t:=SessionTime/SecsPerDay;
  pnlSession.Caption:=FormatDateTime('hh:nn', t)+'   ';
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

procedure TMainForm.actStudyExecute(Sender: TObject);
var
  Id, Idx: integer;
begin
  try
    actStudy.Enabled:=false;

    LastTranslation:='';
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
        CommitRetaining;
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

          ClearCardS;
          ShowFullCardS(qrStudy);
          pnlSlip.Color:=pnlMain.Color;
          SlipCard;

          ClearCard;
          ShowFullCard(qrStudy);
        end;
      end
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

        CommitRetaining;

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

          StudyFrontCard(qrStudy)
        end
      end;
    end;
  finally
    actStudy.Enabled:=true
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
  LastTranslation:='';

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

      CommitRetaining;

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

procedure TMainForm.ShowFullCardS;
var
 s:string;
begin
  try
    if Query.State in [dsInactive] then exit;

    lblWordS.Caption:=Query.FieldByName('WORD').AsString;
    s:=Query.FieldByName('TRANSCRIPTION').AsString;

    if Trim(s) <>''  then
      lblTranscriptS.Caption:='['+s+']'
    else lblTranscriptS.Caption:='';

    lblTranslateS.Caption:=TranslByNum(Query.FieldByName('TRANSLATION').AsString, 1);
  except

  on E: Exception do
    ShowMessage('ShowFullCard: '+E.Message);
  end;
end;

procedure TMainForm.ShowFullCard;
var
 s:string;
 i:integer;
begin
  try
    if Query.State in [dsInactive] then exit;

    lblWord.Caption:=Query.FieldByName('WORD').AsString;
    LastTranslation:=lblWord.Caption;
    s:=Query.FieldByName('TRANSCRIPTION').AsString;

    if Trim(s) <>''  then
      lblTranscript.Caption:='['+s+']'
    else lblTranscript.Caption:='';

    lblTranslate.Caption:=TranslByNum(Query.FieldByName('TRANSLATION').AsString, 1);

    for i:=1 to 100 do
      Application.ProcessMessages;

    if not AudioBusy then
      StartPronounce(lblWord.Caption);
  except

  on E: Exception do
    ShowMessage('ShowFullCard: '+E.Message);
  end;
end;

procedure TMainForm.ShowWordS;
begin
  if Query.State in [dsInactive] then exit;

  try
    lblWordS.Caption:=Query.FieldByName('WORD').AsString;

  except
  on E: Exception do
    ShowMessage('ShowWord: '+E.Message);
  end;
end;


procedure TMainForm.ShowWord;
begin
  if Query.State in [dsInactive] then exit;

  try
    lblWord.Caption:=Query.FieldByName('WORD').AsString;
    LastTranslation:=lblWord.Caption;

    if not AudioBusy then
      StartPronounce(lblWord.Caption);
  except

  on E: Exception do
    ShowMessage('ShowWord: '+E.Message);
  end;
end;

procedure TMainForm.SoundMouseClick;
begin

{$IFDEF MOUSECLICK}

  if dxMouse.Status<tosIdle then exit;


  vbMouse.FileName:=g_MsClickSound;
  dxMouse.Run;

{$ENDIF}

end;

procedure TMainForm.ShowTranslateS;
begin
  if Query.State in [dsInactive] then exit;
  try
    lblWordS.Caption:=TranslByNum(Query.FieldByName('TRANSLATION').AsString, 1);
  except

  on E: Exception do
    ShowMessage('ShowTranslate: '+E.Message);
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

procedure TMainForm.ShowTranscriptS;
var
  s:string;
begin
  try
    s:=Query.FieldByName('TRANSCRIPTION').AsString;
    if Trim(s)<>'' then
      lblTranscriptS.Caption:='['+Query.FieldByName('TRANSCRIPTION').AsString+']'
    else lblTranscriptS.Caption:='';

  except
  on E: Exception do
    ShowMessage('ShowTranscript: '+E.Message);
  end;
end;

procedure TMainForm.ShowTranscript;
var
  s:string;
begin
  try
    s:=Query.FieldByName('TRANSCRIPTION').AsString;
    if Trim(s)<>'' then
      lblTranscript.Caption:='['+Query.FieldByName('TRANSCRIPTION').AsString+']'
    else lblTranscript.Caption:='';

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

    CommitRetaining;
  end;
end;

procedure TMainForm.pnlMainClick(Sender: TObject);
begin
  if btnOk.Action<>nil then
    btnOk.Action.Execute;
end;

procedure TMainForm.StartPronounce(words: string);
var
  Path, FN, word: string;
  isExist:boolean;

begin
  frmDict.tmrSelectWord.Enabled:=false;
  dxOut.PrefetchData:=false;
  if words='' then exit;

  with dm do
  begin

    if not qrOptions.FieldByName('PRONOUNCE').AsBoolean then
      exit;

    isExist:=false;

    Path:=dm.qrOptions.FieldByName('SOUNDLIB').AsString;

    if JclFileUtils.PathIsAbsolute(Path) then
        Path:=IncludeTrailingPathDelimiter(PathSearchAndQualify(qrOptions.FieldByName('SOUNDLIB').AsString))
    else Path:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+Path);

    FN:=Path+words+'.ogg';

    if FileExists(FN) then
    begin
      word:=words;
      isExist:=true;
      WordList.Add(words)
    end
    else
    begin
      FN:=Path+words+'.mp3';

      if FileExists(FN) then
      begin
        word:=words;
        isExist:=true;
        WordList.Add(words)
      end
      else
        ExtractStrings([' ', '-', ',', '?', '/', '(',')'], [], PChar(words), WordList);
    end;
  end;

  PronounceWords
end;

procedure TMainForm.PronounceWords;
var
  w:string;
begin

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
  CanPron:boolean;
begin
  with dm do
  begin
    if dxOut.Status <> tosIdle then exit;

    Path:=qrOptions.FieldByName('SOUNDLIB').AsString;

    if JclFileUtils.PathIsAbsolute(Path) then
        Path:=IncludeTrailingPathDelimiter(PathSearchAndQualify(qrOptions.FieldByName('SOUNDLIB').AsString))
    else Path:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+Path);

    CanPron:=false;

    FN:=Path+word+'.ogg';

    if FileExists(FN) then
    begin
      dxOut.Input:=inOgg;
      inOgg.FileName:=FN;

      CanPron:=inOgg.Valid;
    end
    else
    begin
      FN:=Path+word+'.mp3';

      if FileExists(FN) then
      begin
        dxOut.Input:=inMP3;
        inMP3.FileName:=FN;

        CanPron:=inMP3.Valid;
      end;
    end;

    if CanPron then
    begin
      if not AudioBusy then
      begin
        if dxOut.Status <> tosIdle then exit;
        dxOut.Run;
      end;
    end
    else
    begin
      PronounceWord:=0;
      WordList.Clear
    end;

  end;
end;

function TMainForm.DiffTimeString(t: TDateTime): string;
const
  Note='Note: Words will be available to repeat in ';
var
  t1:TDateTime;
  d, h, m, s, ds, hs, ms, ss: string;
  di, hi, mi, si, msi:word;
begin
  t1:=t-Now;

  DecodeTime(t1, hi, mi, si, msi);

  Result:=Note;

  d:=IntToStr(DaysBetween(Now, t));
  di:=StrToInt(d);
  h:=FormatDateTime('h', t1);
  m:=FormatDateTime('n', t1);
  s:=FormatDateTime('s', t1);

  if di=1 then ds:=' day '
  else ds:=' days ';

  if hi=1 then
    hs:=' hour '
  else hs:=' hours ';

  if mi=1 then
    ms:=' minute '
  else ms:=' minutes ';

  if si=1 then
    ss:=' second '
  else ss:=' seconds ';


  if di>0 then
    Result:=Result + d +ds;

  if hi>0 then
    Result:=Result + h +hs;

  if mi>0 then
    Result:=Result + m +ms;

  if (di=0) and (hi=0) and (mi=0) then
    Result:= Result+s+ss

end;

function TMainForm.StudyMinTime: TDateTime;
begin
  with dm do
  begin
    qrMisc.SQL.Text:='SELECT * FROM WORDS WHERE DICTID=:DICTID AND STATE>0 and STATE<100 ORDER BY DATETIME';
    qrMisc.ParamByName('DICTID').AsInteger:=qrOptions['DICTIONARY'];
    qrMisc.Open;
    Result:=qrMisc.FieldByName('DATETIME').AsDateTime;
    qrMisc.Close;
  end;
end;

function TMainForm.CheckLearn: boolean;
begin
  Result:=true;
  with dm do
  begin

    qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE=0';
    qrMisc.Open;

    if qrMisc['CNT']=0 then
    begin
      qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE='+
        IntToStr(g_Passed);
      qrMisc.Open;

      if qrMisc['CNT']>0 then
      begin
        dlgPassStudy.ShowModal;
        Result:=false;
        exit;
      end
      else
      begin
        dlgAllStudy.ShowModal;
        Result:=false;
        exit;
      end;
      qrMisc.Close
    end;
  end;
end;

function TMainForm.CheckRepeat: boolean;
var
  DiffTime:TDateTime;

begin
  Result:=true;

  with dm do
  begin
    qrMisc.SQL.Text:='SELECT COUNT(*) AS CNT FROM WORDS WHERE DICTID=:ID AND SELECTED=1 AND STATE<>'+IntToStr(g_Studied);
    qrMisc.Open;

    if qrMisc['CNT']=0 then
    begin
      ShowMessage('All words are studied and repeated!'+#13#10+'Please select another dictionary');
      Result:=false;
      exit;
    end
    else
    begin
      DiffTime:=StudyMinTime;

      if DiffTime>0 then
      begin
        ShowMessage('Words will be available to study in '+DiffTimeString(DiffTime));
        Result:=false;
      end;

    end;
    qrMisc.Close
  end;
end;

procedure TMainForm.PanelToBitmap(Panel: TPanel; Bitmap: TBitmap);
begin
    Bitmap.Width := Panel.Width;
    Bitmap.Height := Panel.Height;
    Bitmap.Canvas.Brush.Color := Panel.Color;
    Bitmap.Canvas.FillRect(Rect(0, 0, Panel.Width, Panel.Height));
    Panel.PaintTo(Bitmap.Canvas.Handle, 0, 0);
end;

procedure TMainForm.PanelToImage(Panel: TPanel; Image: TImage);
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := Panel.Width;
    Bitmap.Height := Panel.Height;
    Bitmap.Canvas.Brush.Color := Panel.Color;
    Bitmap.Canvas.FillRect(Rect(0, 0, Panel.Width, Panel.Height));
    Panel.PaintTo(Bitmap.Canvas.Handle, 0, 0);
    Image.Picture.Bitmap.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

procedure TMainForm.ProgressBar(Width, Height:integer; Ang:real);
var Rad:integer;
begin
//calculated rate level to increase progress bar.
  with imgCountdown do
  begin
    Canvas.Pen.Width := 12;
    Canvas.MoveTo(Width div 2,15);
    Rad:=Min(Width, Height) div 2;

    Canvas.AngleArc(Width div 2, Height div 2, Rad-10, 90, -Ang);
  end;
end;

procedure TMainForm.InitCountdown;
var Rad:integer;
begin
  ProgressBar(imgCountdown.Width, imgCountdown.Height, Angle);
  lbCoundown.Caption:=IntToStr(tmrCountdown.Tag div 1000);
  Angle:=0;
  TimerCount:=0;

//  pnlCountdown.Visible:=true;
  plMain.ActivePageIndex:=2;

  with imgCountdown do
  begin
    Canvas.Pen.Color:=clGray;
    Rad:=Min(Width, Height) div 2;
    Canvas.AngleArc(Width div 2, Height div 2, Rad-10, 90, 360);
  end;
  LastCount:=0;
  tmrCountdown.Enabled:=true;
end;

begin
 {Tell Delphi to hide it's hidden application window for now to avoid}
 {a "flash" on the taskbar if we halt due to another instance}
  ShowWindow(Application.Handle, SW_HIDE);
end.


