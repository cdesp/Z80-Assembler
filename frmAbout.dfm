object fAbout: TfAbout
  Left = 331
  Top = 119
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'About Z80 Assembler'
  ClientHeight = 244
  ClientWidth = 367
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 175
    Height = 29
    Caption = 'Z80 Assembler'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 72
    Width = 275
    Height = 20
    Caption = 'Programming By Despoinidis Chris'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 65
    Top = 160
    Width = 174
    Height = 16
    Caption = 'e-mail : cdesp72@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 138
    Width = 100
    Height = 16
    Caption = 'Assembler Site : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 109
    Top = 138
    Width = 238
    Height = 16
    Cursor = crHandPoint
    Caption = 'http://www.newbrainemu.eu/elecprojects'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label8Click
  end
  object Label9: TLabel
    Left = 209
    Top = 20
    Width = 150
    Height = 24
    Alignment = taRightJustify
    Caption = 'Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 426506
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 24
    Top = 104
    Width = 107
    Height = 13
    Caption = 'Portions by Pasmulator'
  end
  object Button1: TButton
    Left = 148
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
