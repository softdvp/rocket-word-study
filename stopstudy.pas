(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit stopstudy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TRun = (runStudy, runRepeat);

  TdlgStopStudy = class(TForm)
    btnCancel: TButton;
    Panel1: TPanel;
    btnRepeat: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    btnStudy: TButton;
    tmrRun: TTimer;
    procedure btnRepeatClick(Sender: TObject);
    procedure btnStudyClick(Sender: TObject);
    procedure tmrRunTimer(Sender: TObject);
  private
    { Private declarations }
    Run:TRun;
  public
    { Public declarations }
  end;

var
  dlgStopStudy: TdlgStopStudy;

implementation

{$R *.dfm}

uses main;

procedure TdlgStopStudy.btnRepeatClick(Sender: TObject);
begin
  Run:=runRepeat;
  tmrRun.Enabled:=true;
end;

procedure TdlgStopStudy.btnStudyClick(Sender: TObject);
begin
  Run:=runStudy;
  tmrRun.Enabled:=true;
end;

procedure TdlgStopStudy.tmrRunTimer(Sender: TObject);
begin
  tmrRun.Enabled:=false;

  case Run of
    runStudy:  MainForm.actLearn.Execute;
    runRepeat: MainForm.actRepeat.Execute;
  end;
end;

end.
