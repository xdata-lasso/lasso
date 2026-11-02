-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (0, 'default2', NULL), (1, NULL, NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (1, NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('default2', None, None, None)
(None, None, None, None)
*/

-- Prediction Query
SELECT S.LASTNAME, S.FIRSTNAME, COALESCE(NULL, A.CITY) AS CITY, COALESCE(NULL, A.STATE) AS STATE FROM PERSON AS S LEFT JOIN ADDRESS AS A ON S.PERSONID = A.PERSONID;

/*
Prediction Result:
(None, 'default2', None, None)
(None, None, None, None)
*/