-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (1, 'default2', NULL), (0, NULL, 'default1'), (2, 'default2', NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (1, 0, 'default2', NULL), (0, NULL, NULL, 'default1'), (2, 1, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, 'default1', 'default2', None)
('default2', None, 'default1', 'default1')
('default2', None, None, None)
*/

-- Prediction Query
SELECT P.FIRSTNAME AS FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID ORDER BY P.FIRSTNAME, P.personid NULLS LAST, A.addressid NULLS LAST;

/*
Prediction Result:
(None, 'default1', 'default2', None)
('default2', None, 'default1', 'default1')
('default2', None, None, None)
*/