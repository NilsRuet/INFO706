# INFO706
Dans le cadre des séances de TP d’INFO706 nous avons développé une application mobile visant à faciliter l’apprentissage via l’approche par compétences (APC).
L’objectif de ce projet était de créer une application mobile connectée à un serveur qui devrait permettre à un étudiant de renseigner et d’auto-valider ses propres compétences, ainsi qu’à un enseignant de valider les compétences d’un étudiant s’il jugeait que ce dernier les avait acquises.  
Nous avons choisi de focaliser l'application sur l'apprentissage des langues, puisqu'il existe un standard pour les évaluer en europe (CECRL).  
Ce dépôt contient toutes les sources nécessaires pour déployer le serveur et l'application.

## Lancer le serveur / Code source du serveur ##
Le serveur est un intermédiaire entre l'application et les données manipulées. Les données manipulées doivent être stockées dans une base de données MYSQL, dont un exemple est fourni (Serveur/BDD_exemples/info708.sql)  
Cette base de données doit porter le nom "info708", et nécessite un utilisateur appelé "info708" (avec le même mdp) qui peut y accéder.
Il est sinon possible de modifier le fichier "Serveur/src/init/launch.py" pour utiliser d'autres identifiants.  
Le serveur est réalisé en python (python 2 précisément), et nécessite plusieurs librairies afin de pouvoir être lancé.
Ces librairies peuvent être installé à l'aide de pip, les commandes à exécuter sont alors :  

$ pip install bottle  
$ pip install bottle-mysql  
$ pip install mysql-python  
$ pip install requests  

Une fois toutes les dépendances installées, il est alors possible de lancer le serveur en exécutant le fichier "Serveur/src/main.py", avec par exemple la commande :  
$ python main.py  
lancée dans le répertoire "Serveur/src"

Il est possible de renseigner l'adresse et le port du serveur, en modifiant le fichier "Serveur/src/host.config".  
La première ligne de ce fichier est l'adresse IP du serveur, la deuxième ligne est le port sur lequel le serveur écoutera les requêtes HTTP liées à l'application.  

Le code source du serveur est situé dans le dossier "Serveur/src", et est constitué de tous les fichiers avec une extension ".py".

## Lancer l'application / Code source de l'application ##

Pour lancer l'application, il est possible d'installer son APK, situé dans le dossier "Executable".
Une fois l'APK installé, il est possible de configurer l'adresse et le port du serveur auquel l'application doit se connecter en cliquant sur la roue dentée située
en bas à droite de l'écran de connexion.

Le code source de l'application se trouve dans "FlutterApplication", qui est la racine du projet Flutter permettant de générer l'exécutable.
Ce projet peut être ouvert à l'aide d'Android Studio, à condition que l'extension flutter pour cette IDE soit installée.

## Version hors-ligne de l'application ##

Pour tester l'application sans avoir accès au serveur ou à une connexion Internet, il est possible d'installer 
l'APK "info706-offline": celui-ci permet d'avoir une version de "démonstration" qui fonctionne hors connexion. Il est alors possible de se connecter en tant qu'étudiant 
ou enseignant, selon si la checkbox de la page de connexion est cochée, et ensuite d'accéder à toutes les actions en lecture.
Les actions en écriture engendrent un message indiquant un problème de connexion. On remarquera également que tous les étudiants
auxquels peut accéder l'enseignant ont les mêmes valeurs pour cette version de démonstration.