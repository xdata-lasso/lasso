-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (-1, 'Neg', '');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (0, '', 'Zero');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (1, 'Same', 'Same');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (0, 0, '', 'StateZero');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (-5, 1, 'Same', 'Same');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('Neg', '', None, None)
('', 'Zero', '', 'StateZero')
('Same', 'Same', 'Same', 'Same')
*/

-- Prediction Query
SELECT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID WHERE PERSON.PERSONID > 0;

/*
Prediction Result:
('Same', 'Same', 'Same', 'Same')
*/