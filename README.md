# **Deploy do Frontend no Vercel usando GitHub Actions**

Este repositório contém um projeto frontend construído com React. Este guia explica como configurar um workflow do GitHub Actions para realizar o deploy automático do seu projeto no Vercel sempre que houver alterações na branch `main`.

---

## **Índice**
- [Pré-requisitos](#pré-requisitos)
- [Criar o Arquivo de Workflow](#criar-o-arquivo-de-workflow)
- [Configurar Segredos no GitHub](#configurar-segredos-no-github)
- [Testar o Workflow](#testar-o-workflow)
- [Verificar o Deploy](#verificar-o-deploy)
- [Notas](#notas)

---

## **Pré-requisitos**

Antes de configurar o workflow, certifique-se de que você possui:

1. **Conta no Vercel**: Você precisa de uma conta no [Vercel](https://vercel.com/).
2. **Repositório no GitHub**: O projeto deve estar em um repositório do GitHub.
3. **Configuração da Branch**: Certifique-se de que sua branch padrão se chama `main` (ou atualize o arquivo de workflow se usar outro nome).

---

## **Criar o Arquivo de Workflow**

1. Navegue até a pasta `.github/workflows/` no seu repositório.
2. Crie um arquivo chamado `production.yaml`.
3. Adicione o seguinte conteúdo:

```yaml
name: Vercel Production Deployment
env:
  VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
  VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
on:
  push:
    branches:
      - main
jobs:
  Deploy-Production:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install Vercel CLI
        run: npm install --global vercel@latest
      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=production --token=${{ secrets.VERCEL_TOKEN }}
      - name: Build Project Artifacts
        run: vercel build --prod --token=${{ secrets.VERCEL_TOKEN }}
      - name: Deploy Project Artifacts to Vercel
        run: vercel deploy --prebuilt --prod --token=${{ secrets.VERCEL_TOKEN }}
```

---

## **Configurar Segredos no GitHub**

Adicione os valores necessários do Vercel como segredos no GitHub:

1. **Recuperar o Token de Acesso do Vercel**:
   - Instale o Vercel CLI executando o comando:
     ```bash
     npm install -g vercel
     ```
   - Faça login na sua conta Vercel:
     ```bash
     vercel login
     ```
   - Dentro da pasta do seu projeto, execute o seguinte comando para vincular o projeto ao Vercel:
     ```bash
     vercel link
     ```
   - Localize os valores `projectId` e `orgId` no arquivo `.vercel/project.json` gerado pelo comando acima.

2. **Adicionar Segredos no GitHub**:
   - No GitHub, acesse **Settings** do seu repositório.
   - Vá para **Secrets and variables > Actions**.
   - Adicione os seguintes segredos:
     - `VERCEL_TOKEN`: O token de acesso gerado no Vercel.
     - `VERCEL_ORG_ID`: O valor `orgId` do arquivo `.vercel/project.json`.
     - `VERCEL_PROJECT_ID`: O valor `projectId` do arquivo `.vercel/project.json`.

---

## **Testar o Workflow**

1. Faça o commit e o push do arquivo `production.yaml` para a branch `main`.
2. Realize qualquer alteração no código e faça o push na branch `main`.
3. Acesse a aba **Actions** no seu repositório para monitorar o progresso do workflow.

---

## **Verificar o Deploy**

1. Acesse o painel do Vercel.
2. Confira se o deployment mais recente foi bem-sucedido.
3. Acesse a URL do deployment para garantir que o frontend está funcionando corretamente.

---

## **Notas**

- Certifique-se de que a versão do Node.js configurada no workflow (`node-version`) é compatível com o seu projeto.
- Verifique se o `package.json` contém o script correto de build, como `react-scripts build` para projetos criados com Create React App.
- Caso utilize variáveis de ambiente no frontend, configure-as diretamente no painel do Vercel nas configurações do projeto.
