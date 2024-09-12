
##### Kermarrec Gaëtan / Djenadi Arno / Groupe : :B:
## Script d'automatisation de la création de VM virtual box
Vous êtes employé dans la DSI d’une entreprise type PME. Cette société renouvelle son infra-structure IT, et le chef de service vous demande d’automatiser la création d’une maquette de la future infra, via un script de pilotage.

### Nous devions :
Pour cette SAE nous devions créer un script qui afin de mieux gerer la création des VMs, devait automatiser ce processus.
1. Créer des serveurs **TFTP** et **DHCP**
2. Créer une variable *Path* pour **VBoxManage**
3. Créer un script **Batch** ou **Shell**
4. **Gestion des erreurs** du script
5. Boot **PXE**
6. Boot automatique en Guest-Only
7. Installation automatique de l'**OS**
8. Avoir une **arborescence de versions**
9. Fichier d'explication *.md*

### Nous avons : 
1. Serveurs DHCP et TFTP
2. Variable *path* pour **VBoxManage**
3. Script **Batch** ou **Shell**
4. **Gestion des erreurs**
5. Boot **PXE**

### Mode d'emploi : 
#### GenVM_3.bat {[-D] [-L] [-S] [-D] [-A]} {Nom de la Machine}
* **-D** pour démarrer une machine
* **-A** pour arreter une machine
* **-S** pour supprimer une machine
* **-N** pour ajouter une nouvelle machine
* **-L** pour lister l’ensemble des machines enregistrées dans VB
