-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (1, 'Alice', 'Smith');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (2, 'Bob', 'Jones');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (2, 1, 'New York', 'NY');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('Alice', 'Smith', 'New York', 'NY')
('Bob', 'Jones', None, None)
*/

-- Prediction Query
SELECT S.LASTNAME, S.FIRSTNAME, COALESCE(NULL, A.CITY) AS CITY, COALESCE(NULL, A.STATE) AS STATE FROM PERSON AS S LEFT JOIN ADDRESS AS A ON S.PERSONID = A.PERSONID;

/*
Prediction Result:
('Smith', 'Alice', 'New York', 'NY')
('Jones', 'Bob', None, None)
*/