-- Schema DDL
CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO orders (o_id, o_date) VALUES (1, '1997-06-30');
INSERT INTO orders (o_id, o_date) VALUES (2, '1997-07-01');
INSERT INTO orders (o_id, o_date) VALUES (3, '1997-07-02');
INSERT INTO orders (o_id, o_date) VALUES (4, '1997-08-15');
INSERT INTO orders (o_id, o_date) VALUES (5, '1997-09-30');
INSERT INTO orders (o_id, o_date) VALUES (6, '1997-10-01');
INSERT INTO orders (o_id, o_date) VALUES (7, '1997-10-02');
INSERT INTO orders (o_id, o_date) VALUES (8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM orders WHERE o_date > '1997-07-01' AND o_date < '1997-10-01';

/*
Gold Result:
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT o_id FROM orders WHERE o_date >= '1997-07-01' AND o_date < '1997-10-01';

/*
Prediction Result:
(2,)
(3,)
(4,)
(5,)
*/