object dlgPassStudy: TdlgPassStudy
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'You have words omitted'
  ClientHeight = 104
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
    Top = 53
    Width = 358
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 47
    ExplicitWidth = 354
    DesignSize = (
      358
      51)
    object btnCancel: TButton
      Left = 243
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 239
    end
    object btnStudy: TButton
      Left = 35
      Top = 14
      Width = 75
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Study  Now'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnStudyClick
      ExplicitLeft = 31
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 358
    Height = 53
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 354
    ExplicitHeight = 47
    object Label1: TLabel
      Left = 35
      Top = 20
      Width = 175
      Height = 13
      Caption = 'Would you like study omitted words?'
    end
  end
end
