#====================================================================================
#NAME: exerciceDHCP3.ps1
#AUTHOR: MANGIN Pierre
#DATE: 24/03/2023
#
#VERSION 1.0
#COMMENTS: Script permettant la création d'etendues DHCP + ladresse IP et le nom du domaine tout ceci en boite de dialogues
#Requires -Version 2.0
#====================================================================================

[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')


$exe = [Microsoft.VisualBasic.Interaction]::InputBox("Combien de plages voulez-vous créer? ")

# Création d'une variable qui permettra de réguler le nombre d'éxécution du script
$n = 0
while($n -ne $exe)
{
$n = $n + 1
}

# Demander le nom de l'étendue DHCP
$nomEtendue = [Microsoft.VisualBasic.Interaction]::InputBox("Nom de l'étendue DHCP","Entrez le nom de l'étendue DHCP","")

# Demander l'adresse réseau de l'étendue DHCP
$adresseReseau = [Microsoft.VisualBasic.Interaction]::InputBox("Adresse réseau de l'étendue DHCP","Entrez l'adresse réseau de l'étendue DHCP","")

# Demander le masque de sous-réseau de l'étendue DHCP
$masqueSousReseau = [Microsoft.VisualBasic.Interaction]::InputBox("Masque de sous-réseau de l'étendue DHCP","Entrez le masque de sous-réseau de l'étendue DHCP","")

# Demander la première adresse à attribuer
$premiereAdresse = [Microsoft.VisualBasic.Interaction]::InputBox("Première adresse à attribuer","Entrez la première adresse à attribuer","")

# Demander la dernière adresse à attribuer
$derniereAdresse = [Microsoft.VisualBasic.Interaction]::InputBox("Dernière adresse à attribuer","Entrez la dernière adresse à attribuer","")

# Demander l'adresse de passerelle à diffuser
$adressePasserelle = [Microsoft.VisualBasic.Interaction]::InputBox("Adresse de passerelle à diffuser","Entrez l'adresse de passerelle à diffuser","")

# Demander le nom de domaine
$nomDomaine = [Microsoft.VisualBasic.Interaction]::InputBox("Nom du domaine","Entrez le nom du domaine","")

# Demander l'adresse du domaine
$adresseDomaine = [Microsoft.VisualBasic.Interaction]::InputBox("Adresse du domaine","Entrez l'adresse du domaine","")

# Afficher un message de confirmation avec les informations saisies
$messageConfirmation = "Êtes-vous sûr de vouloir créer l'étendue DHCP suivante ?`n`n" +
                      "Nom de l'étendue DHCP : $nomEtendue`n" +
                      "Adresse réseau : $adresseReseau`n" +
                      "Masque de sous-réseau : $masqueSousReseau`n" +
                      "Première adresse à attribuer : $premiereAdresse`n" +
                      "Dernière adresse à attribuer : $derniereAdresse`n" +
                      "Adresse de passerelle à diffuser : $adressePasserelle`n" +
                      "Nom du domaine : $nomDomaine`n" +
                      "Adresse du domaine : $adresseDomaine"

$confirmation = [System.Windows.Forms.MessageBox]::Show($messageConfirmation, "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo)

if ($confirmation -eq "Yes") {
    # Créer l'étendue DHCP avec les informations saisies
    Add-DhcpServerv4Scope -Name $nomEtendue -StartRange $premiereAdresse -EndRange $derniereAdresse -SubnetMask $masqueSousReseau
    Set-DhcpServerv4OptionValue -ScopeID $adresseReseau -Router $adressePasserelle
    Set-DhcpServerv4OptionValue -OptionId 6 -Value $adresseDomaine -ScopeId $adresseReseau
    Set-DhcpServerv4OptionValue -OptionId 15 -Value $nomDomaine -ScopeId $adresseReseau
    Write-Host "L'étendue DHCP a été créée avec succès."
    }