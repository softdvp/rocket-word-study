(*
		This Source Code Form is subject to the terms of the MIT
		License.

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

program rws;

uses
  windows,
  SysUtils,
  Vcl.Forms,
  main in 'main.pas' {MainForm},
  options in 'options.pas' {frmOptions},
  dictionaries in 'dictionaries.pas' {frmDict},
  dmmain in 'dmmain.pas' {dm: TDataModule},
  ShellFileSupport in 'ShellFileSupport.pas',
  about in 'about.pas' {fmAbout},
  rtversion in 'rtversion.pas',
  stoprepeat in 'stoprepeat.pas' {dlgStopRepeat},
  stopstudy in 'stopstudy.pas' {dlgStopStudy},
  allstudy in 'allstudy.pas' {dlgAllStudy},
  passstudy in 'passstudy.pas' {dlgPassStudy};

{$R *.res}
var MyNewMsg : DWord;

function AllowSetForegroundWindow(dwProcessId: LongInt): BOOL; stdcall;
  external user32;

begin

  g_AppName := 'Rocket Word Study';

  {$IFDEF DEBUG}
  g_AppName :='DEBUG';
  {$ENDIF}

  CreateMutex(nil, false, PChar(g_AppName));

  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
   {Send all windows our custom message - only our other}
   {instance will recognise it, and restore itself}
    AllowSetForegroundWindow(-1);
    MyNewMsg:=RegisterWindowMessage(PChar(g_AppName));
    SendMessage(HWND_BROADCAST,
                MyNewMsg,
                0,
                0);
   {Lets quit}
    Halt(0);
  end;

  Application.Initialize;

  Application.ShowMainForm := true;
  ShowWindow(Application.Handle, SW_RESTORE);

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.CreateForm(TfrmDict, frmDict);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TdlgStopRepeat, dlgStopRepeat);
  Application.CreateForm(TdlgStopStudy, dlgStopStudy);
  Application.CreateForm(TdlgAllStudy, dlgAllStudy);
  Application.CreateForm(TdlgPassStudy, dlgPassStudy);
  Application.Run;
end.
