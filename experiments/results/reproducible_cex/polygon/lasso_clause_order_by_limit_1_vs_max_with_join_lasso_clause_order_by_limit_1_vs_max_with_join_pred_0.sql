-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, A REAL, B REAL, C TEXT);

CREATE TABLE T2 (id INTEGER PRIMARY KEY, C TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "T1" ("id", "a", "b", "c") VALUES (7, -635, 1, 'Alameda');
INSERT INTO "T1" ("id", "a", "b", "c") VALUES (21, -634, 1, 'Alameda20');
INSERT INTO "T2" ("id", "c") VALUES (7, 'Alameda');
INSERT INTO "T2" ("id", "c") VALUES (21, 'Alameda');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A / B FROM T1 WHERE C = 'Alameda' ORDER BY A / B DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(-635.0,)
*/

-- Prediction Query
SELECT MAX(T1.A / T1.B) FROM T1 INNER JOIN T2 ON T1.id = T2.id WHERE T2.C = 'Alameda';

/*
Prediction Result:
(-634.0,)
*/