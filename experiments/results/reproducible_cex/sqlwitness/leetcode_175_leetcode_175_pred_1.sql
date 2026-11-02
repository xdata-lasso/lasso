-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (0, NULL, 'default1'), (1, NULL, NULL), (2, NULL, NULL), (3, NULL, 'default2'), (4, 'default1', NULL), (5, 'default2', 'default2'), (6, NULL, NULL), (7, 'default2', NULL), (8, NULL, 'default1');
INSERT INTO address (addressid, personid, city, state) VALUES (0, NULL, 'default1', 'default2'), (1, 0, NULL, NULL), (2, 1, 'default2', 'default1'), (3, 2, 'default1', 'default2'), (4, 3, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, 'default1', None, None)
(None, None, 'default2', 'default1')
(None, None, 'default1', 'default2')
(None, 'default2', 'default1', 'default2')
('default1', None, None, None)
('default2', 'default2', None, None)
(None, None, None, None)
('default2', None, None, None)
(None, 'default1', None, None)
*/

-- Prediction Query
SELECT DISTINCT A.FIRSTNAME, A.LASTNAME, B.CITY, B.STATE FROM PERSON AS A LEFT JOIN ADDRESS AS B ON A.PERSONID = B.PERSONID;

/*
Prediction Result:
(None, 'default1', None, None)
(None, None, 'default2', 'default1')
(None, None, 'default1', 'default2')
(None, 'default2', 'default1', 'default2')
('default1', None, None, None)
('default2', 'default2', None, None)
(None, None, None, None)
('default2', None, None, None)
*/