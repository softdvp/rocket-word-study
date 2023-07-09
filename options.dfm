object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 576
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 438
    Width = 582
    Height = 97
    Align = alBottom
    Caption = 'Sound Library'
    TabOrder = 1
    ExplicitTop = 437
    ExplicitWidth = 578
    object edSoundLib: TJvDirectoryEdit
      Left = 16
      Top = 46
      Width = 521
      Height = 23
      TabOrder = 0
      Text = ''
    end
    object DBCheckBox1: TDBCheckBox
      Left = 16
      Top = 23
      Width = 184
      Height = 17
      Caption = '&Pronounce words'
      DataField = 'PRONOUNCE'
      DataSource = dm.dsOptions
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 130
    Width = 582
    Height = 308
    Align = alClient
    Caption = 'Study and Repeat'
    TabOrder = 0
    ExplicitWidth = 578
    ExplicitHeight = 307
    object Panel1: TPanel
      Left = 2
      Top = 17
      Width = 578
      Height = 205
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 574
      ExplicitHeight = 204
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 578
        Height = 205
        Align = alClient
        DataSource = dm.dsLevels
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Caption = ' '
            Width = 191
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIME'
            Title.Caption = ' '
            Visible = True
          end
          item
            DropDownRows = 2
            Expanded = False
            FieldName = 'TIMEUNIT'
            PickList.Strings = (
              'min'
              'days')
            Title.Caption = 'Unit of time'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIMES'
            Title.Caption = 'Times'
            Visible = True
          end>
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 222
      Width = 578
      Height = 84
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 221
      ExplicitWidth = 574
      object btnDel: TButton
        Left = 474
        Top = 6
        Width = 75
        Height = 25
        Caption = '&Delete'
        TabOrder = 2
        OnClick = btnDelClick
      end
      object DBCheckBox2: TDBCheckBox
        Left = 24
        Top = 16
        Width = 273
        Height = 17
        Caption = 'Use AI to plan repetitions'
        DataField = 'USEAI'
        DataSource = dm.dsOptions
        Enabled = False
        TabOrder = 0
      end
      object DBCheckBox3: TDBCheckBox
        Left = 24
        Top = 40
        Width = 289
        Height = 17
        Caption = 'Help use AI by sending feature usage information'
        DataField = 'SENDDATA'
        DataSource = dm.dsOptions
        Enabled = False
        TabOrder = 1
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 535
    Width = 582
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 534
    ExplicitWidth = 578
    object btnOk: TButton
      Left = 362
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 458
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 582
    Height = 130
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 578
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 113
      Height = 15
      Caption = '&Time for answer, sec :'
      FocusControl = DBEdit1
    end
    object Label3: TLabel
      Left = 24
      Top = 53
      Width = 142
      Height = 15
      Caption = '&Number of words to learn :'
      FocusControl = DBEdit3
    end
    object Label5: TLabel
      Left = 272
      Top = 24
      Width = 152
      Height = 15
      Caption = '&Inactivity time to pause, sec :'
      FocusControl = DBEdit2
    end
    object Label6: TLabel
      Left = 272
      Top = 53
      Width = 78
      Height = 15
      Caption = '&Errors to reset :'
      FocusControl = DBEdit4
    end
    object Label2: TLabel
      Left = 24
      Top = 82
      Width = 133
      Height = 15
      Caption = 'Time to &omit a word, sec '
      FocusControl = DBEdit5
    end
    object Label4: TLabel
      Left = 272
      Top = 82
      Width = 217
      Height = 15
      Caption = 'Time to &show a word in spritz mode, sec: '
      Enabled = False
      FocusControl = DBEdit6
    end
    object DBEdit3: TDBEdit
      Left = 183
      Top = 50
      Width = 33
      Height = 23
      DataField = 'WORDS'
      DataSource = dm.dsOptions
      TabOrder = 0
    end
    object DBEdit4: TDBEdit
      Left = 500
      Top = 50
      Width = 33
      Height = 23
      DataField = 'MISTAKES'
      DataSource = dm.dsOptions
      TabOrder = 1
    end
    object DBEdit1: TDBEdit
      Left = 183
      Top = 21
      Width = 33
      Height = 23
      DataField = 'TIMEANSWER'
      DataSource = dm.dsOptions
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 500
      Top = 21
      Width = 33
      Height = 23
      DataField = 'INACTIVETIME'
      DataSource = dm.dsOptions
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 183
      Top = 79
      Width = 33
      Height = 23
      DataField = 'OMITTIME'
      DataSource = dm.dsOptions
      TabOrder = 4
    end
    object DBEdit6: TDBEdit
      Left = 500
      Top = 79
      Width = 33
      Height = 23
      DataField = 'SPRITZTIME'
      DataSource = dm.dsOptions
      Enabled = False
      TabOrder = 5
    end
  end
end
