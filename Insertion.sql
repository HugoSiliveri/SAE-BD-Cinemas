
    -- SCRIPT D'INSERTION DES DONNEES DANS LES TABLES

DROP TABLE Jours;
DROP TABLE Semaines;
DROP TABLE Mois;
DROP TABLE FrequentationJour;
DROP TABLE FrequentationSemaine;
DROP TABLE FrequentationMois;
DROP TABLE TypesCategories;
DROP TABLE CategoriesPublic;
DROP TABLE TauxCategorie;
DROP TABLE Communes;
DROP TABLE Agglomerations;
DROP TABLE Departements;
DROP TABLE Regions;
DROP TABLE DonneesCommune;
DROP TABLE DonneesAgglomeration;
DROP TABLE DonneesDepartement;
DROP TABLE Cinemas;
DROP TABLE Annees;


-- JOURS

CREATE TABLE Jours 
AS (SELECT DISTINCT jourSemaine as nomJour
    FROM FICTIF_JOURS);

-- SEMAINES 
CREATE TABLE Semaines
AS (SELECT DISTINCT semaine as numSemaine
    FROM FICTIF_SEMAINES);


-- MOIS
CREATE TABLE Mois
AS (SELECT DISTINCT mois as nomMois
    FROM FICTIF_MOIS);


-- FREQUENTATIONJOUR
CREATE TABLE FrequentationJour 
AS (SELECT jourSemaine as nomJour, annee, pourcentageEntrees, pourcentageRecettes, pourcentageSeances
    FROM FICTIF_JOURS);


-- FREQUENTATIONSEMAINE
CREATE TABLE FrequentationSemaine 
AS (SELECT semaine as numSemaine, annee, nbEntrees, recettes, nbSeances
    FROM FICTIF_SEMAINES);


-- FREQUENTATIONMOIS
CREATE TABLE FrequentationMois 
AS (SELECT mois as nomMois, annee, nbEntrees, recettes, nbSeances
    FROM FICTIF_MOIS);

-- TYPESCATEGORIES
CREATE TABLE TypesCategories
AS (SELECT DISTINCT typeCategorie 
    FROM FICTIF_PUBLIC);

-- CATEGORIESPUBLIC
CREATE TABLE CategoriesPublic
AS (SELECT DISTINCT categorie as nomCategorie, typeCategorie
    FROM FICTIF_PUBLIC);

-- TAUXCATEGORIE
CREATE TABLE TauxCategorie
AS (SELECT annee, categorie as nomCategorie, region as nomRegion, pourcentage as pourcentageEntrees
    FROM FICTIF_PUBLIC);

-- COMMUNE
CREATE TABLE Communes
AS (SELECT DISTINCT numCommune, nomCommune, zoneCommune, populationCommune, numUniteUrbaine as numAgglomeration
    FROM FICTIF_CINEMAS);

-- AGGLOMERATION

CREATE TABLE Agglomerations
AS (SELECT DISTINCT numUniteUrbaine as numAgglomeration, populationUniteUrbaine as populationAgglomeration, nomUniteUrbaine as nomAgglomeration, numDepartement
    FROM FICTIF_CINEMAS);

-- DEPARTEMENT
CREATE TABLE Departements
AS (SELECT DISTINCT fd.numDepartement, nomDepartement, nouvelleRegion as nomRegion, nbHabitantsDepartement as populationDepartement
    FROM FICTIF_CINEMAS fc
    JOIN FICTIF_DEPARTEMENTS fd ON fc.numDepartement = fd.numDepartement);


-- REGIONS 
CREATE TABLE Regions 
AS (SELECT ancienneRegion as nomRegion
    FROM FICTIF_CINEMAS
    UNION 
    SELECT nouvelleRegion as nomRegion
    FROM FICTIF_CINEMAS
    UNION 
    SELECT region as nomRegion
    FROM FICTIF_PUBLIC);


-- DONNEESCOMMUNES
CREATE TABLE DonneesCommune
AS (SELECT numCommune, annee, nbEtablissements, nbEcrans, nbFauteuils, nbMultiplexes, nbSeances, nbEntrees, recettes, tauxOccupation, nbCinemasArtEssai as nbCinemasAE, RME, indiceFrequentation
    FROM FICTIF_COMMUNES);

-- DONNEESAGGLOMERATION
CREATE TABLE DonneesAgglomeration 
AS (SELECT numUniteUrbaine as numAgglomeration, annee, nbEtablissements, nbEcrans, nbFauteuils, nbMultiplexes, nbSeances, nbEntrees, recettes, tauxOccupation, nbEtablissementsAE, nbEcransAE, nbFauteuilsAE, nbSeancesAE, nbEntreesAE, recettesAE, tauxOccupationAE
    FROM FICTIF_AGGLOMERATIONS);

-- DONNEESDEPARTEMENT
CREATE TABLE DonneesDepartement 
AS (SELECT numDepartement, annee, nbEtablissements, nbEcrans, nbFauteuils, nbMultiplexes, nbSeances, nbEntrees, recettes, tauxOccupation, nbEtablissementsAE, nbEcransAE, nbFauteuilsAE, nbSeancesAE, nbEntreesAE, recettesAE, tauxOccupationAE
    FROM FICTIF_DEPARTEMENTS);

-- CINEMAS
CREATE TABLE Cinemas
AS (SELECT numCinema, nomCinema, ancienneRegion, nouvelleRegion, numCommune, adresseCinema, situationGeographique, nbEcrans, nbFauteuils, nbSemainesActivite, nbSeances, nbEntrees2020, nbEntrees2019, evolutionEntrees, trancheEntrees, proprietaireCinema, programmateurCinema, AE, categorieAE, labelAE, genre, multiplexe, nbFilmsProgrammes, nbFilmsInedits, nbFilmsSemaine1, PdMentreesFilmsFR, PdMentreesFilmsUSA, PdMentreesFilmsEUR, PdMentreesFilmsAutres, nbFilmsAE, latitude, longitude, geolocalisation
    FROM FICTIF_CINEMAS);

-- ANNEE
CREATE TABLE Annees 
AS (SELECT DISTINCT annee
    FROM FICTIF_JOURS 
    UNION 
    SELECT DISTINCT annee
    FROM FICTIF_SEMAINES
    UNION
    SELECT DISTINCT annee 
    FROM FICTIF_MOIS 
    UNION 
    SELECT DISTINCT annee
    FROM FICTIF_COMMUNES
    UNION 
    SELECT DISTINCT annee
    FROM FICTIF_AGGLOMERATIONS
    UNION
    SELECT DISTINCT annee 
    FROM FICTIF_DEPARTEMENTS);

GRANT SELECT ON Jours TO MORANTS;
GRANT SELECT ON Jours TO JALBAUDL;
GRANT SELECT ON Jours TO RODRIGUESJ;
GRANT SELECT ON Semaines TO MORANTS;
GRANT SELECT ON Semaines TO JALBAUDL;
GRANT SELECT ON Semaines TO RODRIGUESJ;
GRANT SELECT ON Mois TO MORANTS;
GRANT SELECT ON Mois TO JALBAUDL;
GRANT SELECT ON Mois TO RODRIGUESJ;
GRANT SELECT ON FrequentationJour TO MORANTS;
GRANT SELECT ON FrequentationJour TO JALBAUDL;
GRANT SELECT ON FrequentationJour TO RODRIGUESJ;
GRANT SELECT ON FrequentationSemaine TO MORANTS;
GRANT SELECT ON FrequentationSemaine TO JALBAUDL;
GRANT SELECT ON FrequentationSemaine TO RODRIGUESJ;
GRANT SELECT ON FrequentationMois TO MORANTS;
GRANT SELECT ON FrequentationMois TO JALBAUDL;
GRANT SELECT ON FrequentationMois TO RODRIGUESJ;
GRANT SELECT ON TypesCategories TO MORANTS;
GRANT SELECT ON TypesCategories TO JALBAUDL;
GRANT SELECT ON TypesCategories TO RODRIGUESJ;
GRANT SELECT ON CategoriesPublic TO MORANTS;
GRANT SELECT ON CategoriesPublic TO JALBAUDL;
GRANT SELECT ON CategoriesPublic TO RODRIGUESJ;
GRANT SELECT ON TauxCategorie TO MORANTS;
GRANT SELECT ON TauxCategorie TO JALBAUDL;
GRANT SELECT ON TauxCategorie TO RODRIGUESJ;
GRANT SELECT ON Communes TO MORANTS;
GRANT SELECT ON Communes TO JALBAUDL;
GRANT SELECT ON Communes TO RODRIGUESJ;
GRANT SELECT ON Agglomerations TO MORANTS;
GRANT SELECT ON Agglomerations TO JALBAUDL;
GRANT SELECT ON Agglomerations TO RODRIGUESJ;
GRANT SELECT ON Departements TO MORANTS;
GRANT SELECT ON Departements TO JALBAUDL;
GRANT SELECT ON Departements TO RODRIGUESJ;
GRANT SELECT ON Regions TO MORANTS;
GRANT SELECT ON Regions TO JALBAUDL;
GRANT SELECT ON Regions TO RODRIGUESJ;
GRANT SELECT ON DonneesCommune TO MORANTS;
GRANT SELECT ON DonneesCommune TO JALBAUDL;
GRANT SELECT ON DonneesCommune TO RODRIGUESJ;
GRANT SELECT ON DonneesAgglomeration TO MORANTS;
GRANT SELECT ON DonneesAgglomeration TO JALBAUDL;
GRANT SELECT ON DonneesAgglomeration TO RODRIGUESJ;
GRANT SELECT ON DonneesDepartement TO MORANTS;
GRANT SELECT ON DonneesDepartement TO JALBAUDL;
GRANT SELECT ON DonneesDepartement TO RODRIGUESJ;
GRANT SELECT ON Cinemas TO MORANTS;
GRANT SELECT ON Cinemas TO JALBAUDL;
GRANT SELECT ON Cinemas TO RODRIGUESJ;
GRANT SELECT ON Annees TO MORANTS;
GRANT SELECT ON Annees TO JALBAUDL;
GRANT SELECT ON Annees TO RODRIGUESJ;
