object dlgAllStudy: TdlgAllStudy
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'All words are studied!'
  ClientHeight = 88
  ClientWidth = 354
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
    Top = 37
    Width = 354
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      354
      51)
    object btnCancel: TButton
      Left = 235
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
      Left = 27
      Top = 13
      Width = 75
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Repeat Now'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnRepeatClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 37
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 35
      Top = 13
      Width = 211
      Height = 13
      Caption = 'Would you like to repeat the studied words?'
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
