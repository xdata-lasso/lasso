-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (14, '21', NULL);
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (13, NULL, '14', '14');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (12, 14, '19', '20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('21', None, '19', '20')
*/

-- Prediction Query
SELECT S.LASTNAME, S.FIRSTNAME, COALESCE(NULL, A.CITY) AS CITY, COALESCE(NULL, A.STATE) AS STATE FROM PERSON AS S LEFT JOIN ADDRESS AS A ON S.PERSONID = A.PERSONID;

/*
Prediction Result:
(None, '21', '19', '20')
*/