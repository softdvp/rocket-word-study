(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit options;
   
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.Mask, JvExStdCtrls, JvEdit, JvValidateEdit, JvExMask,
  JvToolEdit, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmOptions = class(TForm)
    GroupBox1: TGroupBox;
    edSoundLib: TJvDirectoryEdit;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    DBCheckBox1: TDBCheckBox;
    Panel3: TPanel;
    btnDel: TButton;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses dmmain;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  with dm do
  begin
    fdcRWS.Rollback;
    fdcRWS.StartTransaction;
  end;
end;

procedure TfrmOptions.btnDelClick(Sender: TObject);
var
  ID:integer;
begin
  with dm do
  begin
    qrLevels.DisableControls;
    ID:=qrLevels['ID'];
    qrLevels.Last;
    qrLevels.Delete;
    qrLevels.Locate('ID', ID);
    fdcRWS.ExecSQL('UPDATE sqlite_sequence SET seq = (SELECT MAX(ID) FROM levels) WHERE name = ''LEVELS''');
    qrLevels.EnableControls;
  end;
end;

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin
  with dm do
  begin
    if qrOptions.FieldByName('SOUNDLIB').AsString<>edSoundLib.Text then
    begin
      if not (qrOptions.State in [dsInsert, dsEdit]) then
         qrOptions.Edit;
      qrOptions['SOUNDLIB']:=edSoundLib.Text;
    end;

    if qrOptions.State in [dsInsert, dsEdit]  then
      qrOptions.Post;
    if qrLevels.State in [dsInsert, dsEdit]  then
      qrLevels.Post;

    fdcRWS.Commit;
    fdcRWS.StartTransaction;
  end;
end;

procedure TfrmOptions.FormActivate(Sender: TObject);
begin
  with dm do
  begin
    qrLevels.First;
    edSoundLib.Text:=qrOptions.FieldByName('SOUNDLIB').AsString;
  end;
end;

end.
