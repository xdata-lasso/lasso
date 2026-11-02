-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (15, '21', '22');
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (16, '21', '22');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (14, 16, '23', '24');
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (13, 15, '23', '24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('21', '22', '23', '24')
('21', '22', '23', '24')
*/

-- Prediction Query
SELECT DISTINCT A.FIRSTNAME, A.LASTNAME, B.CITY, B.STATE FROM PERSON AS A LEFT JOIN ADDRESS AS B ON A.PERSONID = B.PERSONID;

/*
Prediction Result:
('21', '22', '23', '24')
*/