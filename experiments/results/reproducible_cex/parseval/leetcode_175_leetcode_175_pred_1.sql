-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_cf64b4', 'p_s_94a586');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'p_s_cf64b4', 'p_s_94a586');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_77a5df', 'p_s_f891bd');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_77a5df', 'p_s_f891bd');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_3863f3', 'a_s_b3ce61');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 2, 'a_s_3863f3', 'a_s_b3ce61');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_60fe3b', 'a_s_cbb7c6');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_60fe3b', 'a_s_cbb7c6');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_cf64b4', 'p_s_94a586', 'a_s_3863f3', 'a_s_b3ce61')
('per_c42b68', 'per_d2b753', 'a_s_3863f3', 'a_s_b3ce61')
('p_s_cf64b4', 'p_s_94a586', None, None)
('p_s_77a5df', 'p_s_f891bd', 'a_s_60fe3b', 'a_s_cbb7c6')
('p_s_77a5df', 'p_s_f891bd', 'a_s_60fe3b', 'a_s_cbb7c6')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT DISTINCT A.FIRSTNAME, A.LASTNAME, B.CITY, B.STATE FROM PERSON AS A LEFT JOIN ADDRESS AS B ON A.PERSONID = B.PERSONID;

/*
Prediction Result:
('p_s_cf64b4', 'p_s_94a586', 'a_s_3863f3', 'a_s_b3ce61')
('per_c42b68', 'per_d2b753', 'a_s_3863f3', 'a_s_b3ce61')
('p_s_cf64b4', 'p_s_94a586', None, None)
('p_s_77a5df', 'p_s_f891bd', 'a_s_60fe3b', 'a_s_cbb7c6')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/