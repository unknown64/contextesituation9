#====================================================================================
#NAME: exerciceDHCP.ps1
#AUTHOR: MANGIN Pierre
#DATE: 24/03/2023
#
#VERSION 1.0
#COMMENTS: Script permettant la création d'etendues DHCP
#Requires -Version 2.0
#====================================================================================

# Demande des informations nécessaires à l'utilisateur
$nomEtendue = Read-Host "Entrez le nom de l'étendue DHCP"
$adresseReseau = Read-Host "Entrez l'adresse réseau de l'étendue"
$masqueSousReseau = Read-Host "Entrez le masque de sous-réseau de l'étendue"
$premiereAdresse = Read-Host "Entrez la première adresse à attribuer"
$derniereAdresse = Read-Host "Entrez la dernière adresse à attribuer"
$adressePasserelle = Read-Host "Entrez l'adresse de passerelle à diffuser"

# Affichage des informations saisies par l'utilisateur
Write-Host " "
Write-Host "Récapitulatif des informations saisies :"
Write-Host "Nom de l'étendue DHCP : $nomEtendue"
Write-Host "Adresse réseau : $adresseReseau"
Write-Host "Masque de sous-réseau : $masqueSousReseau"
Write-Host "Première adresse à attribuer : $premiereAdresse"
Write-Host "Dernière adresse à attribuer : $derniereAdresse"
Write-Host "Adresse de passerelle : $adressePasserelle"

# Demande de validation
$confirmation = Read-Host "Les informations sont-elles correctes ? (O/N)"
if ($confirmation.ToLower() -eq "o") {
  # Créer l'étendue DHCP avec les informations saisies
  Add-DhcpServerv4Scope -Name $nomEtendue -StartRange $premiereAdresse -EndRange $derniereAdresse -SubnetMask $masqueSousReseau -ScopeId $adresseReseau -Router $adressePasserelle
  Write-Host "L'étendue DHCP a été créée avec succès."
}
else {
  Write-Host "L'opération a été annulée."
}
