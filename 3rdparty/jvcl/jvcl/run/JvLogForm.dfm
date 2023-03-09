object FoLog: TFoLog
  Left = 454
  Top = 250
  Caption = 'FoLog'
  ClientHeight = 348
  ClientWidth = 527
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100001001000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000BBBB0000000000BB000BB000000000BB0000B000000000B
    BB000BB00000000BBB000BB00000000000000BB00000000000000BB000000000
    00000BB00000000000000BB00000000000000BB00000000000000BB000000000
    00000BB0000000000000BBBB00000000000BBBBBB0000000000000000000FFFF
    0000F87F0000E73F0000E7BF0000E39F0000E39F0000FF9F0000FF9F0000FF9F
    0000FF9F0000FF9F0000FF9F0000FF9F0000FF0F0000FE070000FFFF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 527
    Height = 24
    AutoSize = True
    ButtonWidth = 24
    Caption = 'ToolBar1'
    EdgeBorders = [ebBottom]
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ToolButton2: TToolButton
      Left = 0
      Top = 0
      Action = Save
    end
    object ToolButton1: TToolButton
      Left = 24
      Top = 0
      Action = Print
    end
    object ToolButton3: TToolButton
      Left = 48
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 56
      Top = 0
      Caption = 'ToolButton4'
      DropdownMenu = PopupMenu1
      ImageIndex = 2
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 24
    Width = 527
    Height = 324
    Align = alClient
    Columns = <
      item
        Caption = 'Time'
        Width = 115
      end
      item
        Caption = 'Severity'
      end
      item
        Caption = 'Title'
        Width = 120
      end
      item
        Caption = 'Description'
        Width = 150
      end>
    FlatScrollBars = True
    GridLines = True
    HotTrack = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object ImageList1: TImageList
    Left = 16
    Top = 56
    Bitmap = {
      494C010105003000300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000747EF7003242F7001126F6001126F6003242F700747EF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000757F
      F900041EF7000621F1000621F1000723EF000723EF000621F1000621F100041E
      F700757FF9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004B59F7000621
      F1000621F1000729EF001125AD001E2246002023410013249E000926EE000723
      EF000621F1004857F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007781F9000621F100062A
      F1000729EF000729EF001F265A002827310028273100242844000729EF000729
      EF00062AF1000621F100757FF900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000420F600062AF100062A
      F1000732EF000729EF000D2DC8001C2A70001E296C000F2CBE000732EF00072E
      EE00062AF100062AF1000420F600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007781F9000328F6000631F0000631
      F0000732EF000631F0000631F0000B31DC000B31DC000732EF000631F0000631
      F0000631F0000631F0000328F6007781F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003547F8000631F0000439F6000439
      F6000439F6000638F2000439F6001C359B001F368F000439F6000439F6000638
      F2000439F6000439F6000631F0003043F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000142BF7000439F6000541F4000541
      F4000541F4000541F4000541F400283A80002B3D78000541F4000541F4000541
      F4000541F4000541F4000439F600102AF8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000142CF7000242F700034AF500034A
      F500034AF500034AF500044AF2003E4358003E435800044AF200034AF500034A
      F500034AF500034AF5000541F400102AF8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003548F9000242F7000557F8000557
      F8000557F8000557F8001453D00043435B0043435B001453D0000557F8000557
      F8000557F8000557F8000242F7003548F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007987FA000242F7001468FA001468
      FA001468FA001468FA002C58AD0050505B0050505B00335CA4001468FA001468
      FA001468FA001468FA000242F7007781F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000328F6002972FB003280
      FA003280FA003280FA00435C8C004E5067004E506700445887003280FA003280
      FA003280FA002972FB000328F600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007987FA001042FC005796
      FC005D9DFB005D9DFB004C5782004C4C72004C4C72004C557C005D9DFB005D9D
      FB005897FB001042FC007781F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005263F9001A4A
      FD007BA9FC0092BEFD007E9DC900606D7E00606D7E007C99C40092BEFD007BA9
      FC001A4AFD004E61F90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007987
      FA00092EFB004570FD0084A7FE00A3C0FD00A3C0FD0084A7FE004570FD00102A
      F8007987FA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008592F8003548F9001531F9001531F9003548F900808DF9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DDD09100D0B95C00C7AD3E00C7AD3E00D0B95C00DCD08E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000078BDF70034A0F7001190F6001190F600339FF70077BDF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DDD0
      9100C4A93600C1A53500C1A53500C1A53500C1A53500C1A53500C1A53500C4A9
      3600DCD08E0000000000000000000000000000000000000000000000000074BB
      F900028EF6000791F3000891F1000891F1000894F6000891F1000791F300028E
      F60077BDF7000000000000000000000000000000000031636300639C9C00639C
      9C00313131003131310031313100313131003131310031313100B5B5B500B5B5
      B500313131000063630000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00DEDEDE00DEDEDE00CECECE00CECECE00B5B5B500B5B5B5000000
      00005A5A5A000000000000000000000000000000000000000000D3C36E00C1A5
      3500C1A53500C1A535008D7930003D3926003A36260081702E00C1A53500C1A5
      3500C1A53500D3C36E000000000000000000000000000000000046A6F7000791
      F3000A92ED000A92ED001670AC00262E3400292C2E0018679B000891F1000A92
      ED000791F30043A5F70000000000000000000000000031636300639C9C009CCE
      CE004A4A4A004A4A4A0031313100313131003131310031313100CECECE00B5B5
      B50031313100639C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005A5A5A00000000000000000000000000DDD09100C1A53500C1A0
      3600BE9D3600BE9D36004D462A002E2E29002E2E29003D392A00BE9D3600BE9D
      3600C1A53500C1A53500DDCF8E00000000000000000074BBF9000791F3000999
      F1000A92ED000999F100273945002C2928002C2928002C2928000999F1000A92
      ED000A99ED000791F30074BBF9000000000000000000316363009CCECE009CCE
      CE004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A0031313100FFFFFF00CECE
      CE0031313100639C9C00000000000000000084848400FFFFFF00FFFFFF00DEDE
      DE00CECECE00CECECE00CECECE0000FF000000FF000000FF0000CECECE00CECE
      CE000000000000000000000000000000000000000000C4A93600C1A53500C1A0
      3600BE9D3600BE9D3600A28633005E522D005E522D009A803200BE9D3600BE9D
      3600BE9D3600C1A03600C4A9360000000000000000000191F8000999F1000A99
      ED000A99ED000A99ED001187CC00264C6200274A5E001480C0000999F1000A99
      ED000A99ED000999F1000791F3000000000000000000316363009CCECE009CCE
      CE004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A0031313100639C9C00000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00DEDEDE00CECECE00CECECE00008400000084000000840000CECECE00CECE
      CE0000000000848484000000000000000000DDD09100C1A53500C3943600C1A0
      3600C3943600BE9D3600BE9D3600B18F3500AE8E3500BE9D3600BE9D3600C394
      3600BE9D3600C1A03600C1A03600DDCF8E0079C1F9000999F10007A0F200089E
      EE00089EEE00089EEE0008A0F1000D97E3000D97E30007A0F200089EEE00089E
      EE00089EEE0007A0F2000999F10076C1F9000000000031636300CEFFFF009CCE
      CE009CCECE009CCECE009CCECE009CCECE009CCECE009CCECE009CCECE009CCE
      CE009CCECE00639C9C0000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840000000000848484008484840000000000D0B95C00C1A03600C3943600C394
      3600C3943600C3943600C3943600806B350078653600C3943600C3943600BE9D
      3600C3943600C3943600C1A03600CEB9590036A2F80007A0F20008A0F10009A5
      F00009A5F00008A0F10006A9F500246C8E002763810009A5F00009A5F00009A5
      F00009A5F00008A0F10006A1F50031A1F8000000000031636300CEFFFF009CCE
      CE00316363003163630031636300316363003163630031636300316363003163
      63009CCECE00639C9C00000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DEDEDE00DEDEDE00CECECE00CECECE00CECECE000000
      000084848400000000008484840000000000C8AD4200C3943600C3943600C394
      3600C3943600C3943600C39436006C5D380068593A00C3943600C3943600C394
      3600C3943600C3943600C3943600C7AD3E001495F60006A9F50004B6F70007B0
      F20004B6F70009A5F00004B6F70033607200355C6B0004B3F90007B0F20004B6
      F70009A5F00004B6F70006A9F5000894F6000000000031636300CEFFFF00639C
      9C00CEFFFF00CEFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF00316363009CCECE0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840000000000848484000000000000000000C8AD4200C3943600C38C3400C38C
      3400C38C3400C38C3400C08B3400524E4300524E4300C08B3400C38C3400C38C
      3400C38C3400C38C3400C3943600C7AD3E001495F60004B3F90004BCF40004BC
      F40004BCF40004BCF40003C0FB00494848004948480003C0FB0004BCF40004BC
      F40004BCF40004BCF40004BCF4001495F6000000000031636300CEFFFF00639C
      9C00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF009CFFFF009CFF
      FF00316363009CCECE000000000000000000000000000000000084848400CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000084848400000000008484840000000000D0B95C00C5923400C38C3400C38C
      3400C38C3400C38C3400AB7C3A00524E430056544700AB7C3A00C38C3400C38C
      3400C5893600C38C3400C5923400D0B95C0036A2F80004B6F70008C9F80008C9
      F80007C9F60008C9F80017AED300514949005149490018ACD00008C9F80007C9
      F60007C9F60008C9F80004B6F70036A2F8000000000031636300CEFFFF00639C
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEFFFF00CEFFFF00CEFFFF009CFF
      FF00316363009CCECE0000000000000000000000000000000000000000008484
      8400FFFFFF00FF313100FF313100FF313100FF313100FF313100FFFFFF000000
      000000000000000000000000000000000000DFD09400C8993800CA8C4200CA8C
      4200CA8C4200CA8C42009272460059585200595852008C6E4A00CA8C4200CA8C
      4200CA8C4200CA8C4200C8993800DDCF8E0079C1F90008B5FB0015D4F90015D4
      F90015D4F90013D7FE003791A3005653520056535200398E9E0015D4F90015D4
      F90015D4F90015D4F90008B5FB0076C1F9000000000031636300CEFFFF00639C
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEFFFF00CEFFFF009CFF
      FF00316363009CCECE0000000000000000000000000000000000000000008484
      8400CECECE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE000000000000000000000000000000000000000000C8A53700D09A5400D198
      5A00D1985A00D1985A007D6A5100615F5300615F53007D6A5100D1985A00D198
      5A00D1985A00D09A5400C8A5370000000000000000000098FB002DD9FA0034DF
      FB0032DFFB0034DFFB0053757B005B595A005B595A00556E730034DFFB0034DF
      FB0034DFFB002DD9FA000098FB00000000000000000031636300CEFFFF00639C
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEFFFF00CEFFFF009CFF
      FF00316363003163630000000000000000000000000000000000000000000000
      000084848400FFFFFF00FF633100FF633100FF633100FF633100FF633100FFFF
      FF000000000000000000000000000000000000000000DFD09400CBA24000D9AC
      7800D9AC7800D9AC7800776D56006A6753006A675300776D5600DAAB7C00D9AC
      7800D9AC7800CBA24000DECF9000000000000000000079C1F90008B5FB0061E8
      FB005EE8FC005EEFFF005D6464005B595A005D5D5E005D5D5E005EEFFF005EE8
      FC005EE8FC0008B5FB0074BBF900000000000000000031636300FFFFFF00639C
      9C00639C6300639C6300639C6300639C6300639C6300639C6300639C6300639C
      630031636300C6C6C60000000000000000000000000000000000000000000000
      000084848400CECECE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CECECE000000000000000000000000000000000000000000D6C37400CEA6
      4800E1C09600E6C7A700B9A38D00766D6500766D6500B5A08A00E6C7A700E1C0
      9600CEA64800D6C37400000000000000000000000000000000004CABF80014B4
      FD0087ECFD009CF6FF0087C0C600666A6A00666A6A0086BABF009CF6FF0087EC
      FD0014B4FD004CABF8000000000000000000000000003163630031636300639C
      9C00639C6300639C6300639C6300639C6300639C6300639C6300639C6300639C
      6300316363003163630000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      840084848400848484000000000000000000000000000000000000000000E0D2
      9800C7AD3E00D7B46A00E4C99C00EAD4B500EAD4B500E4C99C00D7B46A00C9A6
      3A00E0D2980000000000000000000000000000000000000000000000000079C1
      F9000098FB0044C7FE008BE7FF00B0F6FF00B0F6FF008BE7FF0046C9FE000098
      FB0079C1F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E0D29800D0B95C00C8AD4200C8AD4200D0B95C00E0D29C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000086C8F80038A5F8001598F8001598F80037A5FA0086C8F8000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00F81F000000000000E007000000000000
      C003000000000000800100000000000080010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080010000000000008001000000000000C003000000000000
      E007000000000000F81F000000000000FFFFFFFFF81FF81FC001C007E007E007
      80018003C003C003800100018001800180010001800180018001000100000000
      8001000000000000800100000000000080018000000000008001C00000000000
      8001E001000000008001E007800180018001F007800180018001F003C003C003
      8001F803E007E007FFFFFFFFF81FF81F00000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Left = 80
    Top = 56
    object Save: TAction
      Caption = 'Save'
      Hint = 'Save'
      ImageIndex = 0
      ShortCut = 16467
      OnExecute = SaveExecute
    end
    object Print: TAction
      Caption = '&Print'
      Hint = 'Print'
      ImageIndex = 1
      ShortCut = 16464
      OnExecute = PrintExecute
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'CSV File (*.csv)|*.csv|Binary File (*.dat)|*.dat'
    Left = 136
    Top = 56
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 208
    Top = 56
    object mnuInformation: TMenuItem
      AutoCheck = True
      Caption = 'Information'
      ImageIndex = 2
      RadioItem = True
      OnClick = mnuInformationClick
    end
    object mnuWarning: TMenuItem
      AutoCheck = True
      Caption = 'Warning'
      ImageIndex = 3
      RadioItem = True
      OnClick = mnuWarningClick
    end
    object mnuError: TMenuItem
      AutoCheck = True
      Caption = 'Error'
      ImageIndex = 4
      RadioItem = True
      OnClick = mnuErrorClick
    end
  end
end
