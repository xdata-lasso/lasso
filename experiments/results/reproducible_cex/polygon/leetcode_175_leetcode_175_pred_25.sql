-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (14, '19', '20');
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (13, '19', '20');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (12, 14, '21', '22');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (11, 13, '21', '22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('19', '20', '21', '22')
('19', '20', '21', '22')
*/

-- Prediction Query
SELECT DISTINCT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('19', '20', '21', '22')
*/