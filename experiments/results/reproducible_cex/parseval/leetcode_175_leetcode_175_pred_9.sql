-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_fc8e42', 'p_s_d2396e');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'p_s_fc8e42', 'p_s_d2396e');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_f34bc1', 'p_s_5676ed');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_f34bc1', 'p_s_5676ed');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_54efaf', 'a_s_5689f8');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 2, 'a_s_54efaf', 'a_s_5689f8');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_f04a8c', 'a_s_917a4a');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_f04a8c', 'a_s_917a4a');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_fc8e42', 'p_s_d2396e', 'a_s_54efaf', 'a_s_5689f8')
('per_c42b68', 'per_d2b753', 'a_s_54efaf', 'a_s_5689f8')
('p_s_fc8e42', 'p_s_d2396e', None, None)
('p_s_f34bc1', 'p_s_5676ed', 'a_s_f04a8c', 'a_s_917a4a')
('p_s_f34bc1', 'p_s_5676ed', 'a_s_f04a8c', 'a_s_917a4a')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT P.LASTNAME, P.FIRSTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT OUTER JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID;

/*
Prediction Result:
('p_s_d2396e', 'p_s_fc8e42', 'a_s_54efaf', 'a_s_5689f8')
('per_d2b753', 'per_c42b68', 'a_s_54efaf', 'a_s_5689f8')
('p_s_d2396e', 'p_s_fc8e42', None, None)
('p_s_5676ed', 'p_s_f34bc1', 'a_s_f04a8c', 'a_s_917a4a')
('p_s_5676ed', 'p_s_f34bc1', 'a_s_f04a8c', 'a_s_917a4a')
('per_d2b753', None, 'add_6a2889', 'add_82e62c')
*/