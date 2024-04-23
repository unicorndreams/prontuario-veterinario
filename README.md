# README

<b>Requisitos</b>
- Ruby 3.3.0
- PostgreSQL 16.2
- Rails 7.1.3
- Node.js 14.21.3

<b>Instalação</b>

- Clone o repositório para sua máquina local:<br>
```
git clone https://github.com/camila-santos-ferreira/prontuario-veterinario.git
```

- Navegue até o diretório do projeto:<br>
```
cd prontuario-veterinario
```

- Execute o comando abaixo para instalar as dependências do projeto:<br>
```
bundle install
```

<b>Configuração do banco de dados</b>

- Adicione as credenciais do PostgreSQL no arquivo config/database.yml:<br>
```
development:
  <<: *default
  database: prontuario_veterinario_development
  username: myusername
  password: mypassword
```

- Crie o banco de dados e execute as migrações:
```
rails db:create
rails db:migrate
```

<b>Inicialização do servidor</b><br>
```
rails server
```

<b>Acesso a aplicação pelo navegador<b><br>
```
localhost:3000
```
