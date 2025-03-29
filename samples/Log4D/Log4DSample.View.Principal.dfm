object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Log4D Sample'
  ClientHeight = 344
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Memo1: TMemo
    Left = 24
    Top = 32
    Width = 553
    Height = 265
    TabOrder = 0
  end
  object Button2: TButton
    Left = 24
    Top = 303
    Width = 281
    Height = 25
    Caption = 'Generate Logs'
    TabOrder = 1
    OnClick = Button2Click
  end
end
