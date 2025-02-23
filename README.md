# Task Manager

Este projeto tem como finalidade atender a parte 2 e 4 do desafio. A Task Manager é uma aplicação Flutter que permite gerenciar uma lista de tarefas com funcionalidades de adição, exclusão (com swipe para a esquerda), atualização do status (comutando entre "Pending" e "Completed") e armazenamento local utilizando Drift (SQLite). O projeto segue o padrão MVVM/Clean Architecture e utiliza o Provider para gerenciamento de estado. 

## Estrutura do Projeto

```
lib/
├── data/
│   ├── app_database.dart       # Configuração e métodos do banco de dados com Drift
│   └── task.dart               # Definição da tabela de tarefas
├── view_models/
│   └── task_view_model.dart    # Lógica de negócio e gerenciamento de estado
├── screens/
│   ├── home_screen.dart        # Tela inicial que exibe a lista de tarefas e permite excluir via swipe
│   └── add_task_screen.dart    # Tela para adição de novas tarefas
└── main.dart                   # Inicialização do aplicativo e injeção do provider
```

## Dependências

O projeto utiliza os seguintes pacotes:

- **path_provider: ^2.1.5**  
  Fornece acesso a diretórios específicos do sistema para armazenar arquivos (ex.: o arquivo SQLite).

- **provider: ^6.1.2**  
  Gerenciamento de estado e injeção de dependências, facilitando a comunicação entre widgets.

- **sqlite3_flutter_libs: ^0.5.0**  
  Inclui as bibliotecas nativas do SQLite para as plataformas suportadas, garantindo que o SQLite esteja disponível em tempo de execução.

- **drift: ^2.25.1**  
  ORM para Flutter/Dart que facilita o acesso e manipulação de bancos de dados SQLite de forma tipada e segura.

- **flutter (SDK)**  
  Framework principal para desenvolvimento de aplicações Flutter.

### Dev Dependencies

- **drift_dev: ^2.25.2**  
  Ferramenta de geração automática de código para Drift.

- **build_runner: ^2.4.15**  
  Orquestra o processo de geração de código automaticamente.

- **flutter_test (SDK)**  
  Pacote oficial de testes do Flutter para testes unitários e de widget.

## Configuração e Instalação

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/jacksonazevedo/taskmanager.git
   cd taskmanager
   ```

2. **Instale as dependências:**

   ```bash
   flutter pub get
   ```

3. **Gere os arquivos do Drift:**

   Execute o comando abaixo para gerar o arquivo `app_database.g.dart`:

   ```bash
   flutter pub run build_runner build
   ```
4. **Inicie o emulador:**

   Execute o comando abaixo para iniciar o emulador instalado em seu computador:

   ```bash
   flutter emulators --launch name_your_emulator
   ```

## Execução

Para rodar a aplicação em um dispositivo ou emulador, execute:

```bash
flutter run
```

## Testes

### Executando Todos os Testes

Antes de rodar os testes, voce deve instalar as dependencias necessarias:

```bash
sudo apt-get install libsqlite3-0 libsqlite3-dev
```


Na raiz do projeto, execute:

```bash
flutter test
```

### Executando um Teste Específico

Para rodar um teste específico, por exemplo, o teste da HomeScreen:

```bash
flutter test test/home_screen_test.dart
```

### Banco de Dados em Memória para Testes

O AppDatabase possui um construtor nomeado para testes que permite injetar um banco de dados em memória utilizando `NativeDatabase.memory()`. Isso facilita a execução dos testes sem interferir no banco de dados real.

## Funcionalidades

- **Listagem de Tarefas:**  
  Exibe uma lista de tarefas utilizando `ListView.builder`. Cada item apresenta o nome da tarefa, seu status e um switch para alternar o status.

- **Adição de Tarefas:**  
  Permite inserir uma nova tarefa por meio de um formulário. O nome é obrigatório e a descrição é opcional.

- **Exclusão com Swipe:**  
  Permite excluir tarefas deslizando o item para a esquerda, utilizando o widget `Dismissible`.

- **Armazenamento Local:**  
  Utiliza Drift para gerenciar operações com o banco de dados SQLite, armazenando as tarefas localmente.

- **Gerenciamento de Estado:**  
  Utiliza o Provider para disponibilizar o TaskViewModel em toda a árvore de widgets e atualizar a interface de forma reativa.

## Contribuição

Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões de melhorias, por favor, abra uma _issue_ ou envie um _pull request_.

## Licença

Este projeto é licenciado sob a [MIT License](LICENSE).
