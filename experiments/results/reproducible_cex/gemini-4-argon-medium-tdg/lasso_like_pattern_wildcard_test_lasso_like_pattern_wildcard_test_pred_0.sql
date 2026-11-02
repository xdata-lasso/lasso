-- Schema DDL
CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_comment TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO orders (o_id, o_comment) VALUES (1, 'pendingaccounts');
INSERT INTO orders (o_id, o_comment) VALUES (2, 'pending accounts');
INSERT INTO orders (o_id, o_comment) VALUES (3, 'the pending accounts are here');
INSERT INTO orders (o_id, o_comment) VALUES (4, 'pendingsomethingaccounts');
INSERT INTO orders (o_id, o_comment) VALUES (5, 'accounts pending');
INSERT INTO orders (o_id, o_comment) VALUES (6, 'only pending here');
INSERT INTO orders (o_id, o_comment) VALUES (7, 'only accounts here');
INSERT INTO orders (o_id, o_comment) VALUES (8, 'normal order comment');
INSERT INTO orders (o_id, o_comment) VALUES (9, '');
INSERT INTO orders (o_id, o_comment) VALUES (10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM orders WHERE o_comment NOT LIKE '%pending%accounts%';

/*
Gold Result:
(5,)
(6,)
(7,)
(8,)
(9,)
*/

-- Prediction Query
SELECT o_id FROM orders WHERE o_comment NOT LIKE '_pending%accounts%';

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
(7,)
(8,)
(9,)
*/