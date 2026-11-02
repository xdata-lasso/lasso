-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (1, 'John', 'Doe');
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (2, 'John', 'Doe');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (100, 1, 'Seattle', 'WA');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (101, 2, 'Seattle', 'WA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('John', 'Doe', 'Seattle', 'WA')
('John', 'Doe', 'Seattle', 'WA')
*/

-- Prediction Query
SELECT PERSON.FIRSTNAME, PERSON.LASTNAME, ADDRESS.CITY, ADDRESS.STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID GROUP BY PERSON.FIRSTNAME, PERSON.LASTNAME;

/*
Prediction Result:
('John', 'Doe', 'Seattle', 'WA')
*/