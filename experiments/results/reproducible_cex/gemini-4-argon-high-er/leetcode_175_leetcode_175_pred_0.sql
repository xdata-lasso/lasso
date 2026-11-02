-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (1, 'John', 'Doe');
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (2, 'John', 'Doe');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (1, 1, 'NY', 'NY');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (2, 2, 'NY', 'NY');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('John', 'Doe', 'NY', 'NY')
('John', 'Doe', 'NY', 'NY')
*/

-- Prediction Query
SELECT DISTINCT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID;

/*
Prediction Result:
('John', 'Doe', 'NY', 'NY')
*/