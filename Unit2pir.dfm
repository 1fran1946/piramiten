object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1043#1086#1083#1086#1074#1086#1083#1086#1084#1082#1072
  ClientHeight = 325
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 529
    Height = 203
    OnMouseMove = Image1MouseMove
  end
  object Button1: TButton
    Left = 232
    Top = 241
    Width = 75
    Height = 25
    Caption = 'B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
    OnMouseLeave = Button1MouseLeave
    OnMouseMove = Button1MouseMove
  end
  object Button2: TButton
    Tag = 1
    Left = 32
    Top = 241
    Width = 75
    Height = 25
    Caption = 'A'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 416
    Top = 241
    Width = 75
    Height = 25
    Caption = 'C'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 306
    Width = 545
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 77
      end
      item
        Width = 99
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 112
    Top = 248
    object Game1: TMenuItem
      Caption = 'Game'
      object New1: TMenuItem
        Caption = 'New'
        OnClick = New1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object AlCombos1: TMenuItem
        Caption = 'AlCombos'
        RadioItem = True
        OnClick = AlCombos1Click
      end
    end
    object here1: TMenuItem
      Caption = 'Here'
      OnClick = here1Click
    end
  end
end
