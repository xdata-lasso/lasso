-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, A REAL, B REAL, C TEXT);

CREATE TABLE T2 (id INTEGER PRIMARY KEY, C TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: t1 --
INSERT INTO "t1" ("id", "a", "b", "c") VALUES (1, 1.0, 1.0, 'Alameda');

INSERT INTO "t1" ("id", "a", "b", "c") VALUES (-2147483647, 1.0, 1.0, 'Alameda');

INSERT INTO "t1" ("id", "a", "b", "c") VALUES (-2147483646, 1.0, 1.0, 'Alameda');

INSERT INTO "t1" ("id", "a", "b", "c") VALUES (-2147483645, 1.0, 1.0, 'Alameda');

INSERT INTO "t1" ("id", "a", "b", "c") VALUES (2, 582.588439, 680.190136, 't1__2e647e');

INSERT INTO "t1" ("id", "a", "b", "c") VALUES (3, 487.053947, 486.033807, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A / B FROM T1 WHERE C = 'Alameda' ORDER BY A / B DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT MAX(T1.A / T1.B) FROM T1 INNER JOIN T2 ON T1.id = T2.id WHERE T2.C = 'Alameda';

/*
Prediction Result:
(None,)
*/