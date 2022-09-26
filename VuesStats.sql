    -- SCRIPT VUES POUR STATS

-- VUE AGGLOMERATION EN 2010
CREATE OR REPLACE VIEW Agglo2010(nbEtablissements, nbEcrans, nbEntrees, recettes, tauxOccupation) AS 
SELECT nbEtablissements, nbEcrans, nbEntrees, recettes, tauxOccupation
FROM DonneesAgglomeration
WHERE annee = '2010';

-- VUE HOMOGENES EN TAILLE POPULATION

CREATE OR REPLACE VIEW VariablesHomogenes(nbEtabPop, nbEcransPop, nbFauteuilsPop, indiceFrequentation) AS 
SELECT (100000*da.nbEtablissements)/populationAgglomeration, (100000*da.nbEcrans)/populationAgglomeration, (100000*da.nbFauteuils)/populationAgglomeration,
nbEntrees/populationAgglomeration
FROM Cinemas c
    JOIN Communes com ON c.numCommune = com.numCommune
    JOIN Agglomerations a On com.numAgglomeration = a.numAgglomeration
    JOIN DonneesAgglomeration da On a.numAgglomeration = da.numAgglomeration
WHERE annee = '2010';
   
SELECT * FROM VariablesHomogenes;

-- VUE INDICE PAR ANNEE
CREATE OR REPLACE VIEW indice2010(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2010';

CREATE OR REPLACE VIEW indice2011(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2011';

CREATE OR REPLACE VIEW indice2012(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2012';

CREATE OR REPLACE VIEW indice2013(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2013';

CREATE OR REPLACE VIEW indice2014(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2014';

CREATE OR REPLACE VIEW indice2015(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2015';

CREATE OR REPLACE VIEW indice2016(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2016';

CREATE OR REPLACE VIEW indice2017(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2017';

CREATE OR REPLACE VIEW indice2018(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2018';

CREATE OR REPLACE VIEW indice2019(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2019';

CREATE OR REPLACE VIEW indice2020(annee, indiceFrequentation) AS 
SELECT annee, (nbEntrees/populationCommune)
FROM DonneesCommune dc 
    JOIN Communes c ON c.numCommune = dc.numCommune
WHERE annee = '2020';

