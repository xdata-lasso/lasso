-- Schema DDL
CREATE TABLE "customer" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "referee_id" INTEGER, FOREIGN KEY ("referee_id") REFERENCES "customer" ("id"), CHECK ("referee_id" <> 'customer.id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO customer (id, name, referee_id) VALUES (1, '2', NULL);
INSERT INTO customer (id, name, referee_id) VALUES (2, NULL, 1);
INSERT INTO customer (id, name, referee_id) VALUES (3, '', 2);
INSERT INTO customer (id, name, referee_id) VALUES (4, 'ValidEmptyRef', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

/*
Gold Result:
('2',)
(None,)
('ValidEmptyRef',)
*/

-- Prediction Query
SELECT C1.NAME AS NAME FROM CUSTOMER AS C1 LEFT JOIN CUSTOMER AS C2 ON C1.REFEREE_ID = C2.ID WHERE C2.NAME IS NULL OR C2.ID <> 2;

/*
Prediction Result:
('2',)
(None,)
('',)
('ValidEmptyRef',)
*/