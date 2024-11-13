# Jeunes Parents

Une application mobile dédiée aux jeunes parents pour les aider à mieux organiser leurs journées et accéder à des recommandations personnalisées. L'application permet la gestion des tâches quotidiennes, le suivi de l'humeur, et propose des articles sur des thématiques liées à la parentalité.

## Fonctionnalités

### 1. Gestion de tâches quotidiennes
- **Ajout, édition et suppression de tâches** : Les utilisateurs peuvent facilement créer des tâches, les modifier ou les supprimer selon leurs besoins.
- **Suivi de l'avancement** : Chaque tâche peut être marquée comme complétée, permettant aux utilisateurs de suivre leur progression au quotidien.

### 2. Suivi de l'humeur
- **Sélection d'humeur** : Les utilisateurs peuvent sélectionner un emoji représentant leur humeur du jour.
- **Affichage de l’humeur** : L'humeur sélectionnée est affichée pour donner un aperçu quotidien du bien-être des utilisateurs.

### 3. Recommandations d'articles
- **Articles personnalisés** : L'application propose des articles sur des sujets pertinents pour les jeunes parents.
- **Détails des articles** : Les utilisateurs peuvent lire des résumés et accéder aux détails des articles qui les intéressent.

### 4. Authentification sécurisée
- **Connexion et déconnexion** : L'authentification est sécurisée par un token stocké dans le Keychain.
- **Persistance de la session** : Les utilisateurs restent connectés même après la fermeture de l'application.

## Structure de l'Application

L'application est construite en utilisant SwiftUI avec une architecture MVVM (Model-View-ViewModel) pour une gestion claire de la logique et de l'interface utilisateur.

- **`HomeView`** : Vue principale avec la gestion des tâches, suivi de l'humeur, et recommandations d'articles.
- **`HomeViewModel`** : Gère les données pour `HomeView`, récupère le prénom de l'utilisateur, gère l'humeur, et communique avec le backend pour récupérer les informations utilisateur.
- **`TaskViewModel`** : Gère la liste des tâches (ajout, modification, suppression).
- **`ArticleViewModel`** : Récupère et stocke les articles de recommandation pour l'affichage dans `HomeView`.
- **`AuthentificationViewModel`** : Gère l'authentification et le token d'utilisateur via Keychain.

## Prérequis

- **Xcode 14+**
- **iOS 16+**
- Connexion internet pour récupérer les informations de profil et les recommandations d'articles.

## Installation

1. Clonez le dépôt :
   ```bash
   git clone https://github.com/votre-utilisateur/jeunesParents.git
   cd jeunesParents
