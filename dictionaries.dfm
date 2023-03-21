object frmDict: TfrmDict
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dictionaries'
  ClientHeight = 506
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 445
    Width = 869
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 444
    ExplicitWidth = 865
    object btnOk: TBitBtn
      Left = 573
      Top = 6
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TBitBtn
      Left = 751
      Top = 6
      Width = 75
      Height = 24
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnApply: TButton
      Left = 662
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 1
      OnClick = btnApplyClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 445
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 865
    ExplicitHeight = 444
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 444
      Height = 443
      Align = alClient
      Caption = 'Dictionaries'
      TabOrder = 0
      ExplicitWidth = 440
      ExplicitHeight = 442
      object dbgDict: TDBGrid
        Left = 2
        Top = 17
        Width = 440
        Height = 383
        Align = alClient
        DataSource = dm.dsDict
        Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = dbgDictCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Caption = 'Dictionary'
            Width = 260
            Visible = True
          end>
      end
      object Panel5: TPanel
        Left = 2
        Top = 400
        Width = 440
        Height = 41
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 399
        ExplicitWidth = 436
        object btnImport: TButton
          Left = 10
          Top = 6
          Width = 75
          Height = 26
          Caption = 'Import'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnImportClick
        end
        object btnExport: TButton
          Left = 91
          Top = 6
          Width = 75
          Height = 26
          Caption = 'Export'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnExportClick
        end
        object btnDel: TButton
          Left = 195
          Top = 6
          Width = 75
          Height = 26
          Hint = 'Delete dictionary'
          Caption = 'Delete'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnDelClick
        end
        object btnDelAllDict: TButton
          Left = 276
          Top = 6
          Width = 75
          Height = 26
          Hint = 'Delete all dictionaries'
          Caption = 'Delete All'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = btnDelAllDictClick
        end
        object btnDelStats: TButton
          Left = 357
          Top = 6
          Width = 75
          Height = 27
          Hint = 'Clear all statistics about word learning'
          Caption = 'Clear Stats'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = btnDelStatsClick
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 445
      Top = 1
      Width = 423
      Height = 443
      Align = alRight
      Caption = 'Words'
      TabOrder = 1
      ExplicitLeft = 441
      ExplicitHeight = 442
      object Panel3: TPanel
        Left = 2
        Top = 17
        Width = 419
        Height = 90
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 10
          Top = 61
          Width = 32
          Height = 15
          Caption = 'Filter :'
        end
        object RadioGroup1: TRadioGroup
          Left = 1
          Top = 1
          Width = 417
          Height = 51
          Align = alTop
          Caption = 'Show'
          TabOrder = 0
        end
        object rbAll: TRadioButton
          Left = 16
          Top = 24
          Width = 39
          Height = 17
          Caption = 'All'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbAllClick
        end
        object rbSelected: TRadioButton
          Left = 61
          Top = 24
          Width = 73
          Height = 17
          Caption = 'Selected'
          TabOrder = 2
          OnClick = rbAllClick
        end
        object rbNotSelected: TRadioButton
          Left = 140
          Top = 24
          Width = 85
          Height = 17
          Caption = 'Not Selected'
          TabOrder = 3
          OnClick = rbAllClick
        end
        object edFilter: TEdit
          Left = 49
          Top = 58
          Width = 275
          Height = 23
          TabOrder = 4
          OnChange = edFilterChange
        end
        object btnClear: TButton
          Left = 329
          Top = 57
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 5
          OnClick = btnClearClick
        end
      end
      object Panel4: TPanel
        Left = 2
        Top = 400
        Width = 419
        Height = 41
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 399
        object SpeedButton1: TSpeedButton
          Left = 320
          Top = 6
          Width = 23
          Height = 22
          Hint = 'Pronounce the word(F2)'
          ImageIndex = 5
          Images = MainForm.imgMain
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton1Click
        end
        object btnSelectAll: TButton
          Left = 10
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Select all'
          TabOrder = 0
          OnClick = btnSelectAllClick
        end
        object btnUselectAll: TButton
          Left = 91
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Deselect all'
          TabOrder = 1
          OnClick = btnUselectAllClick
        end
      end
      object dbgWords: TDBGridView
        Left = 2
        Top = 107
        Width = 419
        Height = 293
        Align = alClient
        AllowDeleteRecord = False
        AllowEdit = False
        AllowInsertRecord = False
        CheckBoxes = True
        CheckStyle = cs3D
        DataSource = dm.dsWords
        DefaultLayout = False
        HorzScrollBar.Tracking = False
        HorzScrollBar.Visible = False
        RowSelect = True
        ShowCellTips = False
        ShowHeader = False
        TabOrder = 2
        OnCellAcceptCursor = dbgWordsCellAcceptCursor
        OnCellClick = dbgWordsCellClick
        OnCheckClick = dbgWordsCheckClick
        OnGetCheckState = dbgWordsGetCheckState
        OnKeyDown = dbgWordsKeyDown
        Columns = <
          item
            AlignEdit = True
            Caption = ' '
            CheckKind = gcCheckBox
            DefWidth = 20
            FieldName = 'SELECTED'
            DefaultColumn = False
          end
          item
            Caption = ' '
            EditStyle = geEllipsis
            DefWidth = 100
            FieldName = 'WORD'
            DefaultColumn = False
          end
          item
            Caption = ' '
            DefWidth = 64
            FieldName = 'TRANSLATION'
            DefaultColumn = False
          end>
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 480
    Width = 869
    Height = 26
    Panels = <>
    ExplicitTop = 479
    ExplicitWidth = 865
  end
  object ImageList1: TImageList
    Left = 528
    Top = 185
  end
  object dlgExport: TSaveTextFileDialog
    DefaultExt = '*.rws'
    Filter = 
      'Rocket Word Study|*.rws|Comma-separated values|*.csv|BX Language' +
      '|*.bxd'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Export Dictionary'
    Encodings.Strings = (
      'UTF-8'
      'UTF-7'
      'Unicode'
      'ANSI'
      'Big Endian Unicode'
      'ASCII')
    Left = 200
    Top = 248
  end
  object dlgImport: TOpenTextFileDialog
    DefaultExt = '*.rws'
    Filter = 'Rocket Word Study|*.rws|Comma-separated values|*.csv'
    InitialDir = '\Dictionaries'
    Title = 'Import Dictionary'
    Encodings.Strings = (
      'UTF-8'
      'UTF-7'
      'Unicode'
      'ANSI'
      'Big Endian Unicode'
      'ASCII')
    Left = 120
    Top = 232
  end
  object ActionList1: TActionList
    Left = 513
    Top = 249
  end
end
