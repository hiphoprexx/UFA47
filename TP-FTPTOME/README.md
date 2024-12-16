# **Script PowerShell : Téléchargement de fichier depuis un serveur FTP avec notification par e-mail**

## **Description**

Ce script PowerShell permet de :
1. Télécharger un fichier depuis un serveur FTP après validation de son existence.
2. Stocker le fichier téléchargé dans un dossier local avec un nom unique basé sur la date et l'heure.
3. Envoyer une notification par e-mail pour informer du succès ou de l’échec du téléchargement.

## **Fonctionnalités principales**

- Vérification de l’existence du fichier sur le serveur FTP.
- Téléchargement sécurisé avec authentification (nom d'utilisateur et mot de passe).
- Création automatique du dossier local pour enregistrer le fichier, si celui-ci n'existe pas.
- Envoi d'un rapport par e-mail (succès ou échec).

## **Prérequis**

1. **Environnement** : 
   - Windows avec PowerShell.
   - Accès à un serveur FTP.
2. **Configuration SMTP** : 
   - Une adresse e-mail et un mot de passe pour l'envoi des notifications par e-mail.
   - Un serveur SMTP configuré (par exemple, Gmail).
   - Activer la double Auth sur Google
   - Dans sécurité puis rechercher 'Mot de passe applis'
   - Creer un mot de pass applis (PAS OUBLIER DENLEVER LES ESPACES)

## **Instructions d'utilisation**

1. **Lancer le script** :
   - Ouvrez PowerShell en tant qu’administrateur.
   - Exécutez le script en saisissant :  
     ```powershell
     .\script.ps1
     ```

2. **Saisir les informations demandées** :
   - L'adresse IP du serveur FTP (par exemple, `ftp://192.168.1.100`).
   - Les identifiants de connexion (nom d'utilisateur et mot de passe).
   - Le chemin du fichier à télécharger sur le serveur FTP (par exemple, `/srv/ftp/monarchive.tar.gz`).

3. **Téléchargement** :
   - Le script vérifiera l'existence du fichier.
   - Si le fichier existe, il sera téléchargé dans le dossier local `C:\archive`.

4. **Notification par e-mail** :
   - Une notification sera envoyée à l’adresse e-mail configurée :
     - **Succès** : si le fichier a été téléchargé avec succès.
     - **Échec** : en cas de problème (fichier introuvable, erreur de connexion, etc.).

## **Personnalisation**

- **Chemin local** : Modifiez la variable `$localDirectory` dans le script pour définir un autre dossier d’enregistrement.
- **Configuration SMTP** : 
  - Remplacez les valeurs des variables suivantes par vos informations :
    ```powershell
    $adminEmail = "votre_adresse_admin@gmail.com"
    $smtpServer = "smtp.votre_fournisseur.com"
    $smtpPort = 587
    $emailFrom = "votre_adresse_email@gmail.com"
    $emailPassword = "votre_mot_de_passe_application"
    ```

## **Exemple d'utilisation**

- **Scénario** : Vous souhaitez télécharger le fichier `monarchive.tar.gz` situé sur un serveur FTP accessible via `ftp://192.168.1.100`, avec les identifiants `utilisateur1` / `motdepasse1`. Le script :
  1. Vérifie l’existence du fichier sur le serveur FTP.
  2. Télécharge le fichier dans `C:\archive` avec un nom unique, tel que `monarchive_2024-12-16_14-30-00.tar.gz`.
  3. Vous envoie un e-mail pour confirmer que l’opération a réussi.

## **Dépannage**

- **Erreur : "Impossible de se connecter au serveur FTP"** :
  - Vérifiez l’adresse IP et les identifiants du serveur FTP.
  - Assurez-vous que le serveur est accessible depuis votre réseau.

- **Erreur : "Échec de l'envoi de l'e-mail"** :
  - Vérifiez vos paramètres SMTP (serveur, port, identifiants).
  - Assurez-vous que votre pare-feu ou votre fournisseur d'e-mail n'empêche pas l'envoi.

## **Sécurité**

- Évitez d'enregistrer vos identifiants FTP ou votre mot de passe SMTP en clair dans le script. Utilisez des variables sécurisées si possible.
- Protégez le script pour éviter qu’il ne soit modifié par des utilisateurs non autorisés.

## **Contact**

Pour toute question ou problème, veuillez contacter [votre.ryandetree@icloud.com](mailto:votre.ryandetree@icloud.com).
