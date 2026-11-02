-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_c80f88', 'p_s_82dcdc');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'p_s_c80f88', 'p_s_82dcdc');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_2ad7d6', 'p_s_618125');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_2ad7d6', 'p_s_618125');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_331e94', 'a_s_22f898');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 2, 'a_s_331e94', 'a_s_22f898');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_a47577', 'a_s_5919fb');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_a47577', 'a_s_5919fb');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_c80f88', 'p_s_82dcdc', 'a_s_331e94', 'a_s_22f898')
('per_c42b68', 'per_d2b753', 'a_s_331e94', 'a_s_22f898')
('p_s_c80f88', 'p_s_82dcdc', None, None)
('p_s_2ad7d6', 'p_s_618125', 'a_s_a47577', 'a_s_5919fb')
('p_s_2ad7d6', 'p_s_618125', 'a_s_a47577', 'a_s_5919fb')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT P.LASTNAME, P.FIRSTNAME, IIF(EXISTS(SELECT PERSONID FROM ADDRESS WHERE PERSONID = P.PERSONID), (SELECT CITY FROM ADDRESS WHERE PERSONID = P.PERSONID), NULL) AS CITY, IIF(EXISTS(SELECT PERSONID FROM ADDRESS WHERE PERSONID = P.PERSONID), (SELECT STATE FROM ADDRESS WHERE PERSONID = P.PERSONID), NULL) AS STATE FROM PERSON AS P;

/*
Prediction Result:
('p_s_82dcdc', 'p_s_c80f88', 'a_s_331e94', 'a_s_22f898')
('per_d2b753', 'per_c42b68', 'a_s_331e94', 'a_s_22f898')
('p_s_82dcdc', 'p_s_c80f88', None, None)
('p_s_618125', 'p_s_2ad7d6', 'a_s_a47577', 'a_s_5919fb')
('p_s_618125', 'p_s_2ad7d6', 'a_s_a47577', 'a_s_5919fb')
('per_d2b753', None, 'add_6a2889', 'add_82e62c')
*/