-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (29, NULL, NULL);
INSERT INTO "Person" ("personid", "firstname", "lastname") VALUES (20, NULL, NULL);
INSERT INTO "Address" ("addressid", "personid", "city", "state") VALUES (19, 20, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, None, None, None)
(None, None, None, None)
*/

-- Prediction Query
SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID UNION SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID;

/*
Prediction Result:
(None, None, None, None)
*/