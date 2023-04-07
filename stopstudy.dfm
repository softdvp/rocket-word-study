object dlgStopStudy: TdlgStopStudy
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'All current words are studied!'
  ClientHeight = 137
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 86
    Width = 408
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 85
    ExplicitWidth = 404
    DesignSize = (
      408
      51)
    object btnCancel: TButton
      Left = 255
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnRepeat: TButton
      Left = 15
      Top = 14
      Width = 75
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Repeat Now'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnRepeatClick
      ExplicitLeft = 11
    end
    object btnStudy: TButton
      Left = 112
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Study Now'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = btnStudyClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 408
    Height = 86
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 404
    ExplicitHeight = 85
    object Label1: TLabel
      Left = 35
      Top = 18
      Width = 315
      Height = 13
      Caption = 'Would you like either to study new words or repeat studied ones?'
    end
    object lbNote: TLabel
      Left = 35
      Top = 50
      Width = 99
      Height = 13
      Caption = '                                 '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object tmrRun: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrRunTimer
    Left = 152
    Top = 48
  end
end
