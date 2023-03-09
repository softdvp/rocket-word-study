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
  TdlgStopStudy = class(TForm)
    btnCancel: TButton;
    Panel1: TPanel;
    btnRepeat: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    btnStudy: TButton;
    procedure btnRepeatClick(Sender: TObject);
    procedure btnStudyClick(Sender: TObject);
  private
    { Private declarations }
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
  MainForm.actRepeat.Execute;
end;

procedure TdlgStopStudy.btnStudyClick(Sender: TObject);
begin
  MainForm.actLearn.Execute;
end;

end.
