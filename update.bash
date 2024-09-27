#!/bin/bash

# Variables
BINARY_NAME="disk-manager"  
BINARY_PATH="/usr/local/bin"  
PROJECT_DIR="/home/debian/go/disk-manager"  
BUILD_DIR="$PROJECT_DIR"  

cd $PROJECT_DIR || { echo "Erreur: Répertoire introuvable"; exit 1; }

echo "Pulling the latest code from Git..."
git pull origin main || { echo "Erreur: Impossible de pull depuis git"; exit 1; }

echo "Building the new binary..."
go build -o $BUILD_DIR/$BINARY_NAME || { echo "Erreur: Compilation échouée"; exit 1; }

if [ -f "$BINARY_PATH/$BINARY_NAME" ]; then
    echo "Replacing the old binary with the new one..."
    sudo mv $BUILD_DIR/$BINARY_NAME $BINARY_PATH/$BINARY_NAME || { echo "Erreur: Impossible de remplacer le binaire"; exit 1; }
else
    echo "Installing the new binary..."
    sudo mv $BUILD_DIR/$BINARY_NAME $BINARY_PATH/$BINARY_NAME || { echo "Erreur: Impossible d'installer le nouveau binaire"; exit 1; }
fi

sudo chmod +x $BINARY_PATH/$BINARY_NAME

echo "Le binaire $BINARY_NAME a été mis à jour avec succès."
