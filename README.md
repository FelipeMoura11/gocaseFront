# Deploy do Frontend no Vercel usando GitHub Actions

Este repositório contém um projeto frontend construído com React. Este guia explica como configurar um workflow do GitHub Actions para realizar o deploy automático do seu projeto no Vercel sempre que houver alterações na branch `main`.

## Pré-requisitos

Antes de configurar o workflow, certifique-se de que você possui:

1. **Conta no Vercel**: Você precisa de uma conta no [Vercel](https://vercel.com/).
2. **Token de Acesso Pessoal**: Gere um token no painel do Vercel para autenticar os deployments.
3. **Repositório no GitHub**: O projeto deve estar em um repositório do GitHub.
4. **Configuração da Branch**: Certifique-se de que sua branch padrão se chama `main` (ou atualize o arquivo de workflow se usar outro nome).

## Passos para Configurar o Workflow

### 1. Gerar um Token no Vercel

1. Acesse seu [Painel do Vercel](https://vercel.com/dashboard).
2. Vá para **Settings** > **Tokens**.
3. Clique em **Create Token** e copie o token gerado.

### 2. Adicionar o Token aos Segredos do GitHub

1. Acesse seu repositório no GitHub.
2. Vá para **Settings** > **Secrets and variables** > **Actions**.
3. Clique em **New repository secret**.
4. Adicione um novo segredo com as seguintes informações:
   - **Name**: `VERCEL_TOKEN`
   - **Value**: Cole o token do Vercel copiado anteriormente.

### 3. Criar o Arquivo de Workflow

1. No seu repositório, navegue até a pasta `.github/workflows/`.
2. Crie um arquivo chamado `deploy-frontend.yml`.
3. Adicione o seguinte conteúdo ao arquivo:

```yaml
name: Deploy Frontend to Vercel

on:
  push:
    branches:
      - main

jobs:
  deploy:
    name: Deploy Frontend
    runs-on: ubuntu-latest

    steps:
      # Passo 1: Baixar o código do repositório
      - name: Checkout code
        uses: actions/checkout@v3

      # Passo 2: Configurar o Node.js
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18 # Use a versão do Node.js requerida pelo seu projeto

      # Passo 3: Instalar dependências
      - name: Install dependencies
        run: npm ci

      # Passo 4: Build do projeto
      - name: Build project
        run: npm run build

      # Passo 5: Deploy no Vercel
      - name: Deploy to Vercel
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
        run: npx vercel --prod
```

### 4. Testar o Workflow

1. Faça o commit e o push do arquivo `deploy-frontend.yml` para a branch `main`.
2. Faça qualquer alteração e realize o push na branch `main`. Verifique a aba **Actions** no seu repositório para monitorar o processo de deployment.

### 5. Verificar o Deploy

1. Acesse o painel do Vercel.
2. Verifique se o deployment mais recente foi bem-sucedido.
3. Acesse a URL de deployment para confirmar que o frontend está no ar.

## Notas

- A versão do `node-version` no arquivo de workflow deve corresponder à versão necessária para o seu projeto.
- Certifique-se de que o `package.json` possui o script de build correto (por exemplo, `react-scripts build` para projetos criados com Create React App).
- Caso utilize variáveis de ambiente no frontend, configure-as nas configurações do projeto no Vercel.
