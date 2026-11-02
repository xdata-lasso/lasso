-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (0, 'Curtis', 'Yang');
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1008, 'Curtis', 'Yang');
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (1006, 0, 'New Roberttown', 'Colorado');
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (1009, NULL, 'New Roberttown', 'Colorado');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('Curtis', 'Yang', 'New Roberttown', 'Colorado')
('Curtis', 'Yang', None, None)
*/

-- Prediction Query
SELECT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID WHERE PERSON.PERSONID > 0;

/*
Prediction Result:
('Curtis', 'Yang', None, None)
*/