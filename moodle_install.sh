#!/bin/bash

# Mettre à jour le système
sudo apt update
sudo apt upgrade -y

# Installer les dépendances nécessaires
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql php-xml php-xmlrpc php-soap php-intl php-zip php-curl php-gd php-mbstring unzip git

# Activer Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Configurer MySQL
sudo mysql -e "CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL ON moodle.* TO 'moodleuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Télécharger Moodle depuis Git
sudo mkdir -p /var/www/html/moodle
sudo git clone https://github.com/moodle/moodle.git /var/www/html/moodle

# Installer Moodle (automatiquement)
sudo chmod -R 755 /var/www/html/moodle
sudo chown -R www-data:www-data /var/www/html/moodle

# Configurer Apache pour Moodle
sudo tee /etc/apache2/sites-available/moodle.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/moodle
    DirectoryIndex index.php
    <Directory /var/www/html/moodle>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Activer le site Moodle
sudo a2ensite moodle.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

# Ajuster les permissions pour moodledata
sudo mkdir /var/moodledata
sudo chown -R www-data /var/moodledata
sudo chmod -R 770 /var/moodledata

# Finaliser l'installation via le navigateur web
echo "Installation terminée. Veuillez terminer la configuration via votre navigateur web."
echo "Accédez à http://localhost pour continuer l'installation de Moodle."
