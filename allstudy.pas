(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit allstudy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TdlgAllStudy = class(TForm)
    btnCancel: TButton;
    Panel1: TPanel;
    btnRepeat: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    tmrRun: TTimer;
    lbNote: TLabel;
    procedure btnRepeatClick(Sender: TObject);
    procedure tmrRunTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgAllStudy: TdlgAllStudy;

implementation

{$R *.dfm}

uses main;

procedure TdlgAllStudy.btnRepeatClick(Sender: TObject);
begin
  tmrRun.Enabled:=true;
end;

procedure TdlgAllStudy.FormActivate(Sender: TObject);
var
  t: TDateTime;
begin
  btnRepeat.Enabled:=true;
  lbNote.Caption:='';

  with MainForm do
  begin
    t:=StudyMinTime;

    if t-Now>0 then
    begin
      btnRepeat.Enabled:=false;
      lbNote.Caption:=DiffTimeString(t)
    end
    else if t=0 then
    begin
      btnRepeat.Enabled:=false;
      lbNote.Caption:='Note: Please click "Study"'
    end;

  end;
end;

procedure TdlgAllStudy.tmrRunTimer(Sender: TObject);
begin
  tmrRun.Enabled:=false;
  MainForm.actRepeat.Execute;
end;

end.
