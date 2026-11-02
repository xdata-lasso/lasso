-- Schema DDL
CREATE TABLE "customer" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "referee_id" INTEGER, FOREIGN KEY ("referee_id") REFERENCES "customer" ("id"), CHECK ("referee_id" <> 'customer.id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (id, name, referee_id) VALUES (2, 'Alice', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME FROM CUSTOMER WHERE COALESCE(REFEREE_ID, 1) <> '2';

/*
Prediction Result:
('Alice',)
*/