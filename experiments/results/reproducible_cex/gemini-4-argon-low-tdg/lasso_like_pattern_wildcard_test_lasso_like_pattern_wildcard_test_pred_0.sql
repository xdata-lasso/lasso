-- Schema DDL
CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_comment TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO orders (o_id, o_comment) VALUES (1, 'pendingaccounts');
INSERT INTO orders (o_id, o_comment) VALUES (2, 'pending accounts');
INSERT INTO orders (o_id, o_comment) VALUES (3, 'urgent pending customer accounts');
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
(1,)
(2,)
(3,)
*/