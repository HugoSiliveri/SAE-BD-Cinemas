        -- SCRIPT DE CREATION DES VUES 

-- DEPARTEMENT ET ANNEES

CREATE OR REPLACE VIEW DepartementsEtAnnee(numDepartement, annee, nbEtablissements, nbEcrans, nbFauteuils, nbMultiplexes, nbSeances, nbEntrees, recettes, RME, indiceFrequentation, tauxOccupation, nbEtablissementsAE, nbEcransAE, nbFauteuilsAE, nbSeancesAE, nbEntreesAE, recettesAE, RMEAE,indiceFrequentationAE, tauxOccupationAE) AS 
SELECT dd.numDepartement, a.annee, dd.nbEtablissements, dd.nbEcrans, dd.nbFauteuils, dd.nbMultiplexes, dd.nbSeances, dd.nbEntrees, dd.recettes, AVG(RME), AVG(indiceFrequentation), dd.tauxOccupation, dd.nbEtablissementsAE, dd.nbEcransAE, dd.nbFauteuilsAE, dd.nbSeancesAE, dd.nbEntreesAE, dd.recettesAE, AVG((recettesAE/nbEntreesAE)) as RMEAE, AVG(nbEntreesAE/populationDepartement) as indiceFrequentationAE, dd.tauxOccupationAE
FROM DonneesDepartement dd 
    JOIN Departements d ON d.numDepartement = dd.numDepartement
    JOIN Annees a ON a.annee = dd.annee
    JOIN DonneesCommune dc ON a.annee = dc.annee
GROUP BY dd.numDepartement, a.annee, dd.nbEtablissements, dd.nbEcrans, dd.nbFauteuils, dd.nbMultiplexes, dd.nbSeances, dd.nbEntrees, dd.recettes,  dd.tauxOccupation, dd.nbEtablissementsAE, dd.nbEcransAE, dd.nbFauteuilsAE, dd.nbSeancesAE, dd.nbEntreesAE, dd.recettesAE, dd.tauxOccupationAE;


GRANT SELECT ON DepartementsEtAnnee TO MORANTS;
GRANT SELECT ON DepartementsEtAnnee TO JALBAUDL;
GRANT SELECT ON DepartementsEtAnnee TO RODRIGUESJ;

-- NOUVELLES REGIONS ET ANNEES 

CREATE OR REPLACE VIEW NouvelleRegionEtAnnee(region, annee, nbEtablissements, nbEcrans, nbFauteuils, nbMultiplexes, nbSeances, nbEntrees, recettes, RME, indiceFrequentation, nbEtablissementsAE, nbEcransAE, nbFauteuilsAE, nbSeancesAE, nbEntreesAE, recettesAE, RMEAE, indiceFrequentationAE) AS 
SELECT r.nomRegion as region, annee, SUM(DISTINCT dd.nbEtablissements), SUM(DISTINCT dd.nbEcrans), SUM(DISTINCT dd.nbFauteuils), SUM(DISTINCT dd.nbMultiplexes), SUM(DISTINCT dd.nbSeances), SUM(DISTINCT dd.nbEntrees), SUM(DISTINCT dd.recettes), SUM(dd.RME), SUM(dd.indiceFrequentation), SUM(DISTINCT dd.nbEtablissementsAE), SUM(DISTINCT dd.nbEcransAE), SUM(DISTINCT dd.nbFauteuilsAE), SUM(DISTINCT dd.nbSeancesAE), SUM(DISTINCT dd.nbEntreesAE), SUM(DISTINCT dd.recettesAE), SUM(RMEAE), SUM(indiceFrequentationAE)
FROM DepartementsEtAnnee dd
    JOIN Departements d On d.numDepartement = dd.numDepartement
    JOIN Regions r ON r.nomRegion = d.nomRegion
WHERE annee >= 2016
GROUP BY r.nomRegion, annee
ORDER BY region, annee;


GRANT SELECT ON NouvelleRegionEtAnnee TO MORANTS;
GRANT SELECT ON NouvelleRegionEtAnnee TO JALBAUDL;
GRANT SELECT ON NouvelleRegionEtAnnee TO RODRIGUESJ;

-- REGIONS ET ANNEES (avec les anciennes régions)

CREATE OR REPLACE VIEW RegionEtAnnee(region, annee, nbEtablissements, nbEcrans, nbFauteuils, nbMultiplexes, nbSeances, nbEntrees, recettes, RME, indiceFrequentation, nbEtablissementsAE, nbEcransAE, nbFauteuilsAE, nbSeancesAE, nbEntreesAE, recettesAE, RMEAE, indiceFrequentationAE) AS 
SELECT * 
FROM nouvelleRegionEtAnnee
UNION
SELECT r.nomRegion as region, dd.annee, SUM(DISTINCT dd.nbEtablissements), SUM(DISTINCT dd.nbEcrans), SUM(DISTINCT dd.nbFauteuils), SUM(DISTINCT dd.nbMultiplexes), SUM(DISTINCT dd.nbSeances), SUM(DISTINCT dd.nbEntrees), SUM(DISTINCT dd.recettes), SUM(dd.RME), SUM(dd.indiceFrequentation), SUM(DISTINCT dd.nbEtablissementsAE), SUM(DISTINCT dd.nbEcransAE), SUM(DISTINCT dd.nbFauteuilsAE), SUM(DISTINCT dd.nbSeancesAE), SUM(DISTINCT dd.nbEntreesAE), SUM(DISTINCT dd.recettesAE), SUM(RMEAE), SUM(indiceFrequentationAE)
FROM DepartementsEtAnnee dd
    JOIN Departements d On d.numDepartement = dd.numDepartement
    JOIN Regions r ON r.nomRegion = d.nomRegion
WHERE annee < 2016
GROUP BY r.nomRegion, dd.annee;


GRANT SELECT ON RegionEtAnnee TO MORANTS;
GRANT SELECT ON RegionEtAnnee TO JALBAUDL;
GRANT SELECT ON RegionEtAnnee TO RODRIGUESJ;

-- VUE NB ENTREES PAR REGION ET PAR CATEGORIE DE PUBLIC

CREATE OR REPLACE VIEW NbEntreesParRegionParCategorie(region, annee, categoriePublic, nbEntrees) AS 
SELECT ra.region, ra.annee, nomCategorie, nbEntrees*(pourcentageEntrees/100)
FROM RegionEtAnnee ra 
    JOIN tauxCategorie t On t.nomRegion = ra.region AND ra.annee = t.annee
ORDER BY ra.region, ra.annee;

GRANT SELECT ON NbEntreesParRegionParCategorie TO MORANTS;
GRANT SELECT ON NbEntreesParRegionParCategorie TO JALBAUDL;
GRANT SELECT ON NbEntreesParRegionParCategorie TO RODRIGUESJ;

-- VUE NB ENTREES POUR CHAQUE SEXE PAR ANNEES

CREATE OR REPLACE VIEW NbEntreesParSexeParAnnee(annee, sexe, nbEntrees) AS 
SELECT annee, nb.categoriePublic, SUM(nbEntrees)
FROM nbEntreesParRegionParCategorie nb
JOIN CategoriesPublic c On c.nomCategorie = nb.categoriePublic
JOIN TypesCategories t On t.typeCategorie = c.typeCategorie
WHERE t.typeCategorie = 'sexe'
GROUP BY annee, nb.categoriePublic
ORDER BY annee;

GRANT SELECT ON NbEntreesParSexeParAnnee TO MORANTS;
GRANT SELECT ON NbEntreesParSexeParAnnee TO JALBAUDL;
GRANT SELECT ON NbEntreesParSexeParAnnee TO RODRIGUESJ;

-- VUE NB ENTREES POUR CHAQUE TRANCHES D'AGES PAR ANNEES

CREATE OR REPLACE VIEW NbEntreesParAgeParAnnee(annee, age, nbEntrees) AS 
SELECT annee, nb.categoriePublic, SUM(nbEntrees)
FROM nbEntreesParRegionParCategorie nb
JOIN CategoriesPublic c On c.nomCategorie = nb.categoriePublic
JOIN TypesCategories t On t.typeCategorie = c.typeCategorie
WHERE t.typeCategorie = 'age'
GROUP BY annee, nb.categoriePublic
ORDER BY annee;

GRANT SELECT ON NbEntreesParAgeParAnnee TO MORANTS;
GRANT SELECT ON NbEntreesParAgeParAnnee TO JALBAUDL;
GRANT SELECT ON NbEntreesParAgeParAnnee TO RODRIGUESJ;

-- VUE AGGLOMERATION SUR PLUSIEURS DEPARTEMENTS

CREATE OR REPLACE VIEW AgglomerationDansDepartements(numAgglomeration, nomAgglomeration) AS 
SELECT numAgglomeration, nomAgglomeration
FROM Agglomerations 
GROUP BY numAgglomeration, nomAgglomeration
HAVING COUNT(numDepartement) > 1;


GRANT SELECT ON AgglomerationDansDepartements TO MORANTS;
GRANT SELECT ON AgglomerationDansDepartements TO JALBAUDL;
GRANT SELECT ON AgglomerationDansDepartements TO RODRIGUESJ;

-- VUE DONNEES PAR JOUR DE LA SEMAINE PAR ANNEES

CREATE OR REPLACE VIEW DonneesParJourParAnnee(annee, jour, nbEntree, recette, nbSeance) AS 
SELECT fj.annee, nomJour, (SUM(nbEntrees)*pourcentageEntrees/100) as nbEntreesJour, (SUM(recettes)/pourcentageRecettes) as nbRecetteJour, (SUM(nbSeances)/pourcentageSeances) as nbSeanceJour
FROM FrequentationJour fj 
    JOIN RegionEtAnnee ra On ra.annee = fj.annee
GROUP BY fj.annee, nomJour, pourcentageEntrees, pourcentageRecettes, pourcentageSeances
ORDER BY annee, nomjour;


GRANT SELECT ON DonneesParJourParAnnee TO MORANTS;
GRANT SELECT ON DonneesParJourParAnnee TO JALBAUDL;
GRANT SELECT ON DonneesParJourParAnnee TO RODRIGUESJ;

-- VUE NB ENTREES PAR COMMUNES EN 2014

CREATE OR REPLACE VIEW NbEntreeParCommunes2014(numCommune, nomCommune, nbEntree) AS 
SELECT dc.numCommune, nomCommune, nbEntrees
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = 2014
ORDER BY dc.numCommune;


GRANT SELECT ON NbEntreeParCommunes2014 TO MORANTS;
GRANT SELECT ON NbEntreeParCommunes2014 TO JALBAUDL;
GRANT SELECT ON NbEntreeParCommunes2014 TO RODRIGUESJ;

-- VUE NB ECRANS ET CINEMAS PAR COMMUNES EN 2020

CREATE OR REPLACE VIEW NbEcransEtCinemasParCommunes(numCommune, nomCommune, numDepartement, nbEcrans, nbCinemas) AS 
SELECT dc.numCommune, nomCommune, numDepartement, nbEcrans, nbEtablissements
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
    JOIN Agglomerations a ON a.numAgglomeration = c.numAgglomeration
WHERE annee = 2020
ORDER BY dc.numCommune;


GRANT SELECT ON NbEcransEtCinemasParCommunes TO MORANTS;
GRANT SELECT ON NbEcransEtCinemasParCommunes TO JALBAUDL;
GRANT SELECT ON NbEcransEtCinemasParCommunes TO RODRIGUESJ;

-- VUE COMMUNES AVEC LE PLUS D'ECRANS PAR DEPARTEMENT

CREATE OR REPLACE VIEW CommunesPlusEcransDepartement(numDepartement, numCommune) AS 
SELECT numDepartement, nomCommune
FROM nbEcransEtCinemasParCommunes nb
WHERE nbCinemas = (SELECT MAX(nbCinemas)
                    FROM nbEcransEtCinemasParCommunes nb2
                    WHERE nb.numDepartement = nb2.numDepartement
                    GROUP BY numDepartement)
GROUP BY numDepartement, nomCommune;


GRANT SELECT ON CommunesPlusEcransDepartement TO MORANTS;
GRANT SELECT ON CommunesPlusEcransDepartement TO JALBAUDL;
GRANT SELECT ON CommunesPlusEcransDepartement TO RODRIGUESJ;

-- VUE NOUVELLES REGIONS AVEC ANCIENNES REEGIONS

CREATE OR REPLACE VIEW NouvellesRegionsAvecAnciennes(nouvelleRegion, anciennesRegions) AS 
SELECT nouvelleRegion, 
    WM_CONCAT(DISTINCT ancienneRegion) AS anciennesRegions
FROM Cinemas 
GROUP BY nouvelleRegion
ORDER BY COUNT(ancienneRegion);


GRANT SELECT ON NouvellesRegionsAvecAnciennes TO MORANTS;
GRANT SELECT ON NouvellesRegionsAvecAnciennes TO JALBAUDL;
GRANT SELECT ON NouvellesRegionsAvecAnciennes TO RODRIGUESJ;

-- VUE NB ENTREES PAR COMMUNES EN OCCITANIE PAR AN

CREATE OR REPLACE VIEW NbEntreesOccitanieParAn(annee, nomCommune, nbEntrees) AS 
SELECT annee, c.nomCommune, dc.nbEntrees
FROM Communes c 
    JOIN DonneesCommune dc On c.numCommune = dc.numCommune
    JOIN Cinemas cine ON cine.numCommune = c.numCommune
WHERE nouvelleRegion = 'Occitanie'
ORDER BY nomCommune, annee;


GRANT SELECT ON NbEntreesOccitanieParAn TO MORANTS;
GRANT SELECT ON NbEntreesOccitanieParAn TO JALBAUDL;
GRANT SELECT ON NbEntreesOccitanieParAn TO RODRIGUESJ;

-- VUE COMMUNE AVEC LE PLUS D'ENTREES EN OCCITANIE PAR AN

CREATE OR REPLACE VIEW CommunePlusEntreesOccitanieAn(annee, nomCommune) AS 
SELECT annee, nomCommune
FROM NbEntreesOccitanieParAn nb
WHERE nbEntrees = (SELECT MAX(nbEntrees)
                    FROM nbEntreesOccitanieParAn nb2
                    WHERE nb.annee = nb2.annee
                    GROUP BY annee)
GROUP BY annee, nomCommune
ORDER BY annee;


GRANT SELECT ON CommunePlusEntreesOccitanieAn TO MORANTS;
GRANT SELECT ON CommunePlusEntreesOccitanieAn TO JALBAUDL;
GRANT SELECT ON CommunePlusEntreesOccitanieAn TO RODRIGUESJ;

