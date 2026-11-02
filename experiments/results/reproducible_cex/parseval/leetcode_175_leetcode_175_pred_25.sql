-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_0026eb', 'p_s_525ddb');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'p_s_0026eb', 'p_s_525ddb');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_d6e792', 'p_s_f0e062');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_d6e792', 'p_s_f0e062');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_884159', 'a_s_00867e');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 2, 'a_s_884159', 'a_s_00867e');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_f9a0e3', 'a_s_7b9aa8');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_f9a0e3', 'a_s_7b9aa8');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_0026eb', 'p_s_525ddb', 'a_s_884159', 'a_s_00867e')
('per_c42b68', 'per_d2b753', 'a_s_884159', 'a_s_00867e')
('p_s_0026eb', 'p_s_525ddb', None, None)
('p_s_d6e792', 'p_s_f0e062', 'a_s_f9a0e3', 'a_s_7b9aa8')
('p_s_d6e792', 'p_s_f0e062', 'a_s_f9a0e3', 'a_s_7b9aa8')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT DISTINCT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID;

/*
Prediction Result:
('p_s_0026eb', 'p_s_525ddb', 'a_s_884159', 'a_s_00867e')
('per_c42b68', 'per_d2b753', 'a_s_884159', 'a_s_00867e')
('p_s_0026eb', 'p_s_525ddb', None, None)
('p_s_d6e792', 'p_s_f0e062', 'a_s_f9a0e3', 'a_s_7b9aa8')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/