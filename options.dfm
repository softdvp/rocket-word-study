object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 571
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object pcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 562
    Height = 530
    ActivePage = tsMainOptions
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 570
    ExplicitHeight = 532
    object tsMainOptions: TTabSheet
      Caption = 'General'
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 130
        Align = alTop
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 562
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
          Width = 134
          Height = 15
          Caption = '&Errors to reset to 1st level:'
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
      object GroupBox2: TGroupBox
        Left = 0
        Top = 130
        Width = 566
        Height = 373
        Align = alClient
        Caption = 'Study and Repeat'
        TabOrder = 1
        ExplicitWidth = 562
        ExplicitHeight = 372
        object Panel1: TPanel
          Left = 2
          Top = 17
          Width = 562
          Height = 294
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          ExplicitWidth = 558
          ExplicitHeight = 293
          object dbgRepeat: TDBGrid
            Left = 0
            Top = 0
            Width = 562
            Height = 258
            Align = alTop
            DataSource = dm.dsLevels
            Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnEditButtonClick = dbgRepeatEditButtonClick
            Columns = <
              item
                Expanded = False
                FieldName = 'ID'
                Visible = False
              end
              item
                ButtonStyle = cbsEllipsis
                Expanded = False
                FieldName = 'NAME'
                ReadOnly = True
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
          object btnDel: TButton
            Left = 456
            Top = 264
            Width = 75
            Height = 25
            Caption = '&Delete'
            TabOrder = 1
            OnClick = btnDelClick
          end
        end
        object Panel3: TPanel
          Left = 2
          Top = 311
          Width = 562
          Height = 60
          Align = alBottom
          ParentBackground = False
          TabOrder = 1
          ExplicitTop = 310
          ExplicitWidth = 558
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
    end
    object tsSoundLibs: TTabSheet
      Caption = 'Sound Libs'
      ImageIndex = 1
      object DBCheckBox1: TDBCheckBox
        Left = 16
        Top = 23
        Width = 184
        Height = 17
        Caption = '&Pronounce words'
        DataField = 'PRONOUNCE'
        DataSource = dm.dsOptions
        TabOrder = 0
      end
      object edSoundLib: TJvDirectoryEdit
        Left = 16
        Top = 46
        Width = 521
        Height = 23
        TabOrder = 1
        Text = ''
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 530
    Width = 562
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 532
    ExplicitWidth = 570
    object btnOk: TBitBtn
      Left = 368
      Top = 6
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnClose: TBitBtn
      Left = 462
      Top = 6
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
