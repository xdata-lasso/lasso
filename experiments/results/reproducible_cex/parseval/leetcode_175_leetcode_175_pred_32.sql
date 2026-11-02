-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_9a65ab', 'p_s_a0dd7c');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'p_s_9a65ab', 'p_s_a0dd7c');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_824f89', 'p_s_b26453');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_824f89', 'p_s_b26453');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_85b9f4', 'a_s_77e4b3');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 3, 'a_s_85b9f4', 'a_s_77e4b3');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_97b79e', 'a_s_1d327a');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_97b79e', 'a_s_1d327a');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_9a65ab', 'p_s_a0dd7c', 'a_s_85b9f4', 'a_s_77e4b3')
('p_s_9a65ab', 'p_s_a0dd7c', None, None)
('per_c42b68', 'per_d2b753', 'a_s_85b9f4', 'a_s_77e4b3')
('p_s_824f89', 'p_s_b26453', 'a_s_97b79e', 'a_s_1d327a')
('p_s_824f89', 'p_s_b26453', 'a_s_97b79e', 'a_s_1d327a')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID UNION SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE FROM PERSON AS P LEFT JOIN ADDRESS AS A ON P.PERSONID = A.PERSONID;

/*
Prediction Result:
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
('p_s_824f89', 'p_s_b26453', 'a_s_97b79e', 'a_s_1d327a')
('p_s_9a65ab', 'p_s_a0dd7c', None, None)
('p_s_9a65ab', 'p_s_a0dd7c', 'a_s_85b9f4', 'a_s_77e4b3')
('per_c42b68', 'per_d2b753', 'a_s_85b9f4', 'a_s_77e4b3')
*/