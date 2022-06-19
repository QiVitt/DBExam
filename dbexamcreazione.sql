
DROP DATABASE IF EXISTS Dbexam;

CREATE DATABASE Dbexam;

USE Dbexam;

DROP TABLE IF EXISTS Medico;

CREATE TABLE Medico (
    Nome VARCHAR(20),
    Cognome VARCHAR(20),
    DataNascita DATE,
    CodiceFiscale CHAR(16),
    CRM INT(5),
    pIVA CHAR(11),
    IndirizzoStudio VARCHAR(35),
    CittaStudio VARCHAR(15),
    Email VARCHAR(30),
    Cell CHAR(10),
    PRIMARY KEY (CRM)
) ;

DROP TABLE IF EXISTS Paziente;

CREATE TABLE Paziente (
    ID INT(4),
    CRM INT(5),
    OnOff BOOLEAN,
    PRIMARY KEY (ID),
    FOREIGN KEY (CRM) REFERENCES Medico(CRM)
) ;

ALTER TABLE Paziente
CHANGE ID ID INT(4) AUTO_INCREMENT;

ALTER TABLE Paziente
CHANGE CRM CRM INT(5) NOT NULL;

ALTER TABLE Paziente
CHANGE OnOff OnOff BOOLEAN DEFAULT TRUE ;

DROP TABLE IF EXISTS DataAnagrafica;

CREATE TABLE DataAnagrafica (
    ID INT(4),
    Nome VARCHAR(20),
    Cognome VARCHAR(20),
    Sesso VARCHAR(10),
    CodiceFiscale CHAR(16),
    LinguaMain VARCHAR(12),
    Email VARCHAR(30),
    Cell CHAR(10),
    DataNascita DATE,
    LuogoNascita VARCHAR(20),
    StatoCivile VARCHAR(12),
    Istruzione VARCHAR(15),
    ViaResidenza VARCHAR(30),
    nResidenza INT(3),
    CittaResidenza VARCHAR(15),
    NomRiferimento VARCHAR(35),
    CellRiferimento CHAR(10),
    IndirizzoRiferimento VARCHAR(30),
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES Paziente(ID)
) ;

ALTER TABLE DataAnagrafica
CHANGE CodiceFiscale CodiceFiscale CHAR(16) NOT NULL,
CHANGE Email Email VARCHAR(30) NOT NULL,
CHANGE Cell Cell CHAR(10) NOT NULL ;

DROP TABLE IF EXISTS CartellaClinica;

CREATE TABLE CartellaClinica (
    ID INT(4),
    Altezza INT(3),
    Peso FLOAT(5),
    BMI FLOAT(4),
    CapacitaFisica VARCHAR(20),
    Pressione INT(3),
    Intolleranze VARCHAR(45),
    Allergie VARCHAR(45),
    GruppoSanguigno VARCHAR(2),
    RH CHAR(1),
    AssunzioneAlcool BOOLEAN,
    Fumo BOOLEAN,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES Paziente(ID)
) ;

DROP TABLE IF EXISTS Vaccinazione;

CREATE TABLE Vaccinazione (
    IDVax VARCHAR(10),
    NomeVax VARCHAR(25),
    Note VARCHAR(125),
    PRIMARY KEY (IDVax)
) ;

DROP TABLE IF EXISTS Somministrazione;

CREATE TABLE Somministrazione (
    ID INT(4),
    IDVax VARCHAR(10),
    Lotto VARCHAR(10),
    DataDose DATE,
    NoteMediche VARCHAR(100),
    PRIMARY KEY (ID, IDVax, DataDose),
    FOREIGN KEY (ID) REFERENCES Paziente(ID),
    FOREIGN KEY (IDVax) REFERENCES Vaccinazione(IDVax)
) ;

DROP TABLE IF EXISTS Patologia;

CREATE TABLE Patologia (
    IDPatologia INT(5),
    NomePatologia VARCHAR(25),
    Note VARCHAR(125),
    PRIMARY KEY (IDPatologia)
) ;

DROP TABLE IF EXISTS Diagnosis;

CREATE TABLE Diagnosis (
    ID INT(4),
    IDPatologia INT(5),
    DataRilevazione DATE,
    NoteMediche VARCHAR(100),
    PRIMARY KEY (ID, IDPatologia, DataRilevazione),
    FOREIGN KEY (ID) REFERENCES Paziente(ID),
    FOREIGN KEY (IDPatologia) REFERENCES Patologia(IDPatologia)
) ;

DROP TABLE IF EXISTS VisitaSpecializzata;

CREATE TABLE VisitaSpecializzata (
    IDVisita INT(5),
    NomeVisita VARCHAR(25),
    Note VARCHAR(125),
    PRIMARY KEY (IDVisita)
) ;

DROP TABLE IF EXISTS Svolgimento;

CREATE TABLE Svolgimento (
    ID INT(4),
    IDVisita INT(5),
    DataEsecuzione DATE,
    NoteMediche VARCHAR(100),
    PRIMARY KEY (ID, IDVisita, DataEsecuzione),
    FOREIGN KEY (ID) REFERENCES Paziente(ID),
    FOREIGN KEY (IDVisita) REFERENCES VisitaSpecializzata(IDVisita)
) ;

DROP TABLE IF EXISTS Medicinale;

CREATE TABLE Medicinale (
    IDMedicinale INT(5),
    NomeMedicinale VARCHAR(25),
    Note VARCHAR(125),
    PRIMARY KEY (IDMedicinale)
) ;

DROP TABLE IF EXISTS Assunzione;

CREATE TABLE Assunzione (
    ID INT(4),
    IDMedicinale INT(5),
    NoteMediche VARCHAR(100),
    PRIMARY KEY (ID, IDMedicinale),
    FOREIGN KEY (ID) REFERENCES Paziente(ID),
    FOREIGN KEY (IDMedicinale) REFERENCES Medicinale(IDMedicinale)
) ;

DROP TABLE IF EXISTS Posologia;

CREATE TABLE Posologia (
    IDMedicinale INT(5),
    Dose INT(4),
    Prezzo FLOAT(5),
    Esenzione BOOLEAN,
    PRIMARY KEY (IDMedicinale, Dose),
    FOREIGN KEY (IDMedicinale) REFERENCES Medicinale(IDMedicinale)
) ;


#SHOW TABLES

#DROP TABLE Assunzione, CartellaClinica, DataAnagrafica, Diagnosis, Medicinale, Medico, Patologia, Paziente, Posologia, Somministrazione, Svolgimento, Vaccinazione, VisitaSpecializzata;

INSERT INTO Medico
VALUES ('Marco', 'Dellafe', '2000-10-05', 'DLLMRC00R05L424T', '10010', '00000200050', 'Via delle Pere 25', 'Trieste', 'marcodellafe@studiomedico.com', '3475824062'),
       ('Veronica', 'Prete', '1990-02-15', 'PRTVNC90B55F257S', '25025', '20045772200', 'Viale della Guerra', 'Modena', 'veronicaprete@studiomedico.com', '3457724600') ;

INSERT INTO Paziente (dbexam.Paziente.ID, dbexam.Paziente.CRM)
VALUES (NULL, 10010),
       (NULL, 25025),
       (NULL, 25025),
       (NULL, 10010),
       (NULL, 25025);

INSERT INTO Vaccinazione (IDVax, NomeVax)
VALUES (5, 'Tetravalente'),
       (20, 'Pertosse'),
       (150, 'Covid'),
       (202, 'Meningococco'),
       (477, 'Difterite');

INSERT INTO Medicinale
VALUES (2468, 'Tachipirina', NULL);

INSERT INTO Somministrazione (ID, IDVax, Lotto, DataDose)
VALUES (2, 5, '00AC5', '2017-02-02');

INSERT INTO DataAnagrafica (ID, Nome, Cognome, Sesso, CodiceFiscale, LinguaMain, Email, Cell, DataNascita, LuogoNascita, StatoCivile, Istruzione, ViaResidenza, nResidenza, CittaResidenza, NomRiferimento, CellRiferimento, IndirizzoRiferimento)
VALUES (5, 'Federico', 'Red', 'Male', 'ThisisarandomCF', 'Italian', 'Federicored@gmail.com', '3425733850', '1990-02-05', 'Roma', 'Single', 'University', 'Via Fontane', 4, 'Roma', 'Alberto', '4582200636', 'Via Verde');

INSERT INTO CartellaClinica (ID, Altezza, Peso, BMI, CapacitaFisica, Pressione, Intolleranze, Allergie, GruppoSanguigno, RH, AssunzioneAlcool, Fumo)
VALUES (5, 180, 75, 20.5, 'Yes', 190, 'Nessuna', 'Tachipirina', 'A', '+', FALSE, FALSE );

CREATE TRIGGER Massimale
BEFORE INSERT ON Paziente
FOR EACH ROW
BEGIN

    DECLARE counter INT ;
    SELECT COUNT(ID) INTO counter FROM Paziente WHERE CRM = NEW.CRM ;

    IF counter >= 1500 THEN
        SIGNAL SQLSTATE '45025' SET MESSAGE_TEXT = 'Masssimale raggiunto' ;
    END IF ;

END ;

CREATE FUNCTION ConteggioStudio( )
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Tmp INT ;
    SELECT COUNT(ID) INTO Tmp FROM Paziente;
    RETURN Tmp ;
END ;

CREATE FUNCTION ConteggioMedico( CRMNumber INT )
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Tmp INT ;
    SELECT COUNT(ID) INTO Tmp FROM Paziente WHERE Paziente.CRM = CRMNumber ;
    RETURN Tmp ;
END ;



DELIMITER //

CREATE PROCEDURE VisioneGenerale ( IN IDPt INT )

BEGIN

    SELECT * FROM DataAnagrafica WHERE ID = IDPt
        UNION
    SELECT ID, Altezza, Peso, BMI, CapacitaFisica, Pressione, Intolleranze, Allergie, GruppoSanguigno, RH, AssunzioneAlcool, Fumo, NULL, NULL, NULL, NULL, NULL, NULL FROM CartellaClinica WHERE ID = IDPt
        UNION
    SELECT ID, IDVax, Lotto, DataDose, NoteMediche, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL FROM Somministrazione WHERE ID = IDPt ;

#       UNION
#   SELECT ...

END //

DELIMITER ;

CALL VisioneGenerale( 5 );



DELIMITER //

CREATE PROCEDURE IndagineClinica ( IN IDPt INT )

BEGIN

# Viene omessa la verifica che il paziente con ID fornito esista veramente

    DECLARE Alt INT ;
    DECLARE Altcheck BOOLEAN DEFAULT FALSE ;
    DECLARE Pes FLOAT;
    DECLARE Pescheck BOOLEAN DEFAULT FALSE ;
    DECLARE BMIS FLOAT;
    DECLARE BMIScheck BOOLEAN DEFAULT FALSE ;
    DECLARE Press INT;
    DECLARE Presscheck BOOLEAN DEFAULT FALSE ;
    DECLARE AssunzAlc BOOLEAN DEFAULT FALSE;
    DECLARE Smoker BOOLEAN DEFAULT FALSE;

    SELECT Altezza INTO Alt FROM CartellaClinica WHERE ID = IDPt ;
    SELECT Peso INTO Pes FROM CartellaClinica WHERE ID = IDPt ;
    SELECT BMI INTO BMIS FROM CartellaClinica WHERE ID = IDPt ;
    SELECT Pressione INTO Press FROM CartellaClinica WHERE ID = IDPt ;
    SELECT AssunzioneAlcool INTO AssunzAlc FROM CartellaClinica WHERE ID = IDPt ;
    SELECT Fumo INTO Smoker FROM CartellaClinica WHERE ID = IDPt ;

    IF Alt < 195 OR Alt > 200 THEN
        SET Altcheck = TRUE ;
    END IF ;
    IF Pes > 70 THEN
        SET Pescheck = TRUE ;
    END IF ;
    IF BMIS > 50 THEN
        SET BMIScheck = TRUE ;
    END IF ;
    IF Press > 180 THEN
        SET Presscheck = TRUE ;
    END IF ;

    SELECT Altcheck, Pescheck, BMIScheck, Presscheck, AssunzAlc, Smoker ;

END //

DELIMITER ;

CALL IndagineClinica( 5 );



CREATE TRIGGER Preclusione
BEFORE INSERT ON Assunzione
FOR EACH ROW
BEGIN

    IF NEW.IDMedicinale = 2468 AND (SELECT Allergie FROM CartellaClinica WHERE ID = NEW.ID) = 'Tachipirina'
    THEN
        SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Il paziente è allergico al farmaco' ;
    END IF ;

END ;

INSERT INTO Assunzione
VALUES (5, 2468, 'Bla bla bla') ;
