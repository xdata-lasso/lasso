-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (1, NULL, NULL), (0, 'default1', NULL), (2, 'default2', 'default1'), (3, 'default2', NULL), (4, NULL, NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (0, NULL, NULL, 'default2'), (1, 1, 'default2', NULL), (2, 0, 'default1', 'default1'), (3, 2, 'default2', 'default1'), (4, 3, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('default1', None, 'default1', 'default1')
(None, None, 'default2', None)
('default2', 'default1', 'default2', 'default1')
('default2', None, 'default2', None)
(None, None, None, None)
*/

-- Prediction Query
SELECT PERSON.FIRSTNAME, PERSON.LASTNAME, ADDRESS.CITY, ADDRESS.STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID ORDER BY PERSON.PERSONID, ADDRESS.addressid NULLS LAST;

/*
Prediction Result:
('default1', None, 'default1', 'default1')
(None, None, 'default2', None)
('default2', 'default1', 'default2', 'default1')
('default2', None, 'default2', None)
(None, None, None, None)
*/