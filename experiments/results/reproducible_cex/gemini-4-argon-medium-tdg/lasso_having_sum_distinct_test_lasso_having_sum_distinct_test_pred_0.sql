-- Schema DDL
CREATE TABLE items (o_id INTEGER, line_id INTEGER, qty REAL, PRIMARY KEY (o_id, line_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests SUM(DISTINCT qty) vs SUM(qty), and duplicate elimination (SELECT DISTINCT vs GROUP BY) when single items exceed 300.
INSERT INTO items (o_id, line_id, qty) VALUES (10, 1, 160.0);
INSERT INTO items (o_id, line_id, qty) VALUES (10, 2, 160.0);
INSERT INTO items (o_id, line_id, qty) VALUES (20, 1, 350.0);
INSERT INTO items (o_id, line_id, qty) VALUES (20, 2, 350.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(qty) > 300;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(DISTINCT qty) > 300;

/*
Prediction Result:
(20,)
*/