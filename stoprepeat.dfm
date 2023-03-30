object dlgStopRepeat: TdlgStopRepeat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'All words have been repeated!'
  ClientHeight = 131
  ClientWidth = 433
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
    Top = 80
    Width = 433
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 44
    ExplicitWidth = 429
    DesignSize = (
      433
      51)
    object btnStudy: TButton
      Left = 108
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Study Now'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = btnStudyClick
      ExplicitLeft = 104
    end
    object btnCancel: TButton
      Left = 253
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      ExplicitLeft = 249
    end
    object btnRepeat: TButton
      Left = 18
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Repeat Now'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnRepeatClick
      ExplicitLeft = 14
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 80
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 429
    ExplicitHeight = 44
    object Label1: TLabel
      Left = 26
      Top = 16
      Width = 315
      Height = 13
      Caption = 'Would you like either to study new words or repeat studied ones?'
    end
    object lbNote: TLabel
      Left = 26
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
