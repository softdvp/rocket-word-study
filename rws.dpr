(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

program rws;

uses
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

begin
  Application.Initialize;
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
