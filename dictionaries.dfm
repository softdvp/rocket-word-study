object frmDict: TfrmDict
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dictionaries'
  ClientHeight = 493
  ClientWidth = 853
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 853
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 431
    ExplicitWidth = 849
    object btnOk: TBitBtn
      Left = 578
      Top = 6
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnClose: TBitBtn
      Left = 756
      Top = 6
      Width = 75
      Height = 24
      Caption = 'Close'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnApply: TButton
      Left = 667
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
    Width = 853
    Height = 432
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 849
    ExplicitHeight = 431
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 428
      Height = 430
      Align = alClient
      Caption = 'Dictionaries'
      TabOrder = 0
      ExplicitWidth = 424
      ExplicitHeight = 429
      object Panel5: TPanel
        Left = 2
        Top = 387
        Width = 424
        Height = 41
        Align = alBottom
        TabOrder = 0
        ExplicitTop = 386
        ExplicitWidth = 420
        object btnImport: TButton
          Left = 6
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
          Left = 87
          Top = 6
          Width = 75
          Height = 26
          Caption = 'Export'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnExportClick
        end
        object btnDelAllDict: TButton
          Left = 249
          Top = 6
          Width = 71
          Height = 26
          Hint = 'Delete all dictionaries'
          Caption = 'Delete All'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnDelAllDictClick
        end
        object btnDelStats: TButton
          Left = 326
          Top = 6
          Width = 75
          Height = 27
          Hint = 'Clear all statistics about word learning'
          Caption = 'Clear Stats'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = btnDelStatsClick
        end
        object btnDel: TBitBtn
          Left = 168
          Top = 6
          Width = 75
          Height = 25
          Hint = 'Delete 2'
          Caption = 'Delete'
          ImageIndex = 0
          Images = imgDict
          TabOrder = 4
          OnClick = btnDelClick
        end
      end
      object dbgDict: TDBGridView
        Left = 2
        Top = 17
        Width = 424
        Height = 370
        Align = alClient
        AllowDeleteRecord = False
        AllowEdit = False
        AllowInsertRecord = False
        DataSource = dm.dsDict
        DefaultLayout = False
        ReadOnly = True
        ShowCellTips = False
        ShowHeader = False
        TabOrder = 1
        OnCellAcceptCursor = dbgDictCellAcceptCursor
        Columns = <
          item
            FieldName = 'NAME'
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 429
      Top = 1
      Width = 423
      Height = 430
      Align = alRight
      Caption = 'Words'
      TabOrder = 1
      ExplicitLeft = 425
      ExplicitHeight = 429
      object Panel3: TPanel
        Left = 2
        Top = 17
        Width = 419
        Height = 90
        Hint = 'Clear filter'
        Align = alTop
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 61
          Width = 29
          Height = 15
          Caption = 'Filter:'
          FocusControl = edFilter
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
        object btnClear: TBitBtn
          Left = 326
          Top = 60
          Width = 18
          Height = 18
          ImageIndex = 1
          Images = imgDict
          TabOrder = 5
          StyleName = 'Windows'
          OnClick = btnClearClick
        end
      end
      object Panel4: TPanel
        Left = 2
        Top = 387
        Width = 419
        Height = 41
        Align = alBottom
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ExplicitTop = 386
        object sbSound: TSpeedButton
          Left = 320
          Top = 6
          Width = 23
          Height = 22
          Hint = 'Pronounce the selected word(F2)'
          ImageIndex = 5
          Images = MainForm.imgMain
          ParentShowHint = False
          ShowHint = True
          OnClick = sbSoundClick
        end
        object sbDel: TSpeedButton
          Left = 384
          Top = 6
          Width = 23
          Height = 22
          Hint = 'Delete the selected word'
          ImageIndex = 0
          Images = imgDict
          OnClick = sbDelClick
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
        Height = 257
        Align = alClient
        AllowDeleteRecord = False
        AllowEdit = False
        AllowInsertRecord = False
        AlwaysSelected = True
        CheckBoxes = True
        CheckStyle = cs3D
        ColumnClick = True
        DataSource = dm.dsWords
        DefaultLayout = False
        Fixed.Flat = False
        Header.Flat = False
        HorzScrollBar.Tracking = False
        HorzScrollBar.Visible = False
        RowSelect = True
        ShowCellTips = False
        TabOrder = 2
        OnCellAcceptCursor = dbgWordsCellAcceptCursor
        OnCellClick = dbgWordsCellClick
        OnCheckClick = dbgWordsCheckClick
        OnDblClick = dbgWordsDblClick
        OnGetCheckState = dbgWordsGetCheckState
        OnGetSortDirection = dbgWordsGetSortDirection
        OnHeaderClick = dbgWordsHeaderClick
        OnKeyDown = dbgWordsKeyDown
        Columns = <
          item
            AlignEdit = True
            AllowClick = False
            Caption = ' '
            CheckKind = gcCheckBox
            MaxWidth = 20
            DefWidth = 20
            FieldName = 'SELECTED'
            DefaultColumn = False
          end
          item
            Caption = ' '
            EditStyle = geEllipsis
            DefWidth = 170
            FieldName = 'WORD'
            DefaultColumn = False
          end
          item
            AllowClick = False
            Caption = ' '
            DefWidth = 64
            FieldName = 'TRANSLATION'
            DefaultColumn = False
          end>
      end
      object Panel6: TPanel
        Left = 2
        Top = 364
        Width = 419
        Height = 23
        Align = alBottom
        TabOrder = 3
        ExplicitTop = 363
        object lbTranscript: TLabel
          Left = 1
          Top = 4
          Width = 417
          Height = 18
          Align = alBottom
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'PhoneticTM'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 4
        end
      end
      object pnlLocate: TPanel
        Left = 209
        Top = 107
        Width = 179
        Height = 25
        Alignment = taLeftJustify
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        Visible = False
      end
    end
  end
  object sbDict: TStatusBar
    Left = 0
    Top = 467
    Width = 853
    Height = 26
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 466
    ExplicitWidth = 849
  end
  object imgDict: TImageList
    Left = 512
    Top = 185
    Bitmap = {
      494C010102000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF003355
      3300000000000000000000000000000000000000000000000000000000000000
      000066556600FFFFFF00FFFFFF00FFFFFF00ECECEC00313131005F5F5F00FDFD
      FD00FFFFFF00FAFAFA00FFFFFF00F8F8F800F8F8F800FFFFFF00FAFAFA00FFFF
      FF00FDFDFD005F5F5F0031313100ECECEC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00CCD5CC00332B
      3300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00332B3300CCD5CC00FFFFFF00FFFFFF003131310001010100000000006565
      6500F2F2F200FFFFFF00F3F3F300FFFFFF00FFFFFF00F3F3F300FFFFFF00F2F2
      F200656565000000000001010100313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0099AA99006655
      6600FFFFFF0033553300FFFFFF0099AA990099809900FFFFFF00332B3300FFFF
      FF006655660099AA9900FFFFFF00998099005F5F5F00000000000A0A0A000202
      020056565600FFFFFF00FFFFFF00F5F5F500F5F5F500FFFFFF00FFFFFF005656
      5600020202000A0A0A00000000005F5F5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0099AA99006655
      6600FFFFFF0000000000FFFFFF009980990066806600FFFFFF00332B3300FFFF
      FF006680660099AA9900FFFFFF0099AA9900FDFDFD0065656500020202000101
      01000101010060606000F4F4F400FFFFFF00FFFFFF00F4F4F400606060000101
      0100010101000202020065656500FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF009980990099AA
      9900FFFFFF0000000000FFFFFF006680660099809900FFFFFF0000000000FFFF
      FF009980990066806600FFFFFF00FFFFFF00FFFFFF00F2F2F200565656000101
      010006060600000000005F5F5F00FDFDFD00FDFDFD005F5F5F00000000000606
      06000101010056565600F2F2F200FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF006655660099AA
      9900FFFFFF0000000000FFFFFF009980990099809900FFFFFF0000000000FFFF
      FF0099AA990066556600FFFFFF00FFFFFF00FAFAFA00FFFFFF00FFFFFF006060
      60000000000000000000000000006C6C6C006C6C6C0000000000000000000000
      000060606000FFFFFF00FFFFFF00FAFAFA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0066556600CCAA
      CC00FFFFFF00002B0000FFFFFF006680660099AA9900FFFFFF0000000000FFFF
      FF00CCAACC0066556600FFFFFF00FFFFFF00FFFFFF00F3F3F300FFFFFF00F4F4
      F4005F5F5F000000000006060600000000000000000006060600000000005F5F
      5F00F4F4F400FFFFFF00F3F3F300FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00332B3300CCD5
      CC00CCD5CC00332B3300FFFFFF009980990099809900FFFFFF00332B3300CCFF
      CC00CCAACC0033553300FFFFFF00FFFFFF00F8F8F800FFFFFF00F5F5F500FFFF
      FF00FDFDFD006C6C6C00000000000909090009090900000000006C6C6C00FDFD
      FD00FFFFFF00F5F5F500FFFFFF00F8F8F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00332B3300CCFF
      CC00CCD5CC00332B3300FFFFFF006680660099809900FFFFFF00332B3300CCD5
      CC00FFFFFF00332B3300FFFFFF00FFFFFF00F8F8F800FFFFFF00F5F5F500FFFF
      FF00FDFDFD006C6C6C00000000000909090009090900000000006C6C6C00FDFD
      FD00FFFFFF00F5F5F500FFFFFF00F8F8F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00CCAACC0066556600FFFFFF009980990066806600FFFFFF0033553300CCAA
      CC00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00F3F3F300FFFFFF00F4F4
      F4005F5F5F000000000006060600000000000000000006060600000000005F5F
      5F00F4F4F400FFFFFF00F3F3F300FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00CCD5CC00FFFFFF00FFD5FF00FFFFFF00FFFFFF00FFD5FF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FAFAFA00FFFFFF00FFFFFF006060
      60000000000000000000000000006C6C6C006C6C6C0000000000000000000000
      000060606000FFFFFF00FFFFFF00FAFAFA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00CCAACC00000000003355
      3300335533006655660033553300335533006655660033553300335533003355
      33003355330000000000CCAACC00FFFFFF00FFFFFF00F2F2F200565656000101
      010006060600000000005F5F5F00FDFDFD00FDFDFD005F5F5F00000000000606
      06000101010056565600F2F2F200FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000CCAACC00CCD5
      CC00CCAACC00CCD5CC00CCAACC00CCD5CC00CCAACC00CCD5CC00CCAACC00CCD5
      CC00CCD5CC0099AA990000000000FFFFFF00FDFDFD0065656500020202000101
      01000101010060606000F4F4F400FFFFFF00FFFFFF00F4F4F400606060000101
      0100010101000202020065656500FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF006655660000000000332B
      3300332B3300332B3300332B3300002B0000332B3300332B3300332B3300332B
      3300332B33000000000066556600FFFFFF005F5F5F00000000000A0A0A000202
      020056565600FFFFFF00FFFFFF00F5F5F500F5F5F500FFFFFF00FFFFFF005656
      5600020202000A0A0A00000000005F5F5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00CCD5
      CC0099AA9900332B3300FFFFFF00FFFFFF00FFD5FF00CCFFCC00332B3300CCAA
      CC00CCD5CC00FFFFFF00FFFFFF00FFFFFF003131310001010100000000006565
      6500F2F2F200FFFFFF00F3F3F300FFFFFF00FFFFFF00F3F3F300FFFFFF00F2F2
      F200656565000000000001010100313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00335533000000000000000000000000000000000033553300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECECEC00313131005F5F5F00FDFD
      FD00FFFFFF00FAFAFA00FFFFFF00F8F8F800F8F8F800FFFFFF00FAFAFA00FFFF
      FF00FDFDFD005F5F5F0031313100ECECEC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
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
  object actDict: TActionList
    Left = 513
    Top = 249
  end
  object tmrSelectWord: TTimer
    Enabled = False
    OnTimer = tmrSelectWordTimer
    Left = 369
    Top = 257
  end
end
