# desafio_tecnico_getconnect
Desafio Técnico - Desenvolvedor Flutter Pleno

![Build Status](https://img.shields.io/badge/build-passing-brightgreen) ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=flat&logo=firebase)

Aplicativo de chat global em tempo real desenvolvido em Flutter, utilizando Firebase (Auth e Firestore) como backend. O projeto foi estruturado com foco em escalabilidade, manutenibilidade e separação clara de responsabilidades.

## 🏗️ Arquitetura e Tecnologias

O aplicativo foi construído seguindo os princípios da **Clean Architecture** e do **SOLID**, garantindo que as regras de negócio fiquem totalmente isoladas da interface de usuário e de pacotes externos.

* **Flutter & Dart**
* **GetX**: Utilizado para Gerenciamento de Estado Reativo (`GetxController`), Injeção de Dependências (`Bindings` e Inversão de Controle) e Roteamento (`GetMiddleware` para Auto-Login).
* **Firebase Authentication**: Gestão de credenciais com espelhamento de status de sessão.
* **Cloud Firestore**: Banco de dados NoSQL para sincronização das mensagens e status de presença (isOnline) em tempo real via Streams.

## ✨ Destaques Técnicos

* **Separação em Camadas (Features)**: Divisão clara entre `Domain` (Regras de negócio e Contratos), `Data` (Modelos, Repositórios e DataSources) e `Presentation` (UI, Controllers e Bindings).
* **Tratamento de Erros Customizado**: Implementação de exceções de domínio tipadas (ex: `InvalidEmailException`, `BlankMessageException`), isolando o tratamento de falhas.
* **Gerenciamento de Ciclo de Vida**: Utilização do `WidgetsBindingObserver` para monitorar o estado do aplicativo (Background/Foreground) e atualizar a presença do usuário em tempo real.
* **Segurança de Repositório**: Chaves de API e arquivos de configuração do Firebase (`firebase_options.dart`, `google-services.json`) foram ignorados no controle de versão.
* **Sistema de Presença (Firestore + Realtime Database)** : Conforme solicitado no documento, o Cloud Firestore foi utilizado como banco de dados principal para o chat global, eliminando totalmente a necessidade de infraestrutura customizada de WebSockets para o tráfego de mensagens. No entanto, para atender perfeitamente ao requisito de alteração de status para offline no encerramento abrupto do aplicativo (kill process), foi implementado o padrão oficial de presença do Firebase. Utilizou-se o Realtime Database em conjunto com o gatilho onDisconnect(), visto que o Firestore não possui ganchos nativos de persistência para quedas repentinas de conexão no lado do servidor.
> **Referência Oficial:** [Criar presença no Cloud Firestore | Firebase](https://firebase.google.com/docs/firestore/solutions/presence)

## 🚀 Como Executar o Projeto

Como as chaves do Firebase não estão versionadas no repositório por segurança, você precisará conectar o aplicativo a um projeto Firebase próprio para testar a comunicação.

### Pré-requisitos
* Flutter SDK instalado.
* [Firebase CLI](https://firebase.google.com/docs/cli) instalado e logado (`firebase login`).
* Um projeto criado no [Firebase Console](https://console.firebase.google.com/) com **Authentication** (Email/Password), **Firestore Database** e **Realtime Database** ativados. *(Importante: crie o Realtime Database antes de seguir para o próximo passo).*

### Passo a Passo

1. **Clone o repositório e instale as dependências:**
   ```bash
   git clone <URL_DO_SEU_REPOSITORIO>
   cd <NOME_DA_PASTA>
   flutter pub get

2.  **Gere os arquivos de configuração do Firebase:**
    Certifique-se de ter o FlutterFire CLI ativado globalmente no Dart:
    ```bash
    dart pub global activate flutterfire_cli
    ```
    Em seguida, rode o comando abaixo na raiz do projeto e selecione o seu projeto Firebase criado:
    ```bash
    flutterfire configure
    ```
    *(Este comando irá gerar automaticamente o arquivo `lib/firebase_options.dart` e os arquivos nativos necessários).*

3.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

📱 Funcionalidades

[x] Cadastro de novos usuários.

[x] Autenticação segura.

[x] Redirecionamento automático (Auto-login) utilizando Middlewares.

[x] Envio e recebimento de mensagens no chat global em tempo real.

[x] Listagem de usuários online em tempo real.

[x] Logout.