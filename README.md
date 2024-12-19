Deploy do Frontend para Vercel com GitHub Actions

Este guia explica como configurar o deploy automático do seu projeto frontend (React) para a Vercel utilizando GitHub Actions e um token de autenticação da Vercel.

Passo 1: Gerar um Token de Acesso da Vercel

O token de acesso da Vercel é necessário para autenticar e realizar o deploy através da linha de comando (CLI) da Vercel. Siga os passos abaixo para gerar um novo token:

Acesse sua conta da Vercel:
Vá até https://vercel.com e faça login na sua conta.
Gerar um Novo Token de Acesso:
No canto superior direito, clique no seu avatar e selecione Settings.
No menu lateral esquerdo, clique em Tokens (ou Access Tokens).
Clique no botão Create New Token.
Copie o token gerado, pois você precisará dele nos próximos passos.
Passo 2: Adicionar o Token no GitHub Secrets

Agora que você tem o token da Vercel, é hora de adicioná-lo como um secret no seu repositório do GitHub para garantir que ele seja utilizado de maneira segura no GitHub Actions.

Acesse seu repositório no GitHub.
Ir para a seção de Secrets:
No menu do seu repositório, clique em Settings.
No menu lateral esquerdo, clique em Secrets and variables > Actions.
Adicionar um novo Secret:
Clique no botão New repository secret.
No campo Name, insira VERCEL_TOKEN (o nome do segredo deve ser exatamente este).
No campo Value, cole o token da Vercel que você gerou.
Clique em Add secret para salvar.
Passo 3: Criar o Arquivo de Workflow no GitHub Actions

Agora, vamos criar um arquivo de configuração do GitHub Actions para automatizar o deploy do seu frontend para a Vercel.

Crie o diretório .github/workflows no seu repositório (se ainda não existir).
Crie o arquivo deploy-frontend.yml dentro do diretório .github/workflows com o seguinte conteúdo:
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
Explicação do Workflow:
on: push: O workflow é disparado sempre que houver um push na branch main (ou outra branch configurada).
actions/checkout@v3: A ação checkout faz o download do código do repositório.
actions/setup-node@v3: Ação para configurar o Node.js (você pode modificar a versão se necessário).
npm ci: Instala as dependências de maneira rápida e limpa.
npm run build: Executa o build do seu projeto React.
npx vercel --prod --yes: Realiza o deploy do projeto para a Vercel sem solicitar confirmação interativa.
Passo 4: Testar o Workflow no GitHub Actions

Agora, você pode testar o workflow:

Faça um commit e push para a branch main (ou a branch que você configurou).
git add .github/workflows/deploy-frontend.yml
git commit -m "Adiciona workflow de deploy para Vercel"
git push origin main
Verifique a execução do workflow:
Vá até a aba Actions do seu repositório no GitHub.
Clique no workflow para ver os logs e o status da execução.
Se tudo estiver correto, o GitHub Actions executará os passos e fará o deploy do seu frontend para a Vercel automaticamente.

Passo 5: Verificar o Deploy na Vercel

Após a execução bem-sucedida do GitHub Actions:

Acesse o painel da Vercel.
Verifique o status do deploy na sua aplicação. Se o deploy foi bem-sucedido, sua aplicação React estará disponível no endereço configurado pela Vercel.
Problemas Comuns e Soluções

Token da Vercel inválido:
Verifique se o token no GitHub Secrets foi configurado corretamente.
Regenerate o token na Vercel e atualize o VERCEL_TOKEN no GitHub Secrets.
Erro de build:
Verifique os logs do GitHub Actions para garantir que o comando npm run build foi executado corretamente.
Certifique-se de que as dependências do seu projeto estão corretas no package.json.
Erro de permissões:
Se o erro for relacionado a permissões ao tentar acessar o projeto na Vercel, verifique se o token da Vercel possui as permissões necessárias.
Conclusão

Agora você configurou com sucesso um workflow de deploy contínuo para o seu frontend React usando GitHub Actions e a Vercel. A cada vez que você fizer um push para a branch configurada, o GitHub Actions irá automaticamente construir e fazer o deploy do seu projeto para a Vercel.

Se ainda houver problemas ou dúvidas, sinta-se à vontade para pedir ajuda! 😊

