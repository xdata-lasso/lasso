-- Schema DDL
CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_comment TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "orders" ("o_id", "o_comment") VALUES (1002, 'pendingaccounts');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM orders WHERE o_comment NOT LIKE '%pending%accounts%';

/*
Gold Result:
*/

-- Prediction Query
SELECT o_id FROM orders WHERE o_comment NOT LIKE '_pending%accounts%';

/*
Prediction Result:
(1002,)
*/