-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (1, 'John', 'Doe');
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (2, 'John', 'Doe');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('John', 'Doe', None, None)
('John', 'Doe', None, None)
*/

-- Prediction Query
SELECT DISTINCT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('John', 'Doe', None, None)
*/