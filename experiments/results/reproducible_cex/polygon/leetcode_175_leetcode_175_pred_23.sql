-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (12, NULL, '19');
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (13, '24', '24');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (11, 13, '20', NULL);
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (10, 12, '22', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, '19', '22', None)
('24', '24', '20', None)
*/

-- Prediction Query
SELECT PERSON.LASTNAME, PERSON.FIRSTNAME, ADDRESS.CITY, ADDRESS.STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('19', None, '22', None)
('24', '24', '20', None)
*/