object BEWizardForms: TBEWizardForms
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Boss Experts'
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
  object Label3: TLabel
    Left = 8
    Top = 5
    Width = 25
    Height = 13
    Caption = 'Login'
  end
  object Label1: TLabel
    Left = 8
    Top = 53
    Width = 60
    Height = 13
    Caption = 'Dependency'
  end
  object Label2: TLabel
    Left = 8
    Top = 100
    Width = 35
    Height = 13
    Caption = 'Version'
  end
  object Label4: TLabel
    Left = 299
    Top = 5
    Width = 34
    Height = 13
    Caption = 'History'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 268
    Width = 645
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object btnInstall: TButton
      Left = 8
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Install'
      TabOrder = 0
      OnClick = btnInstallClick
    end
    object btnUpdate: TButton
      Left = 105
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Update'
      TabOrder = 1
      OnClick = btnUpdateClick
    end
    object btnUninstall: TButton
      Left = 202
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Uninstall'
      TabOrder = 2
      OnClick = btnUninstallClick
    end
    object btnLogin: TButton
      Left = 536
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Login'
      TabOrder = 3
      OnClick = btnLoginClick
    end
  end
  object edtHostLogin: TComboBox
    Left = 8
    Top = 23
    Width = 259
    Height = 21
    TabOrder = 0
    Items.Strings = (
      'github.com'
      'gitlab.com'
      'bitbucket.org')
  end
  object edtDependency: TEdit
    Left = 8
    Top = 71
    Width = 259
    Height = 21
    TabOrder = 1
  end
  object edtVersion: TEdit
    Left = 8
    Top = 119
    Width = 113
    Height = 21
    TabOrder = 2
  end
  object lstHistory: TListBox
    Left = 299
    Top = 23
    Width = 328
    Height = 239
    ItemHeight = 13
    Items.Strings = (
      'horse'
      'horse-basic-auth'
      'horse-compression'
      'horse-cors'
      'handle-exception'
      'horse-jwt'
      'horse-logger'
      'horse-octet-stream'
      'jhonson')
    TabOrder = 4
    OnClick = lstHistoryClick
  end
end
