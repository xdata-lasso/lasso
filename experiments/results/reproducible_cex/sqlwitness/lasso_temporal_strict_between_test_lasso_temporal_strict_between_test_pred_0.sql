-- Schema DDL
CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (o_id, o_date) VALUES (0, '1997-10-01'), (1, '1997-07-01'), (2, '1997-06-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM orders WHERE o_date > '1997-07-01' AND o_date < '1997-10-01';

/*
Gold Result:
*/

-- Prediction Query
SELECT o_id FROM orders WHERE o_date >= '1997-07-01' AND o_date < '1997-10-01';

/*
Prediction Result:
(1,)
*/