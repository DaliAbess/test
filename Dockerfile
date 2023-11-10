# Utiliser une image officielle PHP 8.1
FROM php:8.1-fpm

# Installation des dépendances nécessaires
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libicu-dev \
        libzip-dev \
        libonig-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installer les extensions PHP nécessaires
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        intl \
        pdo_mysql \
        opcache \
        gd \
        zip \
        bcmath \
        exif \
        xml

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#install of symfony 5 
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN  mv /*/.symfony5/bin/symfony /usr/local/bin/symfony
RUN symfony -v 
# Création du répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers de l'application dans le conteneur
COPY . .
# Installer les dépendances avec Composer
RUN composer install 

# Configurer les permissions pour Symfony
RUN chown -R www-data:www-data var

# Exposer le port 9000 pour PHP-FPM
EXPOSE 8000

# Commande par défaut pour l'exécution du serveur PHP-FPM
CMD ["php-fpm"]
CMD ["symfony","server:start"]
