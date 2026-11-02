-- Schema DDL
CREATE TABLE partsupp (ps_id INTEGER PRIMARY KEY, ps_cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: partsupp --
INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (1, 582.588439);

INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (-2147483647, NULL);

INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (-2147483646, NULL);

INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (-2147483645, NULL);

INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (-2147483644, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ps_id FROM partsupp WHERE ps_cost = (SELECT MIN(ps_cost) FROM partsupp);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT ps_id FROM partsupp;

/*
Prediction Result:
(-2147483647,)
(-2147483646,)
(-2147483645,)
(-2147483644,)
(1,)
*/