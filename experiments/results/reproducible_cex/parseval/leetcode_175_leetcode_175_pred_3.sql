-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'per_49c8a1', 'per_dd0496');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (0, 'per_49c8a1', 'per_dd0496');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'per_ef11df', 'per_a4ab58');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'per_ef11df', 'per_a4ab58');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'add_7bf3e8', 'add_7796c4');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 2, 'add_7bf3e8', 'add_7796c4');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483646, 0, 'add_7bf3e8', 'add_7796c4');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483645, 5, 'add_6a2889', 'add_82e62c');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (9, 3, 'add_c3c151', 'add_139c07');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (10, 4, 'add_c3c151', 'add_139c07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('per_49c8a1', 'per_dd0496', 'add_7bf3e8', 'add_7796c4')
('per_49c8a1', 'per_dd0496', 'add_7bf3e8', 'add_7796c4')
('per_c42b68', 'per_d2b753', 'add_7bf3e8', 'add_7796c4')
('per_ef11df', 'per_a4ab58', 'add_c3c151', 'add_139c07')
('per_ef11df', 'per_a4ab58', 'add_c3c151', 'add_139c07')
('per_c42b68', 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT FIRSTNAME, LASTNAME, CITY, STATE FROM PERSON LEFT JOIN ADDRESS ON PERSON.PERSONID = ADDRESS.PERSONID WHERE PERSON.PERSONID > 0;

/*
Prediction Result:
('per_49c8a1', 'per_dd0496', 'add_7bf3e8', 'add_7796c4')
('per_c42b68', 'per_d2b753', 'add_7bf3e8', 'add_7796c4')
('per_ef11df', 'per_a4ab58', 'add_c3c151', 'add_139c07')
('per_ef11df', 'per_a4ab58', 'add_c3c151', 'add_139c07')
('per_c42b68', 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/