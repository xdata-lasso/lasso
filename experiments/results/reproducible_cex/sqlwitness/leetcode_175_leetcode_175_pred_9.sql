-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (5, 'default2', 'default1'), (2, 'default2', 'default1'), (1, 'default2', 'default1'), (3, 'default1', 'default1'), (0, NULL, NULL), (4, 'default2', 'default1'), (6, 'default1', 'default2'), (7, 'default1', NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (5, 0, 'default1', 'default1'), (0, 5, 'default2', 'default1'), (4, 1, 'default2', 'default1'), (3, 2, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, None, 'default1', 'default1')
('default2', 'default1', 'default2', 'default1')
('default2', 'default1', 'default1', None)
('default1', 'default1', None, None)
('default2', 'default1', None, None)
('default2', 'default1', 'default2', 'default1')
('default1', 'default2', None, None)
('default1', None, None, None)
*/

-- Prediction Query
SELECT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID GROUP BY 1, 2, 3, 4;

/*
Prediction Result:
(None, None, 'default1', 'default1')
('default1', None, None, None)
('default1', 'default1', None, None)
('default1', 'default2', None, None)
('default2', 'default1', None, None)
('default2', 'default1', 'default1', None)
('default2', 'default1', 'default2', 'default1')
*/