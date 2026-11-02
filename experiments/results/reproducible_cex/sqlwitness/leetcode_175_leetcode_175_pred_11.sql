-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (1, 'default2', 'default2'), (0, NULL, 'default1'), (2, NULL, 'default2');
INSERT INTO address (addressid, personid, city, state) VALUES (0, 1, 'default2', 'default1'), (1, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, 'default1', None, None)
('default2', 'default2', 'default2', 'default1')
(None, 'default2', None, None)
*/

-- Prediction Query
SELECT CITY, FIRSTNAME, LASTNAME, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
(None, None, 'default1', None)
('default2', 'default2', 'default2', 'default1')
(None, None, 'default2', None)
*/