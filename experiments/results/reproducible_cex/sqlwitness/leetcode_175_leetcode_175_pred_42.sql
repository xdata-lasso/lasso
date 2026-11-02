-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (0, NULL, NULL), (1, 'default2', 'default2'), (2, NULL, NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (1, NULL, 'default1', 'default2'), (0, 0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
(None, None, 'default1', 'default1')
('default2', 'default2', None, None)
(None, None, None, None)
*/

-- Prediction Query
SELECT PERSON.FIRSTNAME, PERSON.LASTNAME, ADDRESS.CITY, ADDRESS.STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID GROUP BY PERSON.FIRSTNAME, PERSON.LASTNAME;

/*
Prediction Result:
(None, None, 'default1', 'default1')
('default2', 'default2', None, None)
*/