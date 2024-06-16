# Connectez-vous à votre instance EC2


# Mettez à jour le système et installez git et wget
sudo apt update
sudo apt install git wget unzip -y

# Clonez votre dépôt GitHub
git clone https://github.com/Claudioleroi/moodle.git




# Décompressez le fichier moodle.zip
unzip moodle405.zip -d /chemin/vers/votre/dossier/moodle

# Déplacez les fichiers de Moodle au bon endroit
sudo mv /chemin/vers/votre/dossier/moodle /chemin/vers/votre/installation/moodle
