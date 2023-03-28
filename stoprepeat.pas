(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit stoprepeat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TRun = (runStudy, runRepeat);

  TdlgStopRepeat = class(TForm)
    btnStudy: TButton;
    Panel1: TPanel;
    btnCancel: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    btnRepeat: TButton;
    tmrRun: TTimer;
    procedure btnStudyClick(Sender: TObject);
    procedure btnRepeatClick(Sender: TObject);
    procedure tmrRunTimer(Sender: TObject);
  private
    { Private declarations }
    Run:TRun;
  public
    { Public declarations }
  end;

var
  dlgStopRepeat: TdlgStopRepeat;

implementation

{$R *.dfm}

uses main;

procedure TdlgStopRepeat.btnRepeatClick(Sender: TObject);
begin
  Run:=runRepeat;
  tmrRun.Enabled:=true;
end;

procedure TdlgStopRepeat.btnStudyClick(Sender: TObject);
begin
  Run:=runStudy;
  tmrRun.Enabled:=true;
end;

procedure TdlgStopRepeat.tmrRunTimer(Sender: TObject);
begin
 tmrRun.Enabled:=false;

  case Run of
    runStudy:  MainForm.actLearn.Execute;
    runRepeat: MainForm.actRepeat.Execute;
  end;

end;

end.
