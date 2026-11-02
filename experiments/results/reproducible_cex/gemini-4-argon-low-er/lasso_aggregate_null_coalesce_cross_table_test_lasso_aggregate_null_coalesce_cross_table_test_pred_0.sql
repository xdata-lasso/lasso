-- Schema DDL
CREATE TABLE chests (chest_id INTEGER PRIMARY KEY, amount INTEGER);

CREATE TABLE boxes (box_id INTEGER PRIMARY KEY, chest_id INTEGER REFERENCES chests (chest_id), amount INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO boxes (box_id, chest_id, amount) VALUES (1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(amount) FROM (SELECT amount FROM boxes UNION ALL SELECT c.amount FROM chests AS c INNER JOIN boxes AS b ON b.chest_id = c.chest_id);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(COALESCE(b.amount, 0) + COALESCE(c.amount, 0)) FROM boxes AS b LEFT JOIN chests AS c ON c.chest_id = b.chest_id;

/*
Prediction Result:
(0,)
*/