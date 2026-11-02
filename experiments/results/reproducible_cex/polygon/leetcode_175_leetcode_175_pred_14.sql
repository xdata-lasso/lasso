-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (12, NULL, NULL);
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (13, NULL, NULL);
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (11, 13, '20', '21');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (10, 12, '20', '21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, None, '20', '21')
(None, None, '20', '21')
*/

-- Prediction Query
SELECT CITY, FIRSTNAME, LASTNAME, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('20', None, None, '21')
('20', None, None, '21')
*/