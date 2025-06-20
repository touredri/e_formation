# e_formation

Plateforme E-Formation+ (Flutter + Spring Boot)

## Prérequis

- Flutter SDK installé ([docs Flutter](https://docs.flutter.dev/get-started/install))
- Un backend Spring Boot opérationnel (voir documentation backend)
- Android Studio ou VS Code recommandé

## Installation

1. **Cloner le projet**

```bash
git clone <url-du-repo>
cd e_formation
```

2. **Installer les dépendances Flutter**

```bash
flutter pub get
```

3. **Lancer l'application Flutter**

```bash
flutter run
```

> ⚠️ Le backend Spring Boot doit être démarré sur `http://localhost:8080` (modifiable dans `lib/app/data/services/api.dart`)

## Fonctionnalités principales

- Inscription et connexion utilisateur
- Liste des formations, inscription/continuer
- Détail formation, progression, quiz final
- Certificats obtenus, liste des inscrits par formation
- Interface responsive, navigation fluide

## Structure des pages

- SplashScreen
- Authentification (inscription/connexion)
- Accueil (liste des formations)
- Détail formation
- Quiz
- Profil utilisateur
- Certificats (avec onglet inscrits)

## Stockage local

- Utilisation de GetStorage pour l'état de connexion et l'utilisateur courant

## Personnalisation

- Modifier l’URL du backend dans `lib/app/data/services/api.dart` si besoin
- Adapter les endpoints selon votre backend Spring Boot

---

Pour toute question, ouvrez une issue ou contactez le développeur.
