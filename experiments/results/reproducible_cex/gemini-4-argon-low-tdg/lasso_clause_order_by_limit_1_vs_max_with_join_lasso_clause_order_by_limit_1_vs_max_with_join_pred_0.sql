-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, A REAL, B REAL, C TEXT);

CREATE TABLE T2 (id INTEGER PRIMARY KEY, C TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO T1 (id, A, B, C) VALUES (1, 100.0, 2.0, 'Los Angeles');
INSERT INTO T1 (id, A, B, C) VALUES (2, 10.0, 2.0, 'Alameda');
INSERT INTO T1 (id, A, B, C) VALUES (3, 15.0, 2.0, 'Alameda');
INSERT INTO T1 (id, A, B, C) VALUES (4, 8.0, 4.0, 'Alameda');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A / B FROM T1 WHERE C = 'Alameda' ORDER BY A / B DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(7.5,)
*/

-- Prediction Query
SELECT MAX(T1.A / T1.B) FROM T1 INNER JOIN T2 ON T1.id = T2.id WHERE T2.C = 'Alameda';

/*
Prediction Result:
(None,)
*/