-- Schema DDL
CREATE TABLE items (o_id INTEGER, line_id INTEGER, qty REAL, PRIMARY KEY (o_id, line_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (o_id, line_id, qty) VALUES (0, 1, 0.0), (299, 300, 299.0), (300, 0, 0.0), (1, 301, NULL), (300, 299, 299.0), (0, 0, 299.0), (299, 1, NULL), (1, 1, 0.0), (299, 0, NULL), (299, 299, 300.0), (300, 301, 0.0), (1, 0, 0.0), (301, 300, 301.0), (299, 301, 300.0), (300, 1, 299.0), (300, 300, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(qty) > 300;

/*
Gold Result:
(299,)
(300,)
(301,)
*/

-- Prediction Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(DISTINCT qty) > 300;

/*
Prediction Result:
(299,)
(301,)
*/