-- Schema DDL
CREATE TABLE "customer" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "referee_id" INTEGER, FOREIGN KEY ("referee_id") REFERENCES "customer" ("id"), CHECK ("referee_id" <> 'customer.id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (id, name, referee_id) VALUES (1, 'default2', 3), (0, 'default1', NULL), (3, NULL, 2), (2, 'default2', 3), (4, 'default1', 0), (5, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

/*
Gold Result:
('default1',)
('default2',)
('default2',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM CUSTOMER WHERE REFEREE_ID <> 2 OR REFEREE_ID IS NULL ORDER BY NAME, CUSTOMER.id NULLS LAST;

/*
Prediction Result:
('default1',)
('default1',)
('default2',)
('default2',)
('default2',)
*/