-- Schema DDL
CREATE TABLE "customer" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "referee_id" INTEGER, FOREIGN KEY ("referee_id") REFERENCES "customer" ("id"), CHECK ("referee_id" <> 'customer.id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customer (id, name, referee_id) VALUES (1, 'Alice', NULL);
INSERT INTO customer (id, name, referee_id) VALUES (2, 'Bob', 1);
INSERT INTO customer (id, name, referee_id) VALUES (3, 'Charlie', 2);
INSERT INTO customer (id, name, referee_id) VALUES (4, 'David', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

/*
Gold Result:
('Alice',)
('Bob',)
('David',)
*/

-- Prediction Query
SELECT NAME FROM CUSTOMER WHERE COALESCE(REFEREE_ID, 1) <> '2';

/*
Prediction Result:
('Alice',)
('Bob',)
('Charlie',)
('David',)
*/