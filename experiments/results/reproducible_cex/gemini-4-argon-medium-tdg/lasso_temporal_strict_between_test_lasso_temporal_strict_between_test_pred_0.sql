-- Schema DDL
CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO orders (o_id, o_date) VALUES (1, '1997-07-01');
INSERT INTO orders (o_id, o_date) VALUES (2, '1997-07-02');
INSERT INTO orders (o_id, o_date) VALUES (3, '1997-09-30');
INSERT INTO orders (o_id, o_date) VALUES (4, '1997-10-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM orders WHERE o_date > '1997-07-01' AND o_date < '1997-10-01';

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT o_id FROM orders WHERE o_date >= '1997-07-01' AND o_date < '1997-10-01';

/*
Prediction Result:
(1,)
(2,)
(3,)
*/