(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit passstudy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TdlgPassStudy = class(TForm)
    btnCancel: TButton;
    Panel1: TPanel;
    btnStudy: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    procedure btnStudyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgPassStudy: TdlgPassStudy;

implementation

{$R *.dfm}

uses main;

procedure TdlgPassStudy.btnStudyClick(Sender: TObject);
begin
  MainForm.actStudyOmitted.Execute;
end;

end.
