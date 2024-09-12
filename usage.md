
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

### Et si possible ajouter :
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

  -----------------------------------------------------------------------------------------------------------------------
### Explication du code : 
**1. Déclaration des variables et initialisation**

*set path="c:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set sys="C:\Windows\System32"
set MachineName=%2%
set DD="65536"
set RAM="4096"
set CPU="2"*

path : Chemin vers l'exécutable VBoxManage.exe, qui permet de contrôler VirtualBox en ligne de commande.
sys : Chemin vers System32.
MachineName : Deuxième argument passé au script, qui est le nom de la machine virtuelle à manipuler.
DD : Taille du disque dur virtuel (en Mo).
RAM : Taille de la mémoire vive allouée à la machine virtuelle (en Mo).
CPU : Nombre de cœurs de processeur alloués à la machine virtuelle.

**2. Vérification des paramètres**

*if "%1"=="" goto getError_code_1
if "%1"=="-L" goto getList
if "%2"=="" goto getError_code_2*

Le script vérifie que le premier argument est présent. Sinon, ça va renvoyer un message d'erreur avec getError_code_1.
Si l'option -L est fournie, il va vers l'action de listing.
Si le deuxième argument est manquant et que l'action requiert un nom, ça va renvoyer une erreur avec getError_code_2.

**3. Gestion des différentes options**

Voir la partie mode d'emploi plus haut dans ce readme

**4. Gestion des erreurs**

*:getError_code_1
:getError_code_2
:getError_code_0*

Ces sections affichent des messages d'erreur spécifiques si des arguments manquent ou si une commande est invalide.

**5. Création d'une machine virtuelle**

*:getChecked
:getCreate*

getChecked : Vérifie si une machine virtuelle portant le nom spécifié existe déjà. Si oui, elle est supprimée avant de créer une nouvelle machine. Si la machine n'existe pas, elle est directement créée.
getCreate : Crée une nouvelle machine virtuelle avec les caractéristiques spécifiées. Il configure ensuite la machine avec les options de démarrage, le contrôleur de stockage et copie un fichier .pxe pour l'initialisation réseau.

**6. Suppression d'une machine virtuelle**

*:getDelete*

Cette section supprime une machine virtuelle .

**7. Démarrage et arrêt des machines**
*:getStart
:getStop*

getStart : Démarre une machine virtuelle existante.
getStop : Arrête une machine virtuelle existante.

**8. Listing des machines virtuelles**

*:getList*
Cette section liste toutes les machines virtuelles disponibles. Si un deuxième argument est fourni, elle affiche les informations supplémentaires sur la machine spécifiée.
