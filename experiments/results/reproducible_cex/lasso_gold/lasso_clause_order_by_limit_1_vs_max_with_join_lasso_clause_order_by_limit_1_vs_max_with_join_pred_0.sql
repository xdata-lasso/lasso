-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, A REAL, B REAL, C TEXT);

CREATE TABLE T2 (id INTEGER PRIMARY KEY, C TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "t1" ("id", "a", "b", "c") VALUES (1001, 1005.5, 1009.5, 'Alameda');
INSERT INTO "t1" ("id", "a", "b", "c") VALUES (1002, 1010.5, 1016.5, 'Alameda');
INSERT INTO "t1" ("id", "a", "b", "c") VALUES (1003, 1015.5, 1023.5, 'Alameda');
INSERT INTO "t1" ("id", "a", "b", "c") VALUES (1004, 1020.5, 1030.5, 'Alameda');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A / B FROM T1 WHERE C = 'Alameda' ORDER BY A / B DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(0.9960376423972264,)
*/

-- Prediction Query
SELECT MAX(T1.A / T1.B) FROM T1 INNER JOIN T2 ON T1.id = T2.id WHERE T2.C = 'Alameda';

/*
Prediction Result:
(None,)
*/