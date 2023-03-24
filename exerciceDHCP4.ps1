#====================================================================================
#NAME: exerciceDHCP3.ps1
#AUTHOR: MANGIN Pierre
#DATE: 24/03/2023
#
#VERSION 1.0
#COMMENTS: Script permettant la cr�ation d'etendues DHCP + ladresse IP et le nom du domaine tout ceci en boite de dialogues
#Requires -Version 2.0
#====================================================================================

[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')


$exe = [Microsoft.VisualBasic.Interaction]::InputBox("Combien de plages voulez-vous cr�er? ")

# Cr�ation d'une variable qui permettra de r�guler le nombre d'�x�cution du script
$n = 0
while($n -ne $exe)
{
$n = $n + 1
}

# Demander le nom de l'�tendue DHCP
$nomEtendue = [Microsoft.VisualBasic.Interaction]::InputBox("Nom de l'�tendue DHCP","Entrez le nom de l'�tendue DHCP","")

# Demander l'adresse r�seau de l'�tendue DHCP
$adresseReseau = [Microsoft.VisualBasic.Interaction]::InputBox("Adresse r�seau de l'�tendue DHCP","Entrez l'adresse r�seau de l'�tendue DHCP","")

# Demander le masque de sous-r�seau de l'�tendue DHCP
$masqueSousReseau = [Microsoft.VisualBasic.Interaction]::InputBox("Masque de sous-r�seau de l'�tendue DHCP","Entrez le masque de sous-r�seau de l'�tendue DHCP","")

# Demander la premi�re adresse � attribuer
$premiereAdresse = [Microsoft.VisualBasic.Interaction]::InputBox("Premi�re adresse � attribuer","Entrez la premi�re adresse � attribuer","")

# Demander la derni�re adresse � attribuer
$derniereAdresse = [Microsoft.VisualBasic.Interaction]::InputBox("Derni�re adresse � attribuer","Entrez la derni�re adresse � attribuer","")

# Demander l'adresse de passerelle � diffuser
$adressePasserelle = [Microsoft.VisualBasic.Interaction]::InputBox("Adresse de passerelle � diffuser","Entrez l'adresse de passerelle � diffuser","")

# Demander le nom de domaine
$nomDomaine = [Microsoft.VisualBasic.Interaction]::InputBox("Nom du domaine","Entrez le nom du domaine","")

# Demander l'adresse du domaine
$adresseDomaine = [Microsoft.VisualBasic.Interaction]::InputBox("Adresse du domaine","Entrez l'adresse du domaine","")

# Afficher un message de confirmation avec les informations saisies
$messageConfirmation = "�tes-vous s�r de vouloir cr�er l'�tendue DHCP suivante ?`n`n" +
                      "Nom de l'�tendue DHCP : $nomEtendue`n" +
                      "Adresse r�seau : $adresseReseau`n" +
                      "Masque de sous-r�seau : $masqueSousReseau`n" +
                      "Premi�re adresse � attribuer : $premiereAdresse`n" +
                      "Derni�re adresse � attribuer : $derniereAdresse`n" +
                      "Adresse de passerelle � diffuser : $adressePasserelle`n" +
                      "Nom du domaine : $nomDomaine`n" +
                      "Adresse du domaine : $adresseDomaine"

$confirmation = [System.Windows.Forms.MessageBox]::Show($messageConfirmation, "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo)

if ($confirmation -eq "Yes") {
    # Cr�er l'�tendue DHCP avec les informations saisies
    Add-DhcpServerv4Scope -Name $nomEtendue -StartRange $premiereAdresse -EndRange $derniereAdresse -SubnetMask $masqueSousReseau
    Set-DhcpServerv4OptionValue -ScopeID $adresseReseau -Router $adressePasserelle
    Set-DhcpServerv4OptionValue -OptionId 6 -Value $adresseDomaine -ScopeId $adresseReseau
    Set-DhcpServerv4OptionValue -OptionId 15 -Value $nomDomaine -ScopeId $adresseReseau
    Write-Host "L'�tendue DHCP a �t� cr��e avec succ�s."
    }