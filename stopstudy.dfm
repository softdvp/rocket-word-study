object dlgStopStudy: TdlgStopStudy
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'All current words are studied!'
  ClientHeight = 101
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 50
    Width = 416
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 44
    ExplicitWidth = 412
    DesignSize = (
      416
      51)
    object btnCancel: TButton
      Left = 271
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 267
    end
    object btnRepeat: TButton
      Left = 31
      Top = 14
      Width = 75
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Repeat Now'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnRepeatClick
      ExplicitLeft = 27
    end
    object btnStudy: TButton
      Left = 128
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Study Now'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = btnStudyClick
      ExplicitLeft = 124
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 416
    Height = 50
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 412
    ExplicitHeight = 44
    object Label1: TLabel
      Left = 35
      Top = 18
      Width = 315
      Height = 13
      Caption = 'Would you like either to study new words or repeat studied ones?'
    end
  end
end
