-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (1, 'Alice', 'Smith');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (1, 1, 'New York', 'NY');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('Alice', 'Smith', 'New York', 'NY')
*/

-- Prediction Query
SELECT P.LASTNAME, P.FIRSTNAME, IIF(EXISTS(SELECT PERSONID FROM ADDRESS WHERE PERSONID = P.PERSONID), (SELECT CITY FROM ADDRESS WHERE PERSONID = P.PERSONID), NULL) AS CITY, IIF(EXISTS(SELECT PERSONID FROM ADDRESS WHERE PERSONID = P.PERSONID), (SELECT STATE FROM ADDRESS WHERE PERSONID = P.PERSONID), NULL) AS STATE FROM PERSON AS P;

/*
Prediction Result:
('Smith', 'Alice', 'New York', 'NY')
*/