object dlgStopRepeat: TdlgStopRepeat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'All words have been repeated!'
  ClientHeight = 97
  ClientWidth = 437
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
    Top = 46
    Width = 437
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 47
    ExplicitWidth = 346
    DesignSize = (
      437
      51)
    object btnStudy: TButton
      Left = 116
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Study Now'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = btnStudyClick
    end
    object btnCancel: TButton
      Left = 261
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object btnRepeat: TButton
      Left = 26
      Top = 13
      Width = 75
      Height = 25
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
    Width = 437
    Height = 46
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 65
    object Label1: TLabel
      Left = 26
      Top = 16
      Width = 315
      Height = 13
      Caption = 'Would you like either to study new words or repeat studied ones?'
    end
  end
end
