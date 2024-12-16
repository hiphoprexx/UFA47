# Script PowerShell télécharger une donnees depuis un serveur FTP 

# Verification
function Validate-FTPFile {
    param (
        [string]$ftpServer,
        [string]$ftpFilePath,
        [string]$username,
        [string]$password
    )
    $uri = "$ftpServer/$ftpFilePath"
    try {
        $request = [System.Net.WebRequest]::Create($uri)
        $request.Method = "HEAD"
        if ($username -and $password) {
            $request.Credentials = New-Object System.Net.NetworkCredential($username, $password)
        }
        $response = $request.GetResponse()
        $response.Close()
        return $true
    } catch {
        return $false
    }
}

# Demander d'infos
$ftpServer = Read-Host "Entrez l'adresse IP du serveur FTP (par exemple, ftp://192.168.1.100)"
$ftpUsername = Read-Host "Entrez le nom d'utilisateur pour le FTP"
$ftpPassword = Read-Host "Entrez le mot de passe pour le FTP" -AsSecureString
$ftpPasswordUnsecure = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ftpPassword))

# Chemin
do {
    $ftpFilePath = Read-Host "Entrez le chemin complet du fichier sur le serveur FTP (par exemple, /srv/ftp/monarchive.tar.gz)"
    if (-Not (Validate-FTPFile -ftpServer $ftpServer -ftpFilePath $ftpFilePath -username $ftpUsername -password $ftpPasswordUnsecure)) {
        Write-Host "Le fichier spécifié n'existe pas sur le serveur FTP. Veuillez réessayer." -ForegroundColor Red
    }
} while (-Not (Validate-FTPFile -ftpServer $ftpServer -ftpFilePath $ftpFilePath -username $ftpUsername -password $ftpPasswordUnsecure))

# Dossier local pour enregistrer le fichier
$localDirectory = "C:\archive"
if (-Not (Test-Path -Path $localDirectory)) {
    try {
        New-Item -ItemType Directory -Path $localDirectory | Out-Null
        Write-Output "Dossier local créé : $localDirectory"
    } catch {
        Write-Error "Impossible de créer le dossier local : $_"
        exit 1
    }
}

# Configuration SMTP pour mail
$adminEmail = "jesuisuneaddreswemail"
$smtpServer = "smtp.gmail.com"
$smtpPort = 587
$emailFrom = "votreadresse@gmail.com"
$emailPassword = "votre_mot_de_passe_application" #attention a activer la double auth sur votre compte google pour creer un mot de passe d'applis

# Génération du nom de fichier avec date et heure
$date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$localFileName = "monarchive_$date.tar.gz"
$localFilePath = Join-Path -Path $localDirectory -ChildPath $localFileName

# Fonction pour envoyer un e-mail
function Send-Email {
    param (
        [string]$subject,
        [string]$body
    )
    $message = New-Object System.Net.Mail.MailMessage
    $message.From = $emailFrom
    $message.To.Add($adminEmail)
    $message.Subject = $subject
    $message.Body = $body
    $smtp = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
    $smtp.EnableSsl = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($emailFrom, $emailPassword)
    try {
        $smtp.Send($message)
        Write-Output "E-mail envoyé avec succès."
    } catch {
        Write-Error "Erreur lors de l'envoi de l'e-mail : $_"
    }
}

# Téléchargement du fichier depuis le FTP
try {
    $uri = "$ftpServer/$ftpFilePath"
    Write-Output "Téléchargement en cours de : $uri"
    $webClient = New-Object System.Net.WebClient
    $webClient.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPasswordUnsecure)
    $webClient.DownloadFile($uri, $localFilePath)

    # Succès
    $subject = "Récupération réussie"
    $body = "Le fichier a été téléchargé avec succès depuis $uri vers $localFilePath."
    Send-Email -subject $subject -body $body
    Write-Output "Téléchargement réussi."

} catch {
    # Gestion des erreurs
    $errorMessage = $_.Exception.Message
    $errorDetail = "Erreur : $errorMessage"

    $subject = "Récupération échouée"
    $body = "Le téléchargement du fichier depuis $uri a échoué. $errorDetail"
    Send-Email -subject $subject -body $body
    Write-Error "Erreur lors du téléchargement : $errorDetail"
}
