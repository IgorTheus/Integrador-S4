# Integrador S4

# Equipe
- Danilo Macri da Silva
- Danilo Nunes Fernandes
- Igor Matheus Mariano da Silva
- Kauã Rodrigues de Aguiar

#

Aplicativo mobile em Flutter para escaneamento de QR Code de ativos, com login, cadastro e navegação entre telas principais (Dashboard, Histórico, Home, QRCode e RA).

## Pré-requisitos

Antes de rodar o projeto, você precisa ter instalado:

- Flutter SDK - [guia de instalação](https://docs.flutter.dev/get-started/install)
- Android Studio 
- Um dispositivo Android físico
- Cabo USB

Para conferir se está tudo certo, rode no terminal:

```bash
flutter doctor
```

```bash
flutter pub get
```

# Como rodar
## Emulador

1. No VSCode, acesse o aqruivo main.dart e clique Run without debugger.
2. Caso não tenha, crie um emulador via Android Studio que o aplicativo irá rodar.



## Gerar APK

1. Rode:
```bash
flutter build apk --release
```
Onde um arquivo APK será gerado em:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

2. Transfira esse arquivo para o celular (via cabo USB, e-mail, Drive, etc.) e instale normalmente, permitindo a instalação de "fontes desconhecidas" se o Android pedir.


## Funcionalidades implementadas até o momento

### Autenticação
- **Login**: tela com logo, campos de usuário e senha, e link para cadastro.
- **Cadastro**: tela com usuário, senha e confirmação de senha, com validação de senha != confirmação, e link para voltar ao login.

### Navegação principal
- **AppBar padrão**: logo do app, saudação ao usuário e botão de menu.
- **NavBar padrão**: navegação fixa entre as 5 telas principais - Dashboard, Histórico, Home, QRCode e RA. com destaque visual do item selecionado.

### Home
- Card de destaque para escanear QR Code.
- Botões de atalho para Dashboard, Histórico e RA.

### Escanear QR Code
- Tela inicial explicando o uso, com botão **"LIGAR CÂMERA"**.
- Câmera ativa com leitura de QR Code em tempo real, moldura de mira, controle de flash e atalho para galeria (ainda não implementado).
- Após a leitura, o valor escaneado é armazenado e exibido na tela inicial do QRCode (card "Último QR Code lido").

### Dashboard, Histórico e RA
- Telas básicas criadas e navegáveis pela NavBar (conteúdo ainda a ser desenvolvido).

---
