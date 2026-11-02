-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (1, NULL, 'default2'), (0, 'default2', 'default2'), (2, 'default1', NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (1, 0, NULL, 'default2'), (0, 1, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('default2', 'default2', None, 'default2')
(None, 'default2', 'default2', 'default1')
('default1', None, None, None)
*/

-- Prediction Query
SELECT T1.FIRSTNAME, T1.LASTNAME, T2.CITY, T2.STATE FROM PERSON AS T1 LEFT JOIN ADDRESS AS T2 ON T1.PERSONID = T2.PERSONID ORDER BY T1.FIRSTNAME, T1.personid NULLS LAST, T2.addressid NULLS LAST;

/*
Prediction Result:
(None, 'default2', 'default2', 'default1')
('default1', None, None, None)
('default2', 'default2', None, 'default2')
*/