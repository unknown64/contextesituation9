#====================================================================================
#NAME: exerciceDHCP2.ps1
#AUTHOR: MANGIN Pierre
#DATE: 24/03/2023
#
#VERSION 1.0
#COMMENTS: Script permettant la cr�ation d'etendues DHCP + ladresse IP et le nom du domaine
#Requires -Version 2.0
#====================================================================================

# Demande des informations n�cessaires � l'utilisateur
$nomEtendue = Read-Host "Entrez le nom de l'�tendue DHCP"
$adresseReseau = Read-Host "Entrez l'adresse r�seau de l'�tendue"
$masqueSousReseau = Read-Host "Entrez le masque de sous-r�seau de l'�tendue"
$premiereAdresse = Read-Host "Entrez la premi�re adresse � attribuer"
$derniereAdresse = Read-Host "Entrez la derni�re adresse � attribuer"
$adressePasserelle = Read-Host "Entrez l'adresse de passerelle � diffuser"
$nomDuDomaine = Read-Host "Entrez le nom du domaine"
$adresseDomaine = Read-Host "Entrez l'adresse IP du serveur de domaine"

# Affichage des informations saisies par l'utilisateur
Write-Host " "
Write-Host "R�capitulatif des informations saisies :"
Write-Host "Nom de l'�tendue DHCP : $nomEtendue"
Write-Host "Adresse r�seau : $adresseReseau"
Write-Host "Masque de sous-r�seau : $masqueSousReseau"
Write-Host "Premi�re adresse � attribuer : $premiereAdresse"
Write-Host "Derni�re adresse � attribuer : $derniereAdresse"
Write-Host "Adresse de passerelle : $adressePasserelle"
Write-Host "Nom du domaine : $nomDuDomaine"
Write-Host "Adresse IP du serveur de domaine : $adresseDomaine"

# Demande de validation
$confirmation = Read-Host "Les informations sont-elles correctes ? (O/N)"
if ($confirmation.ToLower() -eq "o") {
  # Cr�er l'�tendue DHCP avec les informations saisies
  Add-DhcpServerv4Scope -Name $nomEtendue -StartRange $premiereAdresse -EndRange $derniereAdresse -SubnetMask $masqueSousReseau
  Set-DhcpServerv4OptionValue -ScopeID $adresseReseau -Router $adressePasserelle
  Set-DhcpServerv4OptionValue -OptionId 6 -Value $adresseDomaine -ScopeId $adresseReseau
  Set-DhcpServerv4OptionValue -OptionId 15 -Value $nomDomaine -ScopeId $adresseReseau
  Write-Host "L'�tendue DHCP a �t� cr��e avec succ�s."
}
else {
  Write-Host "L'op�ration a �t� annul�e."
}
