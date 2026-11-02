-- Schema DDL
CREATE TABLE items (o_id INTEGER, line_id INTEGER, qty REAL, PRIMARY KEY (o_id, line_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "items" ("o_id", "line_id", "qty") VALUES (4, 6, 151);
INSERT INTO "items" ("o_id", "line_id", "qty") VALUES (4, 5, 151);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(qty) > 300;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(DISTINCT qty) > 300;

/*
Prediction Result:
*/