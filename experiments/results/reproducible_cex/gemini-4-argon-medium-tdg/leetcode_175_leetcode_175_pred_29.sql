-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (1, 'Charlie', 'Brown');
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (2, 'Charlie', 'Brown');
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (3, 'David', 'Clark');
INSERT INTO "Person" ("PersonId", "FirstName", "LastName") VALUES (4, 'David', 'Clark');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (101, 1, 'Austin', 'TX');
INSERT INTO "Address" ("AddressId", "PersonId", "City", "State") VALUES (102, 2, 'Austin', 'TX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('Charlie', 'Brown', 'Austin', 'TX')
('Charlie', 'Brown', 'Austin', 'TX')
('David', 'Clark', None, None)
('David', 'Clark', None, None)
*/

-- Prediction Query
SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID UNION SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID;

/*
Prediction Result:
('Charlie', 'Brown', 'Austin', 'TX')
('David', 'Clark', None, None)
*/