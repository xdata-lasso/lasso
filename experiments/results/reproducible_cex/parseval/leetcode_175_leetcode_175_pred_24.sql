-- Schema DDL
CREATE TABLE "Person" ("PersonId" INTEGER PRIMARY KEY, "FirstName" TEXT(255), "LastName" TEXT(255));

CREATE TABLE "Address" ("AddressId" INTEGER PRIMARY KEY, "PersonId" INTEGER, "City" TEXT(255), "State" TEXT(255), FOREIGN KEY ("PersonId") REFERENCES "Person" ("PersonId"), UNIQUE ("PersonId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (1, 'p_s_712173', 'p_s_5cf8a0');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (2, 'p_s_712173', 'p_s_5cf8a0');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (3, 'per_c42b68', 'per_d2b753');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (4, 'p_s_35ccbe', 'p_s_85ce1c');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (5, 'p_s_35ccbe', 'p_s_85ce1c');

INSERT INTO "person" ("personid", "firstname", "lastname") VALUES (6, NULL, 'per_d2b753');

-- Inserting into table: address --
INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483648, 1, 'a_s_0e8a25', 'a_s_e30728');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (-2147483647, 3, 'a_s_0e8a25', 'a_s_e30728');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (6, 4, 'a_s_56bc5c', 'a_s_ee38eb');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (7, 5, 'a_s_56bc5c', 'a_s_ee38eb');

INSERT INTO "address" ("addressid", "personid", "city", "state") VALUES (2, 6, 'add_6a2889', 'add_82e62c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname, city, state FROM person AS p LEFT OUTER JOIN address AS a ON p.personid = a.personid;

/*
Gold Result:
('p_s_712173', 'p_s_5cf8a0', 'a_s_0e8a25', 'a_s_e30728')
('p_s_712173', 'p_s_5cf8a0', None, None)
('per_c42b68', 'per_d2b753', 'a_s_0e8a25', 'a_s_e30728')
('p_s_35ccbe', 'p_s_85ce1c', 'a_s_56bc5c', 'a_s_ee38eb')
('p_s_35ccbe', 'p_s_85ce1c', 'a_s_56bc5c', 'a_s_ee38eb')
(None, 'per_d2b753', 'add_6a2889', 'add_82e62c')
*/

-- Prediction Query
SELECT S.LASTNAME, S.FIRSTNAME, COALESCE(NULL, A.CITY) AS CITY, COALESCE(NULL, A.STATE) AS STATE FROM PERSON AS S LEFT JOIN ADDRESS AS A ON S.PERSONID = A.PERSONID;

/*
Prediction Result:
('p_s_5cf8a0', 'p_s_712173', 'a_s_0e8a25', 'a_s_e30728')
('p_s_5cf8a0', 'p_s_712173', None, None)
('per_d2b753', 'per_c42b68', 'a_s_0e8a25', 'a_s_e30728')
('p_s_85ce1c', 'p_s_35ccbe', 'a_s_56bc5c', 'a_s_ee38eb')
('p_s_85ce1c', 'p_s_35ccbe', 'a_s_56bc5c', 'a_s_ee38eb')
('per_d2b753', None, 'add_6a2889', 'add_82e62c')
*/