object BEWizardForms: TBEWizardForms
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Boss Experts'
  ClientHeight = 361
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    644
    361)
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
    AlignWithMargins = True
    Left = 0
    Top = 324
    Width = 644
    Height = 37
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Right = 8
    Padding.Bottom = 10
    TabOrder = 6
    object btnInstall: TButton
      AlignWithMargins = True
      Left = 8
      Top = 0
      Width = 91
      Height = 27
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Install'
      TabOrder = 0
      OnClick = btnInstallClick
    end
    object btnUpdate: TButton
      AlignWithMargins = True
      Left = 103
      Top = 0
      Width = 91
      Height = 27
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Update'
      TabOrder = 1
      OnClick = btnUpdateClick
    end
    object btnUninstall: TButton
      AlignWithMargins = True
      Left = 198
      Top = 0
      Width = 91
      Height = 27
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Uninstall'
      TabOrder = 2
      OnClick = btnUninstallClick
    end
    object btnLogin: TButton
      AlignWithMargins = True
      Left = 293
      Top = 0
      Width = 91
      Height = 27
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Login'
      TabOrder = 3
      OnClick = btnLoginClick
    end
    object btnClose: TButton
      AlignWithMargins = True
      Left = 545
      Top = 0
      Width = 91
      Height = 27
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
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
    Width = 303
    Height = 268
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 5
    OnClick = lstHistoryClick
  end
  object lstDependencies: TListBox
    Left = 8
    Top = 111
    Width = 313
    Height = 207
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 3
    OnClick = lstDependenciesClick
  end
  object edtSearch: TEdit
    Left = 333
    Top = 23
    Width = 303
    Height = 21
    Hint = 'History search  '
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnChange = edtSearchChange
  end
end
