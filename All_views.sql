

          -All views sql grossistes_peinture_69-

          ##Création d’un fichier grossistes et revendeurs de peinture professionnelle (Rhône-69)

          ##Création d’une carte dynamique répertoriant les points de ventes

          ##Origine des données : sirene.fr, mise à jour : mars 2024


 
##Selectionner les colonnes à exploiter, supprimer lignes NULL,modifier texte 
NULL,ordonner par code postal 

SELECT
activitePrincipaleUniteLegale AS NAF,
denominationUniteLegale AS Nom,
IFNULL (complementAdresseEtablissement,'') AS Complement_adresse,
IFNULL (numeroVoieEtablissement,'') AS Numero_voie,
IFNULL (typeVoieEtablissement,'') AS Type_voie,
libelleVoieEtablissement,
codePostalEtablissement,
libelleCommuneEtablissement,
IFNULL (coordonneeLambertAbscisseEtablissement,'0')AS CoordonneesLambertAbscisse,
IFNULL (coordonneeLambertOrdonneeEtablissement,'0')AS CoordonneesLambertOrdonnee
FROM
`grossistes-peinture-sirene.grossistes_peintures.Etablissement` 
WHERE
denominationUniteLegale IS NOT NULL AND
codePostalEtablissement IS NOT NULL AND
libelleCommuneEtablissement IS NOT NULL
ORDER BY 
activitePrincipaleUniteLegale ASC
LIMIT
1000;
 


##Réunir des chaines dans une meme colonne ‘Adresse’, ajout d'une colonne 'code
postal', simplication des noùs de colonnes

SELECT
NAF,
Nom,
CONCAT (Complement_Adresse,' ',Numero_Voie,' ',Type_Voie,
' ',libelleVoieEtablissement,' ',codePostalEtablissement,
' ',libelleCommuneEtablissement)AS Adresse_etablissement,
codePostalEtablissement AS Code_postal,
coordonneesLambertAbscisse AS CoordonneesLambertAbscisse,
coordonneesLambertOrdonnee AS CoordonneesLambertOrdonnee
FROM
`grossistes_peintures.Table_base`
LIMIT
1000;



##Compter le nombre de references NAF presentes dans la table (45 codes NAF)

SELECT COUNT(DISTINCT
activitePrincipaleUniteLegale )AS point_naf
FROM `grossistes-peinture-sirene.grossistes_peintures.Etablissement` 
 


##Qualifier le fichier : Ajout définition au code NAF, suppression lignes NAF non
concernees, tri par code postal

SELECT
NAF,
CASE
WHEN NAF = "20.30Z" THEN "Fabrication de peintures vernis encres et mastics"
WHEN NAF = "46.13Z" THEN "Intermediaires du commerce en bois et materiaux de 
construction"
WHEN NAF = "46.73A" THEN "Commerce de gros (commerce interentreprises) de bois et 
de materiaux de construction"
WHEN NAF = "46.90Z" THEN "Commerce de gros (commerce interentreprises) non specialise"
WHEN NAF = "47.52A" THEN "Commerce de detail de quincaillerie peintures et verres en 
petites surfaces (moins de 400 m²)"
WHEN NAF = "47.52B" THEN "Commerce de detail de quincaillerie peintures et verres en 
grandes surfaces (400 m² et plus)"
WHEN NAF = "47.53Z" THEN "Commerce de detail de tapis moquettes et revetements de murs et
de sols en magasin specialise"
WHEN NAF = "46.73B" THEN "Commerce de gros (commerce interentreprises) d'appareils 
sanitaires et de produits de decoration"
END AS Code_NAF, Nom, Adresse_etablissement, Code_Postal, CoordonneesLambertAbscisse, 
coordonneesLambertOrdonnee
FROM
`grossistes_peintures.table_adesse`
WHERE
NOT LIKE"08.12Z"
AND NAF NOT LIKE"16.10A"
AND NAF NOT LIKE"16.23Z"
AND NAF NOT LIKE"22.23Z"
AND NAF NOT LIKE"22.29A"
AND NAF NOT LIKE"23.20Z"
AND NAF NOT LIKE"23.51Z"
AND NAF NOT LIKE"23.61Z"
AND NAF NOT LIKE"23.69Z"
AND NAF NOT LIKE"23.70Z"
AND NAF NOT LIKE"25.12Z"
AND NAF NOT LIKE"25.99B"
AND NAF NOT LIKE"42.11Z"
AND NAF NOT LIKE"24.33Z"
AND NAF NOT LIKE"24.20Z"
AND NAF NOT LIKE"25.11Z"
AND NAF NOT LIKE"43.12A"
AND NAF NOT LIKE"43.22B"
AND NAF NOT LIKE"43.29A"
AND NAF NOT LIKE"43.32A"
AND NAF NOT LIKE"43.32B"
AND NAF NOT LIKE"43.34Z"
AND NAF NOT LIKE"43.99D"
AND NAF NOT LIKE"46.19A"
AND NAF NOT LIKE"46.72Z"
AND NAF NOT LIKE"47.79Z"
AND NAF NOT LIKE"47.89Z"
AND NAF NOT LIKE"47.79Z"
AND NAF NOT LIKE"47.89Z"
AND NAF NOT LIKE"77.29Z"
AND NAF NOT LIKE"81.30Z"
AND NAF NOT LIKE"46.74A"
AND NAF NOT LIKE"46.74B"
AND NAF NOT LIKE"46.75Z"
AND NAF NOT LIKE"47.11F"
AND NAF NOT LIKE"47.19A"
AND NAF NOT LIKE"47.59B"
AND NAF NOT LIKE"47.72A"
ORDER BY
Code_postal ASC



##Extraction des données pour traduction des coordonnées Lambert en données GPS
(Geofree.fr) puis chargement des données dans une nouvelle table 



##Suppression de 10 lignes sans intéret mal renseignées

SELECT
*
FROM
`grossistes_peintures.gps`
WHERE
gps_lat IS NOT null
