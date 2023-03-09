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
    procedure btnRepeatClick(Sender: TObject);
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
  MainForm.actRepeat.Execute;
end;

end.
