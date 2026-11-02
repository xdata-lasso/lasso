-- Schema DDL
CREATE TABLE nation (n_id INTEGER PRIMARY KEY, n_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: nation --
INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483648, 'FRANCE');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483647, 'ARGENTINA');

INSERT INTO "nation" ("n_id", "n_name") VALUES (2, 'FRANCE');

INSERT INTO "nation" ("n_id", "n_name") VALUES (3, 'FRANCE');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483646, 'ARGENTINA');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483643, 'n1__c21ea0');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483642, 'ARGENTINA');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483641, 'FRANCE');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483640, 'n2__6c5510');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483639, 'FRANCE');

INSERT INTO "nation" ("n_id", "n_name") VALUES (-2147483638, 'ARGENTINA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n1.n_name, n2.n_name FROM nation AS n1 CROSS JOIN nation AS n2 WHERE n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA';

/*
Gold Result:
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
('FRANCE', 'ARGENTINA')
*/

-- Prediction Query
SELECT n1.n_name, n2.n_name FROM nation AS n1 CROSS JOIN nation AS n2 WHERE n1.n_name = 'FRANCE' AND n2.n_name = 'FRANCE';

/*
Prediction Result:
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
('FRANCE', 'FRANCE')
*/