<p align="center">
  <a href="https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/logo.png">
    <img alt="LoadPhotoFromURL" src="https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/logo.png">
  </a>
</p>

# LoadPhotoFromURL
Essa classe foi criada para facilitar o carregamento de imagens e miniaturas usando a URL do arquivo.

## Instalação
Basta declarar no Library Path do seu Delphi o caminho da pasta SOURCE da biblioteca, ou se preferir, você pode usar o Boss (gerenciador de dependências do Delphi) para realizar a instalação:
```
boss install github.com/adrianosantostreina/LoadPhotoFromURL
```

## Uso
Declare uBitmapHelper na seção Uses da unit onde você deseja fazer a chamada para o método da classe.
```delphi
use
   uBitmapHelper;
```
Em seguida, basta adicionar um componente do tipo TImage ao formulário ou criar uma variável desse tipo se desejar.

## Carregando uma imagem em tamanho real
```delphi
procedure TForm5.Button1Click(Sender: TObject);
begin
  Image1.Bitmap := nil;
  Image1.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno1.jpg');
end;
```

## Carregando uma miniatura de imagem
```delphi
procedure TForm5.Button2Click(Sender: TObject);
begin
  Image1.Bitmap := nil;
  Image1.Bitmap.LoadThumbnailFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno1.jpg', 50, 50);
end;
```

## Carregando várias imagens ao mesmo tempo
* Crie uma lista de URLs
```delphi
procedure TForm5.Button3Click(Sender: TObject);
var
  LThread: TThread;
begin
  LThread :=
    TThread.CreateAnonymousThread(
    procedure()
    var
      I: Integer;
    begin
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          Image1.BeginUpdate;
          Image2.BeginUpdate;
          Image3.BeginUpdate;
          Image4.BeginUpdate;

          Image1.Bitmap := nil;
          Image2.Bitmap := nil;
          Image3.Bitmap := nil;
          Image4.Bitmap := nil;
        end
        );

      for I := 0 to Pred(ListBox1.Items.Count) do
      begin
        TThread.Synchronize(
          TThread.CurrentThread,
          procedure()
          begin
            //
            case I of
              1: Image2.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno1.jpg');
              0: Image1.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno2.jpg');
              2: Image3.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno3.jpg');
              3: Image4.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno4.jpg');
            end;
          end
        )
      end;

      Image1.EndUpdate;
      Image2.EndUpdate;
      Image3.EndUpdate;
      Image4.EndUpdate;
    end
    );
  LThread.Start;
end;
```

## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/README-ptBR.md)<br>

## ⚠️ Licença
`LoadPhotoFromURL` é uma biblioteca gratuita e de código aberto licenciado sob a [Licença MIT](https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/LICENSE.md).