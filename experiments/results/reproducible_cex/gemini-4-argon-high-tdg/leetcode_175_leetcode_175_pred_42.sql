-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (1, 'John', 'Smith');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (2, 'John', 'Smith');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (3, 'Jane', 'Doe');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (4, 'Jane', 'Doe');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (5, 'Alex', 'Taylor');
INSERT INTO Person (PersonId, FirstName, LastName) VALUES (6, 'Alex', 'Taylor');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (101, 1, 'Chicago', 'IL');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (102, 2, 'Chicago', 'IL');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (103, 5, 'Austin', 'TX');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES (104, 6, 'Dallas', 'TX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('John', 'Smith', 'Chicago', 'IL')
('John', 'Smith', 'Chicago', 'IL')
('Jane', 'Doe', None, None)
('Jane', 'Doe', None, None)
('Alex', 'Taylor', 'Austin', 'TX')
('Alex', 'Taylor', 'Dallas', 'TX')
*/

-- Prediction Query
SELECT PERSON.FIRSTNAME, PERSON.LASTNAME, ADDRESS.CITY, ADDRESS.STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID GROUP BY PERSON.FIRSTNAME, PERSON.LASTNAME;

/*
Prediction Result:
('Alex', 'Taylor', 'Austin', 'TX')
('Jane', 'Doe', None, None)
('John', 'Smith', 'Chicago', 'IL')
*/