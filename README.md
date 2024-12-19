# Deploy do Frontend no Vercel usando GitHub Actions

Este repositório contém um projeto frontend construído com React. Este guia explica como configurar um workflow do GitHub Actions para realizar o deploy automático do seu projeto no Vercel sempre que houver alterações na branch `main`.

---

## **Pré-requisitos**

Antes de configurar o workflow, certifique-se de que você possui:

1. **Conta no Vercel**: Você precisa de uma conta no [Vercel](https://vercel.com/).
2. **Repositório no GitHub**: O projeto deve estar em um repositório do GitHub.
3. **Configuração da Branch**: Certifique-se de que sua branch padrão se chama `main` (ou ajuste o arquivo de workflow se usar outro nome).

---

## **Configuração do Workflow**

Vamos criar o workflow para deploy de produção no Vercel.

### **1. Criar o Arquivo do Workflow**

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
2. Configurar Segredos no GitHub
Adicione os valores necessários do Vercel como segredos no GitHub:

Recuperar o Token de Acesso do Vercel:

Instale o Vercel CLI e faça login com o comando vercel login.
Dentro da sua pasta do projeto, execute vercel link para criar ou vincular um projeto existente no Vercel.
Localize os valores projectId e orgId no arquivo .vercel/project.json.
Adicionar Segredos no GitHub:

No GitHub, acesse Settings do seu repositório.
Vá para Secrets and variables > Actions.
Adicione os seguintes segredos:
VERCEL_TOKEN: O token de acesso gerado no Vercel.
VERCEL_ORG_ID: O valor orgId do arquivo .vercel/project.json.
VERCEL_PROJECT_ID: O valor projectId do arquivo .vercel/project.json.
Testar o Workflow
Faça o commit e o push do arquivo production.yaml para a branch main.
Realize qualquer alteração no código e faça o push na branch main.
Verifique a aba Actions no repositório para monitorar o progresso do workflow.
Verificar o Deploy
Acesse o painel do Vercel.
Confira se o deployment mais recente foi bem-sucedido.
Acesse a URL do deployment para garantir que o frontend está funcionando corretamente.
Notas
Certifique-se de que a versão do Node.js configurada no workflow (node-version) é compatível com o seu projeto.
Verifique se o package.json contém o script correto de build, como react-scripts build para projetos criados com Create React App.
Caso utilize variáveis de ambiente no frontend, configure-as diretamente no painel do Vercel nas configurações do projeto.
