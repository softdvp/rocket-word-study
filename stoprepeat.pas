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
  TdlgStopRepeat = class(TForm)
    btnStudy: TButton;
    Panel1: TPanel;
    btnCancel: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    btnRepeat: TButton;
    procedure btnStudyClick(Sender: TObject);
    procedure btnRepeatClick(Sender: TObject);
  private
    { Private declarations }
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
  MainForm.actRepeat.Execute;
end;

procedure TdlgStopRepeat.btnStudyClick(Sender: TObject);
begin
  MainForm.actLearn.Execute;
end;

end.
