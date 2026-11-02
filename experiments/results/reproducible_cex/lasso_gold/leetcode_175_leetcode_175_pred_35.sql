-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1001, 'Danielle', 'Johnson');
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (1002, 1001, 'Johnberg', 'West Virginia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('Danielle', 'Johnson', 'Johnberg', 'West Virginia')
*/

-- Prediction Query
SELECT P.LASTNAME, P.FIRSTNAME, IIF(EXISTS(SELECT PERSONID FROM ADDRESS WHERE PERSONID = P.PERSONID), (SELECT CITY FROM ADDRESS WHERE PERSONID = P.PERSONID), NULL) AS CITY, IIF(EXISTS(SELECT PERSONID FROM ADDRESS WHERE PERSONID = P.PERSONID), (SELECT STATE FROM ADDRESS WHERE PERSONID = P.PERSONID), NULL) AS STATE FROM PERSON AS P;

/*
Prediction Result:
('Johnson', 'Danielle', 'Johnberg', 'West Virginia')
*/