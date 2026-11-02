-- Schema DDL
CREATE TABLE items (o_id INTEGER, line_id INTEGER, qty REAL, PRIMARY KEY (o_id, line_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (o_id, line_id, qty) VALUES (1, 1, 200.0);
INSERT INTO items (o_id, line_id, qty) VALUES (1, 2, 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(qty) > 300;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(DISTINCT qty) > 300;

/*
Prediction Result:
*/