-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_47289f', 'p_s_c9673f');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'p_s_47289f', 'p_s_c9673f');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_e38278', 'p_s_abd3e6');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_e38278', 'p_s_abd3e6');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_4d4439', 'a_s_ac6f52');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 2, 'a_s_4d4439', 'a_s_ac6f52');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_4810cc', 'a_s_22238b');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_4810cc', 'a_s_22238b');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_47289f', 'p_s_c9673f', 'a_s_4d4439', 'a_s_ac6f52')
('per_c42b68', 'per_d2b753', 'a_s_4d4439', 'a_s_ac6f52')
('p_s_47289f', 'p_s_c9673f', None, None)
('p_s_e38278', 'p_s_abd3e6', 'a_s_4810cc', 'a_s_22238b')
('p_s_e38278', 'p_s_abd3e6', 'a_s_4810cc', 'a_s_22238b')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT PERSON.LASTNAME, PERSON.FIRSTNAME, ADDRESS.CITY, ADDRESS.STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('p_s_c9673f', 'p_s_47289f', 'a_s_4d4439', 'a_s_ac6f52')
('per_d2b753', 'per_c42b68', 'a_s_4d4439', 'a_s_ac6f52')
('p_s_c9673f', 'p_s_47289f', None, None)
('p_s_abd3e6', 'p_s_e38278', 'a_s_4810cc', 'a_s_22238b')
('p_s_abd3e6', 'p_s_e38278', 'a_s_4810cc', 'a_s_22238b')
('per_d2b753', None, 'add_6a2889', 'add_82e62c')
*/