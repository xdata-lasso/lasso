-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (personid, firstname, lastname) VALUES (0, 'default2', 'default2'), (1, NULL, NULL);
INSERT INTO address (addressid, personid, city, state) VALUES (0, 1, 'default2', 'default2'), (1, 0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('default2', 'default2', None, 'default2')
(None, None, 'default2', 'default2')
*/

-- Prediction Query
SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID ORDER BY A.ADDRESSID, P.personid NULLS LAST;

/*
Prediction Result:
(None, None, 'default2', 'default2')
('default2', 'default2', None, 'default2')
*/