(*
		This Source Code Form is subject to the terms of the MIT
		License. 

		Copyright (c) 2023 Oleg Popov
		Copyright (c) 2023 Rocket Technologies (https://www.rockettech.com)

*)

unit about;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  JvExControls, JvLinkLabel, ShellApi, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.Clipbrd;

type
  TfmAbout = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    lbVersion: TLabel;
    lbOleg: TLinkLabel;
    lbRockettech: TLinkLabel;
    Label2: TLabel;
    lbBitcoin: TLabel;
    Label4: TLabel;
    lbEther: TLabel;
    Label6: TLabel;
    ImageList1: TImageList;
    btBitcoin: TBitBtn;
    btnEther: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure lbOlegLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure lbRockettechLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure btBitcoinClick(Sender: TObject);
    procedure btnEtherClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.dfm}

uses main, ShellFileSupport;

procedure TfmAbout.btBitcoinClick(Sender: TObject);
begin
  Clipboard.AsText := lbBitcoin.Caption;
  ShowMessage('Copied to the clipboard')
end;

procedure TfmAbout.btnEtherClick(Sender: TObject);
begin
  Clipboard.AsText := lbEther.Caption;
  ShowMessage('Copied to the clipboard')
end;

procedure TfmAbout.FormCreate(Sender: TObject);
begin
  lbVersion.Caption:='ver. '+GetBuildInfoAsString;
end;

procedure TfmAbout.lbOlegLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar('mailto://contact@rocketech.com'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfmAbout.lbRockettechLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar(Link), nil, nil, SW_SHOWNORMAL);
end;

end.
