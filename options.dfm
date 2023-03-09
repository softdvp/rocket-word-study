object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 637
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 113
    Height = 15
    Caption = 'Time for answer, sec :'
  end
  object Label3: TLabel
    Left = 24
    Top = 53
    Width = 142
    Height = 15
    Caption = 'Number of words to learn :'
  end
  object Label5: TLabel
    Left = 272
    Top = 24
    Width = 152
    Height = 15
    Caption = 'Inactivity time to pause, sec :'
  end
  object Label6: TLabel
    Left = 272
    Top = 53
    Width = 78
    Height = 15
    Caption = 'Errors to reset :'
  end
  object Label2: TLabel
    Left = 24
    Top = 82
    Width = 133
    Height = 15
    Caption = 'Time to omit a word, sec '
  end
  object Label4: TLabel
    Left = 272
    Top = 82
    Width = 217
    Height = 15
    Caption = 'Time to show a word in spritz mode, sec: '
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 473
    Width = 559
    Height = 105
    Caption = 'Sound Library'
    TabOrder = 6
    object Label8: TLabel
      Left = 16
      Top = 24
      Width = 29
      Height = 15
      Caption = 'Word'
    end
    object edSoundLib: TJvDirectoryEdit
      Left = 16
      Top = 45
      Width = 521
      Height = 23
      TabOrder = 0
      Text = ''
    end
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 136
    Width = 561
    Height = 308
    Caption = 'Study and Repeat'
    TabOrder = 4
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 557
      Height = 248
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
    object Panel1: TPanel
      Left = 2
      Top = 265
      Width = 557
      Height = 41
      Align = alBottom
      TabOrder = 1
      object btnDel: TButton
        Left = 432
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 0
        OnClick = btnDelClick
      end
    end
  end
  object btnOk: TButton
    Left = 362
    Top = 599
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 7
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 458
    Top = 599
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
    OnClick = btnCancelClick
  end
  object DBEdit3: TDBEdit
    Left = 183
    Top = 50
    Width = 33
    Height = 23
    DataField = 'WORDS'
    DataSource = dm.dsOptions
    TabOrder = 2
  end
  object DBEdit4: TDBEdit
    Left = 500
    Top = 50
    Width = 33
    Height = 23
    DataField = 'MISTAKES'
    DataSource = dm.dsOptions
    TabOrder = 3
  end
  object DBEdit1: TDBEdit
    Left = 183
    Top = 21
    Width = 33
    Height = 23
    DataField = 'TIMEANSWER'
    DataSource = dm.dsOptions
    TabOrder = 0
  end
  object DBCheckBox1: TDBCheckBox
    Left = 32
    Top = 450
    Width = 184
    Height = 17
    Caption = 'Pronounce words'
    DataField = 'PRONOUNCE'
    DataSource = dm.dsOptions
    TabOrder = 5
  end
  object DBEdit2: TDBEdit
    Left = 500
    Top = 21
    Width = 33
    Height = 23
    DataField = 'INACTIVETIME'
    DataSource = dm.dsOptions
    TabOrder = 1
  end
  object DBEdit5: TDBEdit
    Left = 183
    Top = 79
    Width = 33
    Height = 23
    DataField = 'OMITTIME'
    DataSource = dm.dsOptions
    TabOrder = 9
  end
  object DBEdit6: TDBEdit
    Left = 500
    Top = 79
    Width = 33
    Height = 23
    DataField = 'SPRITZTIME'
    DataSource = dm.dsOptions
    TabOrder = 10
  end
end
