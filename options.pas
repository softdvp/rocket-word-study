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
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    edSoundLib: TJvDirectoryEdit;
    GroupBox2: TGroupBox;
    btnOk: TButton;
    btnCancel: TButton;
    DBGrid1: TDBGrid;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Panel1: TPanel;
    btnDel: TButton;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBEdit5: TDBEdit;
    Label4: TLabel;
    DBEdit6: TDBEdit;
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
