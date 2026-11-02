-- Schema DDL
CREATE TABLE A (id INTEGER PRIMARY KEY);

CREATE TABLE B (a_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO a (id) VALUES (0), (1), (2), (3), (4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.id FROM A LEFT JOIN B ON A.id = B.a_id;

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
SELECT A.id FROM A INNER JOIN B ON A.id = B.a_id;

/*
Prediction Result:
*/