# Deploy do Frontend para Vercel com GitHub Actions

Este guia explica como configurar o deploy automático do seu projeto frontend (React) para a Vercel utilizando **GitHub Actions** e um token de autenticação da Vercel.

## Passo 1: Gerar um Token de Acesso da Vercel

O token de acesso da Vercel é necessário para autenticar e realizar o deploy através da linha de comando (CLI) da Vercel. Siga os passos abaixo para gerar um novo token:

1. **Acesse sua conta da Vercel**:
   - Vá até [https://vercel.com](https://vercel.com) e faça login na sua conta.

2. **Gerar um Novo Token de Acesso**:
   - No canto superior direito, clique no seu **avatar** e selecione **Settings**.
   - No menu lateral esquerdo, clique em **Tokens** (ou **Access Tokens**).
   - Clique no botão **Create New Token**.
   - Copie o token gerado, pois você precisará dele nos próximos passos.

---

## Passo 2: Adicionar o Token no GitHub Secrets

Agora que você tem o token da Vercel, é hora de adicioná-lo como um **secret** no seu repositório do GitHub para garantir que ele seja utilizado de maneira segura no GitHub Actions.

1. **Acesse seu repositório no GitHub**.
   
2. **Ir para a seção de Secrets**:
   - No menu do seu repositório, clique em **Settings**.
   - No menu lateral esquerdo, clique em **Secrets and variables** > **Actions**.
   
3. **Adicionar um novo Secret**:
   - Clique no botão **New repository secret**.
   - No campo **Name**, insira **`VERCEL_TOKEN`** (o nome do segredo deve ser exatamente este).
   - No campo **Value**, cole o **token** da Vercel que você gerou.
   - Clique em **Add secret** para salvar.

---

## Passo 3: Criar o Arquivo de Workflow no GitHub Actions

Agora, vamos criar um arquivo de configuração do GitHub Actions para automatizar o deploy do seu frontend para a Vercel.

1. **Crie o diretório `.github/workflows`** no seu repositório (se ainda não existir).

2. **Crie o arquivo `deploy-frontend.yml` dentro do diretório `.github/workflows`** com o seguinte conteúdo:

```yaml
name: Deploy Frontend to Vercel

on:
  push:
    branches:
      - main  # Ou qualquer outra branch que você deseje monitorar

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'  # Ou a versão do Node.js que você estiver usando

      - name: Install dependencies
        run: npm ci  # Instala as dependências usando o npm ci

      - name: Build the project
        run: npm run build  # Executa o build do projeto React

      - name: Deploy to Vercel
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}  # Usando o token armazenado no GitHub Secrets
        run: npx vercel --prod --yes  # Deploy para o ambiente de produção da Vercel
