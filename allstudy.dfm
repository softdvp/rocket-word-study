object dlgAllStudy: TdlgAllStudy
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'All words are studied!'
  ClientHeight = 89
  ClientWidth = 358
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
    Top = 38
    Width = 358
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 32
    ExplicitWidth = 354
    DesignSize = (
      358
      51)
    object btnCancel: TButton
      Left = 239
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 235
    end
    object btnRepeat: TButton
      Left = 31
      Top = 13
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 358
    Height = 38
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 354
    ExplicitHeight = 32
    object Label1: TLabel
      Left = 35
      Top = 13
      Width = 211
      Height = 13
      Caption = 'Would you like to repeat the studied words?'
    end
  end
end
