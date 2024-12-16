CREATE DATABASE dbClients;

USE dbClients;  

## L'ordre de creation des tables est  important, on commence par les tables qui n'ont pas de contrainte de clés étrangères ###
###### TABLE DES REPRESENTANTS #####
CREATE TABLE representants (
  NUM_REPRESENTANT	char(2) PRIMARY KEY,
  NOM			varchar(50) NOT NULL,
  PRENOM		varchar(50),
  ADRESSE		varchar(100),
  VILLE			varchar(30),
  ETAT			varchar(20),
  CODE_POSTAL		char(5),
  TOTAL_COMMISSION	decimal(7,2),
  TAUX_COMMISSION	decimal(3,2)
  )ENGINE=InnoDB;

###### TABLE DES CLIENTS #####

CREATE TABLE clients
(NUM_CLIENT 	SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
NOM 			varchar(50) 	NOT NULL,
PRENOM 		varchar(50) 	NOT NULL,
ADRESSE		varchar(100),
VILLE			varchar(30),
ETAT			varchar(20),
CODE_POSTAL		char(5),
SOLDE			decimal(7,2),
LIMITE_CREDIT		decimal(6,2),
NUM_REPRESENTANT	char(2) , 
FOREIGN KEY(NUM_REPRESENTANT) REFERENCES representants(NUM_REPRESENTANT)
)ENGINE=InnoDB;



DELETE FROM  REPRESENTANTS;
INSERT INTO REPRESENTANTS VALUES('03','Jones','Mary','123 Main','Grant','USA','49219','2150','0.05');
INSERT INTO REPRESENTANTS VALUES('06','Smith','William','102 Raymond','Ada','USA','49441','4912.5','0.07');
INSERT INTO REPRESENTANTS VALUES('12','Diaz','Miguel','419 Harper','Lansing','USA','49224','2150','0.05');

DELETE FROM  CLIENTS;
## on insère pas les champs en auto incrementation
INSERT INTO CLIENTS (NOM, PRENOM, ADRESSE, VILLE, ETAT, CODE_POSTAL, SOLDE, LIMITE_CREDIT, NUM_REPRESENTANT)
VALUES('Adams','Sally','481 Oak','Lansing','USA','49224','818.75','1000','03'),
('Samuels','Ann','215 Pete','Grant','USA','49219','21.5','1500','06'),
('Charles','Don','48  College','Ira','USA','49034','825.75','1000','12');

