# Utilisez une image Node.js pour construire votre application Angular
FROM node:latest as builder

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les fichiers de votre application Angular dans le conteneur
COPY . .

# Installez les dépendances et construisez l'application Angular
RUN npm install
RUN npm run build --prod

# Utilisez une image légère basée sur Nginx pour servir votre application Angular construite
FROM nginx:alpine

# Copiez les fichiers construits de l'application Angular dans le répertoire de base de Nginx
COPY --from=builder /app/dist/* /usr/share/nginx/html/

# Nginx expose le port 80 par défaut, pas besoin de l'indiquer ici
