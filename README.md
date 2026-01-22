#  README – DigitalBank 

## Description
DigitalBank est une application bancaire digitale permettant de gérer des comptes utilisateurs, 
d’effectuer des transactions et de visualiser l’historique des opérations. 
Le projet combine la création d’une base de données Supabase (PostgreSQL), une API Python (FastAPI) pour la gestion des données,
et des dashboards Metabase pour la visualisation.

## Objectifs
- Créer une base de données sécurisée pour les clients, comptes et transactions.
- Développer une API CRUD pour lire/écrire dans la base via FastAPI.
- Visualiser les données via Metabase (KPIs, historiques, filtres, top clients).
- Assurer la sécurité et les bonnes pratiques (RLS, variables d’environnement, RBAC).
- Documenter le projet et produire un livrable prêt pour l’examen.

## Équipe
- Ratiba  
- Inès  
- Ikhlas

## Stack technique
- **Base de données** : Supabase (PostgreSQL)  
- **API** : Python (FastAPI)  
- **Visualisation** : Metabase  
- **Tests** : Postman / curl

## Architecture
[Front / Users] ---> [API Python (FastAPI)] ---> [Supabase (PostgreSQL)]
| |
+---------------------------------------> [Metabase] ---> Dashboards / KPIs


- L’API centralise les règles métier et sécurise les accès à la base.  
- Metabase se connecte à la base pour créer les dashboards sans exposer les clés sensibles.

## Contenu du projet
1. Création du projet Supabase et récupération des clés API.  
2. Schéma de la base de données (tables : customers, accounts, transactions).  
3. Développement de l’API FastAPI avec endpoints CRUD.  
4. Tests de l’API avec Postman / curl.  
5. Connexion Metabase et création de dashboards (KPI, historique, filtres).  
6. Sécurité et bonnes pratiques (RLS, .env, RBAC).  
7. Documentation et checklist de rendu pour examen.

## Livrables
- Base Supabase configurée et fonctionnelle.  
- API Python opérationnelle.  
- Dashboards Metabase avec KPIs et filtres.  
- Documentation complète et comptes rendus de réunions.  
- Tableau Gantt pour le suivi du projet.


 ## Outils et aides utilisés

- Supabase : base de données PostgreSQL. 
- Python (FastAPI) : API pour gestion des opérations CRUD.  
- Metabase : visualisation des dashboards et KPIs.  
- Postman / curl : tests des endpoints de l’API.
- ChatGPT : utilisé comme outil d’aide pour la correction de code, la recherche de bonnes pratiques et la documentation.  
 

# partie2-supabase
