-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (1, 'default1', 'default2'), (0, 'default2', NULL), (2, NULL, 'default1'), (3, 'default1', 'default2'), (4, 'default2', 'default1'), (5, NULL, 'default2'), (6, 'default1', NULL), (7, NULL, NULL), (8, 'default1', NULL), (9, 'default2', 'default2'), (10, 'default1', 'default1'), (11, NULL, 'default1'), (12, 'default1', NULL), (13, 'default2', 'default2'), (14, 'default1', 'default1');
INSERT INTO address (addressid, personid, city, state) VALUES (0, NULL, 'default1', NULL), (1, 0, 'default1', 'default1'), (2, 1, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('default2', None, 'default1', 'default1')
('default1', 'default2', 'default1', None)
(None, 'default1', None, None)
('default1', 'default2', None, None)
('default2', 'default1', None, None)
(None, 'default2', None, None)
('default1', None, None, None)
(None, None, None, None)
('default1', None, None, None)
('default2', 'default2', None, None)
('default1', 'default1', None, None)
(None, 'default1', None, None)
('default1', None, None, None)
('default2', 'default2', None, None)
('default1', 'default1', None, None)
*/

-- Prediction Query
SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID UNION SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID;

/*
Prediction Result:
(None, None, None, None)
(None, 'default1', None, None)
(None, 'default2', None, None)
('default1', None, None, None)
('default1', 'default1', None, None)
('default1', 'default2', None, None)
('default1', 'default2', 'default1', None)
('default2', None, 'default1', 'default1')
('default2', 'default1', None, None)
('default2', 'default2', None, None)
*/