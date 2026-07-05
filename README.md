# desafio_tecnico_getconnect

Desafio Tecnico - Desenvolvedor Flutter Pleno

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=flat&logo=firebase)

Aplicativo de chat global em tempo real desenvolvido em Flutter, utilizando Firebase Authentication, Cloud Firestore e Realtime Database. O foco do projeto e demonstrar organizacao de codigo, separacao de responsabilidades, uso de dados em tempo real e tratamento de erros dentro do escopo de um teste tecnico.

## Arquitetura e Tecnologias

O projeto foi organizado por features e camadas, seguindo principios de Clean Architecture de forma pragmatica para o tamanho do desafio.

- **Flutter & Dart**
- **GetX**: gerenciamento de estado com `GetxController`, injecao de dependencias com `Bindings` e roteamento com `GetMiddleware`.
- **Firebase Authentication**: cadastro, login, logout e recuperacao do usuario autenticado.
- **Cloud Firestore**: persistencia e stream em tempo real das mensagens do chat global.
- **Realtime Database**: controle de presenca online com `.info/connected` e `onDisconnect()`.

## Estrutura

```txt
lib/
  core/
    errors/
    routes/
  features/
    auth/
      data/
      domain/
      presentation/
    chat/
      data/
      domain/
      presentation/
```

- `domain`: entidades, contratos de repositorio e casos de uso.
- `data`: models, datasources e implementacoes dos repositorios.
- `presentation`: pages, widgets, controllers e bindings.

## Destaques Tecnicos

- **Separacao por feature**: `auth` e `chat` possuem suas proprias camadas.
- **Casos de uso**: regras como login, cadastro, envio de mensagem e presenca ficam fora dos widgets.
- **Streams em tempo real**: mensagens e usuarios online sao atualizados sem refresh manual.
- **Tratamento de erros customizado**: excecoes de dominio e infraestrutura sao convertidas em feedback visivel ao usuario.
- **Presenca online**: o Realtime Database foi escolhido para tratar desconexao abrupta com `onDisconnect()`, recurso que o Firestore nao oferece diretamente no cliente.
- **Arquivos sensiveis fora do Git**: configuracoes geradas pelo Firebase estao no `.gitignore`.

Referencia sobre presenca com Firebase: [Criar presenca no Cloud Firestore](https://firebase.google.com/docs/firestore/solutions/presence)

## Como Executar o Projeto

Como as chaves do Firebase nao estao versionadas no repositorio, e necessario conectar o app a um projeto Firebase proprio antes de executar.

### Pre-requisitos

- Flutter SDK instalado.
- Firebase CLI instalado e autenticado com `firebase login`.
- FlutterFire CLI disponivel.
- Projeto criado no Firebase Console com:
  - Authentication com provedor Email/Password ativado.
  - Cloud Firestore ativado.
  - Realtime Database ativado.

### Passo a Passo

1. Clone o repositorio e acesse a pasta do projeto Flutter:

```bash
git clone <URL_DO_REPOSITORIO>
cd <NOME_DA_PASTA>/desafio_tecnico_getconnect
flutter pub get
```

2. Ative o FlutterFire CLI, caso ainda nao tenha feito:

```bash
dart pub global activate flutterfire_cli
```

3. Gere os arquivos de configuracao do Firebase:

```bash
flutterfire configure
```

Esse comando deve gerar `lib/firebase_options.dart` e os arquivos nativos necessarios, como `android/app/google-services.json`.

4. Execute o aplicativo:

```bash
flutter run
```

## Funcionalidades

- [x] Cadastro de usuarios com nome, e-mail e senha.
- [x] Login com e-mail e senha.
- [x] Redirecionamento automatico para o chat quando o usuario ja esta autenticado.
- [x] Chat global em tempo real.
- [x] Mensagens com remetente, texto e horario.
- [x] Lista de usuarios online.
- [x] Logout dentro do chat.

## Observacoes

- O uso do Realtime Database foi restrito ao controle de presenca; as mensagens permanecem no Cloud Firestore conforme solicitado.
