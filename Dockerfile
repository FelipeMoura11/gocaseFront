# Use uma imagem base do Node.js
FROM node:20-alpine AS builder 

# Crie o diretório de trabalho
WORKDIR /

# Copie os arquivos de dependência
COPY package*.json .

# Instale as dependências
RUN npm i 

COPY src src  


COPY api.jsx .  
COPY index.html .
COPY vite.config.js .

RUN npm run build     

FROM nginx:1.21.0-alpine

COPY --from=builder dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

