-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (1, 'default2', 'default2'), (0, 'default1', 'default1'), (2, 'default2', 'default2'), (3, NULL, 'default2'), (4, 'default1', 'default1'), (5, 'default2', 'default2'), (6, NULL, NULL), (7, 'default1', 'default2'), (8, NULL, 'default1'), (9, NULL, NULL), (10, NULL, 'default1'), (11, NULL, NULL), (12, 'default1', NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (1, 0, 'default2', 'default2'), (0, 1, NULL, NULL), (2, NULL, 'default1', 'default1'), (3, 2, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('default1', 'default1', 'default2', 'default2')
('default2', 'default2', None, None)
('default2', 'default2', 'default1', 'default1')
(None, 'default2', None, None)
('default1', 'default1', None, None)
('default2', 'default2', None, None)
(None, None, None, None)
('default1', 'default2', None, None)
(None, 'default1', None, None)
(None, None, None, None)
(None, 'default1', None, None)
(None, None, None, None)
('default1', None, None, None)
*/

-- Prediction Query
SELECT DISTINCT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('default1', 'default1', 'default2', 'default2')
('default2', 'default2', None, None)
('default2', 'default2', 'default1', 'default1')
(None, 'default2', None, None)
('default1', 'default1', None, None)
(None, None, None, None)
('default1', 'default2', None, None)
(None, 'default1', None, None)
('default1', None, None, None)
*/