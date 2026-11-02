-- Schema DDL
CREATE TABLE "customer" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "referee_id" INTEGER, FOREIGN KEY ("referee_id") REFERENCES "customer" ("id"), CHECK ("referee_id" <> 'customer.id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customer (id, name, referee_id) VALUES (1, 'Will', NULL);
INSERT INTO customer (id, name, referee_id) VALUES (2, 'Jane', NULL);
INSERT INTO customer (id, name, referee_id) VALUES (3, 'Alex', 2);
INSERT INTO customer (id, name, referee_id) VALUES (4, 'Bill', 1);
INSERT INTO customer (id, name, referee_id) VALUES (5, 'Zack', 3);
INSERT INTO customer (id, name, referee_id) VALUES (6, 'Mark', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

/*
Gold Result:
('Will',)
('Jane',)
('Bill',)
('Zack',)
*/

-- Prediction Query
SELECT NAME FROM CUSTOMER WHERE COALESCE(REFEREE_ID, 1) <> '2';

/*
Prediction Result:
('Will',)
('Jane',)
('Alex',)
('Bill',)
('Zack',)
('Mark',)
*/