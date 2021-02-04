SELECT * FROM produit
ORDER BY PrixUnit LIMIT 10;

SELECT * FROM produit
ORDER BY PrixUnit DESC LIMIT 3;

# ////////////////////////////////////////////////////////////////

SELECT * FROM client
WHERE Ville = 'Paris'
AND Fax IS NULL;

SELECT * FROM client
WHERE Pays IN ('France', 'Canada', 'Germany');

SELECT * FROM client
WHERE Societe LIKE '%restaurant%';

# ////////////////////////////////////////////////////////////////

SELECT Description FROM categorie;

SELECT Pays, Ville FROM client
ORDER BY Pays ASC, Ville DESC;

SELECT * FROM produit
WHERE QteParUnit LIKE '%can%'
OR QteParUnit LIKE '%bottle%';

SELECT Societe, Contact, Ville FROM fournisseur
ORDER BY Ville;

SELECT UPPER(NomProd) FROM produit
WHERE NoFour = 8
  AND PrixUnit
      BETWEEN 10 AND 100;

SELECT * FROM employe;

Select NoEmp From commande
WHERE VilleLiv IN ('Lille', 'Lyon', 'Nantes');

SELECT * FROM produit
WHERE NomProd LIKE '%tofu%' OR '%choco%'
AND PrixUnit < 100;

# ////////////////////////////////////////////////////////////////

SELECT PrixUnit, Remise, ROUND(PrixUnit % Remise) AS 'MONTANT DE LA REMISE' FROM detailcommande
WHERE NoCom = 10251;

# ////////////////////////////////////////////////////////////////