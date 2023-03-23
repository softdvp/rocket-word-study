object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 306
  Width = 542
  object fdLink: TFDPhysSQLiteDriverLink
    EngineLinkage = slStatic
    Left = 8
    Top = 8
  end
  object fdcRWS: TFDConnection
    ConnectionName = 'RWS'
    Params.Strings = (
      'Database=C:\Development\Rocket Word Study\rws.db'
      'DriverID=SQLite'
      'StringFormat=Unicode'
      'OpenMode=CreateUTF8'
      'LockingMode=Normal')
    LoginPrompt = False
    Left = 56
    Top = 8
  end
  object qrDict: TFDQuery
    IndexFieldNames = 'ID'
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT * FROM DICTIONARIES'
      'ORDER BY NAME')
    Left = 412
    Top = 8
  end
  object dsDict: TDataSource
    DataSet = qrDict
    Left = 8
    Top = 72
  end
  object qrWords: TFDQuery
    IndexFieldNames = 'DICTID'
    MasterSource = dsDict
    MasterFields = 'ID'
    DetailFields = 'DICTID'
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT *'
      'FROM WORDS'
      'WHERE DICTID=:ID')
    Left = 312
    Top = 8
    ParamData = <
      item
        Name = 'ID'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = 7
      end>
  end
  object dsWords: TDataSource
    DataSet = qrWords
    OnDataChange = dsWordsDataChange
    Left = 64
    Top = 72
  end
  object qrDicImport: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'INSERT INTO DICTIONARIES (NAME) VALUES (:NAME)')
    Left = 264
    Top = 8
    ParamData = <
      item
        Name = 'NAME'
        ParamType = ptInput
      end>
  end
  object qrWordImport: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'INSERT INTO WORDS(DICTID, WORD, TRANSLATION, TRANSCRIPTION) '
      'VALUES (:DICTID, :WORD, :TRANSLATION, :TRANSCRIPTION)')
    Left = 264
    Top = 56
    ParamData = <
      item
        Name = 'DICTID'
        ParamType = ptInput
      end
      item
        Name = 'WORD'
        ParamType = ptInput
      end
      item
        Name = 'TRANSLATION'
        ParamType = ptInput
      end
      item
        Name = 'TRANSCRIPTION'
        ParamType = ptInput
      end>
  end
  object qrOptions: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT *'
      'FROM SETTINGS')
    Left = 384
    Top = 112
  end
  object qrLevels: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT *'
      'FROM LEVELS'
      'ORDER BY ID')
    Left = 328
    Top = 112
  end
  object dsOptions: TDataSource
    DataSet = qrOptions
    Left = 112
    Top = 72
  end
  object dsLevels: TDataSource
    DataSet = qrLevels
    Left = 112
    Top = 8
  end
  object qrSelectWords: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'UPDATE WORDS'
      'SET SELECTED=:SELECTED')
    Left = 360
    Top = 8
    ParamData = <
      item
        Name = 'SELECTED'
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrStudy: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT *'
      'FROM WORDS'
      'WHERE DICTID=:DICTID AND SELECTED=1 AND STATE=:STATE'
      'LIMIT :LIMIT')
    Left = 344
    Top = 56
    ParamData = <
      item
        Name = 'DICTID'
        ParamType = ptInput
      end
      item
        Name = 'STATE'
        ParamType = ptInput
      end
      item
        Name = 'LIMIT'
        ParamType = ptInput
      end>
  end
  object qrRepeat: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT *'
      'FROM WORDS '
      'WHERE DICTID=:DICTID AND STATE>0 and STATE<100 '
      'AND DATETIME < datetime('#39'now'#39', '#39'localtime'#39')'
      '')
    Left = 408
    Top = 56
    ParamData = <
      item
        Name = 'DICTID'
        ParamType = ptInput
      end>
  end
  object qrMaxLevel: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT MAX(ID) AS MAXID'
      'FROM LEVELS')
    Left = 264
    Top = 104
  end
  object qrMisc: TFDQuery
    Connection = fdcRWS
    Left = 264
    Top = 160
  end
  object qrTest: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'insert into words(DICTID, word, translation, transcription)'
      'values (1, "test", "test", "'#240#618's")')
    Left = 296
    Top = 248
  end
  object qrStudyPassed: TFDQuery
    Connection = fdcRWS
    SQL.Strings = (
      'UPDATE WORDS'
      'SET STATE=0'
      'WHERE STATE=102 AND DICTID=:ID')
    Left = 328
    Top = 160
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object qrExport: TFDQuery
    IndexFieldNames = 'DICTID'
    MasterSource = dsDict
    MasterFields = 'ID'
    DetailFields = 'DICTID'
    Connection = fdcRWS
    SQL.Strings = (
      'SELECT *'
      'FROM WORDS'
      'WHERE DICTID=:ID')
    Left = 441
    Top = 112
    ParamData = <
      item
        Name = 'ID'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = 7
      end>
  end
end
