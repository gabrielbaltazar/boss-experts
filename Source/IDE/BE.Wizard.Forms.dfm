object BEWizardForms: TBEWizardForms
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Boss Experts'
  ClientHeight = 309
  ClientWidth = 654
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
    Top = 50
    Width = 60
    Height = 13
    Caption = 'Dependency'
  end
  object Label2: TLabel
    Left = 256
    Top = 50
    Width = 35
    Height = 13
    Caption = 'Version'
  end
  object Label4: TLabel
    Left = 333
    Top = 5
    Width = 34
    Height = 13
    Caption = 'History'
  end
  object Label5: TLabel
    Left = 8
    Top = 96
    Width = 67
    Height = 13
    Caption = 'Dependencies'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 268
    Width = 654
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
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
      Left = 299
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Login'
      TabOrder = 3
      OnClick = btnLoginClick
    end
    object btnClose: TButton
      Left = 555
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Close'
      TabOrder = 4
      OnClick = btnCloseClick
    end
  end
  object edtHostLogin: TComboBox
    Left = 8
    Top = 23
    Width = 313
    Height = 21
    ItemIndex = 1
    TabOrder = 0
    Text = 'github.com'
    Items.Strings = (
      'bitbucket.org'
      'github.com'
      'gitlab.com')
  end
  object edtDependency: TEdit
    Left = 8
    Top = 68
    Width = 242
    Height = 21
    TabOrder = 1
  end
  object edtVersion: TEdit
    Left = 256
    Top = 68
    Width = 65
    Height = 21
    TabOrder = 2
  end
  object lstHistory: TListBox
    Left = 333
    Top = 50
    Width = 313
    Height = 212
    ItemHeight = 13
    TabOrder = 5
    OnClick = lstHistoryClick
  end
  object lstDependencies: TListBox
    Left = 8
    Top = 111
    Width = 313
    Height = 151
    ItemHeight = 13
    TabOrder = 3
    OnClick = lstDependenciesClick
  end
  object edtSearch: TEdit
    Left = 333
    Top = 23
    Width = 313
    Height = 21
    TabOrder = 4
    OnChange = edtSearchChange
  end
end
