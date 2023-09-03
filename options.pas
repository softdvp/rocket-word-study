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
  JvToolEdit, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls;

type
  TfrmOptions = class(TForm)
    pcOptions: TPageControl;
    tsMainOptions: TTabSheet;
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
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    dbgRepeat: TDBGrid;
    Panel3: TPanel;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Panel2: TPanel;
    btnOk: TBitBtn;
    btnClose: TBitBtn;
    tsSoundLibs: TTabSheet;
    DBCheckBox1: TDBCheckBox;
    edSoundLib: TJvDirectoryEdit;
    btnDel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure CloseOptions;
    procedure FormActivate(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure dbgRepeatEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    toClose:boolean;
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses dmmain;

procedure TfrmOptions.CloseOptions;
var
  DlgResult: TModalResult;
begin
  with dm do
  begin
    if (qrOptions.State in [dsInsert, dsEdit]) or (qrLevels.State in [dsInsert, dsEdit]) then
    begin
      isTransChanged:=true;
      frmOptions.btnOk.Enabled:=isTransChanged;
    end;

    if isTransChanged then
    begin
      DlgResult:=MessageDlg('Would you like to save the changes?', mtConfirmation, [mbNo, mbYes, mbCancel], 0, mbCancel);

      case DlgResult of
        mrYes: btnOkClick(nil);
        mrNo:
          begin
            if qrOptions.State in [dsInsert, dsEdit]  then
              qrOptions.Cancel;
            if qrLevels.State in [dsInsert, dsEdit]  then
              qrLevels.Cancel;

            RollbackRetaining;

            qrOptions.Refresh;
            qrLevels.Refresh;
            toClose:=true
          end;

        mrCancel: toClose:=false;

      end;

    end
    else toClose:=true;
  end;
end;

procedure TfrmOptions.dbgRepeatEditButtonClick(Sender: TObject);
begin
  dbgRepeat.Columns[1].ReadOnly:=false;
  dbgRepeat.SelectedIndex:=-1;
  dbgRepeat.SelectedIndex:=1;
end;

procedure TfrmOptions.btnDelClick(Sender: TObject);
var
  ID:integer;
begin
    if MessageDlg('Would you like to delete the this repetition level?', mtConfirmation, [mbNo, mbYes], 0, mbNo)=mrYes then
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
    CommitRetaining;
    toClose:=true;
  end;
end;

procedure TfrmOptions.FormActivate(Sender: TObject);
begin
  btnOk.Enabled:=false;
  with dm do
  begin
    qrLevels.First;
    edSoundLib.Text:=qrOptions.FieldByName('SOUNDLIB').AsString;
  end;

  pcOptions.ActivePage:=tsMainOptions;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseOptions;
  btnOk.Enabled:=false;
end;

procedure TfrmOptions.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CloseOptions;
  CanClose:=toClose;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  TDrawGrid(dbgRepeat).ScrollBars:=ssVertical;
end;

end.
