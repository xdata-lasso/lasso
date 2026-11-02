-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_b96de2', 'p_s_473225');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'p_s_b96de2', 'p_s_473225');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_64f86b', 'p_s_f5b751');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_64f86b', 'p_s_f5b751');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_95224e', 'a_s_08e734');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 3, 'a_s_95224e', 'a_s_08e734');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_3cde5b', 'a_s_7bc232');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_3cde5b', 'a_s_7bc232');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_b96de2', 'p_s_473225', 'a_s_95224e', 'a_s_08e734')
('p_s_b96de2', 'p_s_473225', None, None)
('per_c42b68', 'per_d2b753', 'a_s_95224e', 'a_s_08e734')
('p_s_64f86b', 'p_s_f5b751', 'a_s_3cde5b', 'a_s_7bc232')
('p_s_64f86b', 'p_s_f5b751', 'a_s_3cde5b', 'a_s_7bc232')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID GROUP BY 1, 2, 3, 4;

/*
Prediction Result:
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
('p_s_64f86b', 'p_s_f5b751', 'a_s_3cde5b', 'a_s_7bc232')
('p_s_b96de2', 'p_s_473225', None, None)
('p_s_b96de2', 'p_s_473225', 'a_s_95224e', 'a_s_08e734')
('per_c42b68', 'per_d2b753', 'a_s_95224e', 'a_s_08e734')
*/