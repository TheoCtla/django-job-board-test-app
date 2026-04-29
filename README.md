# Création et démarrage de l'environnement virtuel
```python3 -m venv .env```
## Sous linux
```source .env/bin/activate```
## Sous Windows
```.\venv\Scripts\activate```

# Installer les dépendances backend
```pip install -r requirements.txt```

# Installer les dépendances frontend
```npm install```

# Build front
```npm run build:css```

# Jouer les migrations de BDD
```python manage.py migrate```

# Démarrer le server
```python manage.py runserver```
