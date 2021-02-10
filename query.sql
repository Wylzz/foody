SELECT *
FROM produit
ORDER BY PrixUnit
LIMIT 10;

SELECT *
FROM produit
ORDER BY PrixUnit DESC
LIMIT 3;

# ////////////////////////////////////////////////////////////////

SELECT *
FROM client
WHERE Ville = 'Paris'
  AND Fax IS NULL;

SELECT *
FROM client
WHERE Pays IN ('France', 'Canada', 'Germany');

SELECT *
FROM client
WHERE Societe LIKE '%restaurant%';

# ////////////////////////////////////////////////////////////////

SELECT Description
FROM categorie;

SELECT Pays, Ville
FROM client
ORDER BY Pays ASC, Ville DESC;

SELECT *
FROM produit
WHERE QteParUnit LIKE '%can%'
   OR QteParUnit LIKE '%bottle%';

SELECT Societe, Contact, Ville
FROM fournisseur
ORDER BY Ville;

SELECT UPPER(NomProd)
FROM produit
WHERE NoFour = 8
  AND PrixUnit
    BETWEEN 10 AND 100;

SELECT *
FROM employe;

Select NoEmp
FROM commande
WHERE VilleLiv IN ('Lille', 'Lyon', 'Nantes');

SELECT *
FROM produit
WHERE NomProd LIKE '%tofu%'
   OR '%choco%'
    AND PrixUnit < 100;

# ////////////////////////////////////////////////////////////////

SELECT PrixUnit,
       Remise,
       Qte,
       ROUND(PrixUnit * Remise)                    AS 'MONTANT DE LA REMISE',
       ROUND(PrixUnit * (PrixUnit * Remise) * Qte) AS 'PRIX FINAL'
FROM detailcommande
WHERE NoCom = 10251;

# ////////////////////////////////////////////////////////////////

SELECT NomProd,
       CASE
           WHEN (INdisponible = 1) THEN 'Produit non disponible'
           ELSE 'Produit disponible'
           END AS 'INformation'
FROM produit;

SELECT NoCom,
       Remise,
       CASE
           WHEN (Remise * 100 = 0) THEN 'aucune remise'
           WHEN (Remise * 100 < 6) THEN 'petit remise'
           WHEN (Remise * 100 < 16) THEN 'remise modérée'
           ELSE 'remise importante'
           END AS 'INformation'
FROM detailcommande;

SELECT NoCom,
       DateCom,
       DateEnv,
       AlivAvant,
       CASE
           WHEN (AlivAvant >= DateEnv) THEN 'A Temps'
           Else 'EN RETARD'
           END as 'INformation'
FROM commande;

# ////////////////////////////////////////////////////////////////

SELECT CONCAT(Adresse, ' ', Ville, ' ', CodePostal, ' ', Pays) AS 'Adresse_complète'
FROM client;

SELECT LEFT(CodeCli, 3),
       lower(Societe),
       REPLACE(Fonction, 'Owner', 'Freelance')
FROM client;

# ////////////////////////////////////////////////////////////////

SELECT NoCom, DATE_FORMAT(DateCom, '%W') AS JOUR
FROM commande
WHERE DATE_FORMAT(DateCom, '%W') LIKE 'Saturday'
   OR DATE_FORMAT(DateCom, '%W') LIKE 'Sunday';

SELECT DateCom,
       AlivAvant,
       DATEDIFF(AlivAvant, DateCom) AS JOUR,
       CASE
           WHEN (DATEDIFF(AlivAvant, DateCom) > 27) THEN 'CONTACTER'
           ELSE 'NE PAS CONTACTER'
           END
FROM commande;

# ////////////////////////////////////////////////////////////////

SELECT COUNT(Nom)
FROM employe
WHERE Fonction LIKE 'Sales Manager';

SELECT COUNT(PrixUnit) AS Plus_grand_que_50
FROM produit
WHERE PrixUnit >= 50;

SELECT COUNT(*) AS nbr_of_product
FROM produit
WHERE CodeCateg = 2
  AND UnitesStock > 9;

SELECT COUNT(*)
FROM produit
WHERE CodeCateg = 2 AND NoFour LIKE '1'
   OR NoFour LIKE '18';

SELECT COUNT(DISTINCT Pays) AS nbr_pays
FROM client;

SELECT COUNT(*)
FROM commande
WHERE DateCom LIKE '2006-08%';

# ////////////////////////////////////////////////////////////////

SELECT MAX(Port) AS MAX_PORT, MIN(Port) AS MIN_PORT, ROUND(MAX(Port) / MIN(Port)) AS PORT_MOYEN
FROM commande
WHERE CodeCli LIKE 'QUICK';

SELECT *
FROM commande;

# ////////////////////////////////////////////////////////////////

SELECT Fonction, COUNT(*)
FROM employe
GROUP BY Fonction;

SELECT NoMess, AVG(Port)
FROM commande
GROUP BY NoMess;

SELECT NomProd, AVG(NoFour)
FROM produit
GROUP BY NomProd;

# ////////////////////////////////////////////////////////////////

SELECT NoFour, COUNT(*) AS nb
FROM produit
GROUP BY NoFour
HAVING nb = 1;

SELECT CodeCateg, PrixUnit nb
FROM produit
GROUP BY PrixUnit, CodeCateg
HAVING PrixUnit > 50;

SELECT NoFour, CodeCateg
FROM produit
GROUP BY NoFour, CodeCateg
HAVING CodeCateg = 1;

# ////////////////////////////////////////////////////////////////

SELECT *
FROM fournisseur
         NATURAL JOIN produit;

SELECT *
FROM commande
         NATURAL JOIN client
WHERE Societe = 'Lazy K Kountry Store';

SELECT NomMess, count(*)
FROM messager
         NATURAL JOIN commande
GROUP BY NomMess;

# ////////////////////////////////////////////////////////////////

SELECT *
FROM produit
         INNER JOIN fournisseur f on produit.NoFour = f.NoFour;

SELECT *
FROM client
         INNER JOIN commande c on client.CodeCli = c.CodeCli
WHERE Societe = 'Lazy K Kountry Store';

SELECT NomMess, count(*)
FROM messager
         INNER JOIN commande c on messager.NoMess = c.NoMess
GROUP BY NomMess;

# ////////////////////////////////////////////////////////////////

SELECT p.NomProd, COUNT(NoCom)
FROM detailcommande
         LEFT OUTER JOIN produit p on detailcommande.RefProd = p.RefProd
GROUP BY p.NomProd
;

SELECT NomProd,
       CASE
           WHEN COUNT(DISTINCT NoCom) IS NULL THEN "n'a jamais été commandé"
           ELSE COUNT(DISTINCT NoCom)
           END AS "Nb_com/produit"
FROM produit
         JOIN detailCommande USING (RefProd)
         JOIN Commande USING (NoCom)
GROUP BY NomProd;

SELECT produit.*, COUNT(DISTINCT NoCom) AS "nombre de commandes"
FROM produit
         LEFT JOIN detailcommande USING (RefProd)
GROUP BY RefProd
HAVING COUNT(DISTINCT NoCom) = 0;

SELECT NoEmp, NOM
FROM employe
         LEFT JOIN Commande USING (NoEmp)
GROUP BY NoEmp
HAVING COUNT(NoCom) = 0;

# ////////////////////////////////////////////////////////////////

SELECT *
FROM produit p,
     fournisseur f
WHERE p.NoFour = f.NoFour;

SELECT *
FROM client c,
     commande d
WHERE c.CodeCli = d.CodeCli
  AND Societe = 'Lazy K Kountry Store';


SELECT NomMess, COUNT(*)
FROM messager m,
     commande c
WHERE m.NoMess = c.NoMess
GROUP BY NomMess;

# ////////////////////////////////////////////////////////////////


SELECT *
FROM employe
WHERE NoEmp NOT IN (SELECT NoEmp FROM commande WHERE NoEmp = employe.NoEmp);

SELECT COUNT(*) AS nb_produit
FROM produit
WHERE NoFour IN (SELECT NoFour FROM fournisseur WHERE fournisseur.Societe = 'Ma Maison');

SELECT COUNT(*) AS nb_commande
FROM Commande
WHERE NoEmp IN
      (SELECT NoEmp
       FROM employe
       WHERE RendCompteA IN
             (SELECT NoEmp FROM employe WHERE Nom = 'Buchanan' AND Prenom = 'Steven'));

# ////////////////////////////////////////////////////////////////

SELECT NoFour, Count(*)
FROM produit p,
     detailcommande c
WHERE p.RefProd = c.RefProd
  AND EXISTS(SELECT *
             FROM detailcommande
             WHERE RefProd is not null)
GROUP BY NoFour;

SELECT NoFour
FROM fournisseur
WHERE EXISTS(SELECT *
             FROM commande
             WHERE Pays = 'FRANCE');

SELECT *
FROM fournisseur f
WHERE EXISTS(SELECT *
             FROM produit p
             WHERE NoFour = f.NoFour
               AND EXISTS(SELECT * FROM categorie WHERE CodeCateg = p.CodeCateg AND NomCateg = 'drINks'));

# ////////////////////////////////////////////////////////////////

SELECT Nom, Prenom
FROM employe
WHERE TitreCourtoisie LIKE '%Representative%'
UNION
SELECT Nom, prenom
FROM employe
WHERE Pays = 'UK'
ORDER BY 1;

SELECT Societe, Pays
FROM client
WHERE Ville = 'London'
UNION
SELECT Ville, Pays
FROM employe
WHERE Ville = 'London';

# ////////////////////////////////////////////////////////////////

SELECT DISTINCT nom, prenom
FROM employe
WHERE Fonction LIKE '%Representative%'
  AND pays = 'UK';

SELECT *
FROM client
WHERE CodeCli IN (SELECT CodeCli FROM commande WHERE NoEmp IN (select NoEmp FROM employe WHERE Ville = 'Seattle'))
  AND CodeCli IN (SELECT CodeCli
                  FROM commande
                  WHERE NoCom IN (select NoCom
                                  FROM detailcommande
                                  WHERE RefProd IN (select RefProd
                                                    FROM produit
                                                    WHERE CodeCateg IN (select CodeCateg FROM categorie WHERE NomCateg = 'Desserts'))));

# ////////////////////////////////////////////////////////////////

SELECT nom, prenom
FROM employe
WHERE Fonction LIKE '%representative%'
  AND Pays NOT IN (SELECT pays FROM employe WHERE pays = 'UK');

SELECT societe, pays
FROM client
WHERE CodeCli IN (SELECT CodeCli FROM commande WHERE NoEmp IN (SELECT NoEmp FROM Employe WHERE Ville = 'London'))
  AND CodeCli IN
      (SELECT CodeCli FROM commande WHERE NoMess IN (SELECT NoMess FROM messager WHERE NomMess = 'United Package'));

SELECT DateCom, count(*) as commande
FROM commande
GROUP BY DateCom

SELECT Societe, Count(*) as nb FROM commande LEFT JOIN client c on commande.CodeCli = c.CodeCli
GROUP BY Societe;

SELECT Societe, Count(*) as Nombre_de_Fournisseur FROM produit LEFT JOIN fournisseur f on produit.NoFour = f.NoFour
WHERE Pays IN('UK', 'France', 'Germany')
GROUP BY Societe



