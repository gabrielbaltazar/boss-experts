object BEWizardForms: TBEWizardForms
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'BEWizardForms'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 268
    Width = 645
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnInstall: TButton
      Left = 105
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Install'
      TabOrder = 0
    end
    object btnUpdate: TButton
      Left = 202
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Update'
      TabOrder = 1
    end
    object btnLogin: TButton
      Left = 536
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Login'
      TabOrder = 2
    end
    object btnUninstall: TButton
      Left = 299
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Uninstall'
      TabOrder = 3
    end
    object btnInit: TButton
      Left = 8
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Init'
      TabOrder = 4
      OnClick = btnInitClick
    end
  end
end
