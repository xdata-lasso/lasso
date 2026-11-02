-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, A REAL, B REAL, C TEXT);

CREATE TABLE T2 (id INTEGER PRIMARY KEY, C TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO T1 (id, A, B, C) VALUES (1, 20.0, 10.0, 'Alameda');
INSERT INTO T1 (id, A, B, C) VALUES (2, 7.0, 2.0, 'Alameda');
INSERT INTO T1 (id, A, B, C) VALUES (3, 2.0, 8.0, 'Alameda');
INSERT INTO T1 (id, A, B, C) VALUES (4, 100.0, 1.0, 'Oakland');
INSERT INTO T1 (id, A, B, C) VALUES (5, 50.0, 1.0, 'alameda');
INSERT INTO T1 (id, A, B, C) VALUES (6, 60.0, 1.0, 'Alameda City');
INSERT INTO T1 (id, A, B, C) VALUES (7, 80.0, 1.0, NULL);
INSERT INTO T2 (id, C) VALUES (1, 'Alameda');
INSERT INTO T2 (id, C) VALUES (4, 'Oakland');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A / B FROM T1 WHERE C = 'Alameda' ORDER BY A / B DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(3.5,)
*/

-- Prediction Query
SELECT MAX(T1.A / T1.B) FROM T1 INNER JOIN T2 ON T1.id = T2.id WHERE T2.C = 'Alameda';

/*
Prediction Result:
(2.0,)
*/