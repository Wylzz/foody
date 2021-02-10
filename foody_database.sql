CREATE DATABASE foody;

CREATE TABLE Client
(
    CodeCli VARCHAR(50) PRIMARY KEY,
    Societe VARCHAR(50) NOT NULL,
    Contact VARCHAR(100),
    Fonction VARCHAR(30),
    Adresse VARCHAR(255),
    Ville VARCHAR(20),
    Region VARCHAR(40),
    CodePostal VARCHAR(10),
    Pays VARCHAR(40),
    Tel VARCHAR(20),
    Fax VARCHAR(20)
);

CREATE TABLE Messager
(
    NoMess INT PRIMARY KEY,
    NomMess VARCHAR(30) NOT NULL,
    Tel VARCHAR(20) NOT NULL
);

/*CREATE TABLE Employe_1
(
    NoEmp INT PRIMARY KEY,
    Nom VARCHAR(255),
    Prenom VARCHAR(255),
    Fonction VARCHAR(255),
    TitreCourtoisie VARCHAR(255),
    DateNaissance VARCHAR(255),
    DateEmbauche VARCHAR(244),
    Adresse VARCHAR(255),
    Ville VARCHAR(244),
    Region VARCHAR(244),
    CodePostal VARCHAR(5),
    Pays VARCHAR(244),
    TelDom VARCHAR(244),
    Extension VARCHAR(244),
    RendCompteA VARCHAR(244)
);*/

CREATE TABLE Employe
(
    NoEmp INT PRIMARY KEY,
    Nom VARCHAR(30) NOT NULL,
    Prenom VARCHAR(30) NOT NULL,
    Fonction VARCHAR(50) NOT NULL,
    TitreCourtoisie VARCHAR(20) NOT NULL,
    DateNaissance VARCHAR(30) NOT NULL,
    DateEmbauche VARCHAR(30),
    Adresse VARCHAR(255),
    Ville VARCHAR(20) NOT NULL,
    Region VARCHAR(40),
    CodePostal VARCHAR(10),
    Pays VARCHAR(40) NOT NULL,
    TelDom VARCHAR(20),
    Extension VARCHAR(40),
    RendCompteA VARCHAR(40)
);

CREATE TABLE Commande
(
    NoCom INT PRIMARY KEY,
    CodeCli VARCHAR(40) NOT NULL,
    FOREIGN KEY (CodeCli) REFERENCES Client(CodeCli),
    NoEmp INT NOT NULL,
    FOREIGN KEY (NoEmp) REFERENCES Employe(NoEmp),
    DateCom VARCHAR(20) NOT NULL,
    AlivAvant VARCHAR(40),
    DateEnv VARCHAR(20),
    NoMess int NOT NULL,
    FOREIGN KEY (NoMess) REFERENCES Messager(NoMess),
    Port VARCHAR(20),
    Destinataire VARCHAR(244),
    AdriLiv VARCHAR(255),
    VilleLiv VARCHAR(30),
    RegionLiv VARCHAR(30),
    CodepostalLiv VARCHAR(10),
    PaysLiv VARCHAR(30)
);

CREATE TABLE Categorie
(
    CodeCateg INT PRIMARY KEY,
    NomCateg VARCHAR(40) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Fournisseur
(
    NoFour INT PRIMARY KEY,
    Societe VARCHAR(244) NOT NULL,
    Contact VARCHAR(255),
    Fonction VARCHAR(100) NOT NULL,
    Adresse VARCHAR(255),
    Ville VARCHAR(30) NOT NULL,
    Region VARCHAR(30),
    CodePostal VARCHAR(10),
    Pays VARCHAR(30) NOT NULL,
    Tel VARCHAR(20) NOT NULL,
    Fax VARCHAR(20),
    PageAccueil VARCHAR(255)
);

CREATE TABLE Produit
(
    RefProd INT PRIMARY KEY NOT NULL,
    NomProd VARCHAR(40),
    NoFour INT NOT NULL,
    FOREIGN KEY (NoFour) REFERENCES Fournisseur(NoFour),
	CodeCateg INT NOT NULL,
    FOREIGN KEY (CodeCateg) REFERENCES Categorie(CodeCateg),
    QteParUnit VARCHAR(50) NOT NULL,
    PrixUnit INT NOT NULL,
    UnitesStock INT NOT NULL,
    UnitesCom INT NOT NULL,
    NiveauReap INT NOT NULL,
    Indisponible INT NOT NULL
);

CREATE TABLE DetailCommande
(
    NoCom INT NOT NULL,
    FOREIGN KEY (NoCom) REFERENCES Commande(NoCom),
    RefProd INT NOT NULL,
    FOREIGN KEY (RefProd) REFERENCES Produit(RefProd),
    PrixUnit INT NOT NULL,
    Qte INT NOT NULL,
    Remise FLOAT NOT NULL
);

